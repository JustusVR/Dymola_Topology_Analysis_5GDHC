
from buildingspy.io.outputfile import Reader
import os
import csv


def CreateResultCsv(matDirectory, matFileName, modelList, pipeList, upv_File, co2_rate_file, co2_pricing_file, startYear, lifetime, output_name):
    readVar = SetReadVar()
    printVar = SetPrintVar(readVar, pipeList, modelList)
    TA_data = ReadMat(matDirectory, matFileName, readVar, pipeList, modelList)
    for data in TA_data:
        E_ele = data['Buildings_elePumping'] + data['Buildings_eleHP_H'] + data['Buildings_eleHP_C']
        E_des_H = data['DES_inputEnergy_H']
        E_des_C = data['DES_inputEnergy_C']
        E_i = data['Buildings_inputEnergy_IH'] + data['Buildings_inputEnergy_IC']
        E_ele += E_i
        E_gas = E_des_H / 0.9
        data.update({"NPV": ADD_ELCCA(upv_File, co2_rate_file, co2_pricing_file, startYear, lifetime, E_ele, E_gas, data['Total_Pipe_Length'])})
    WriteCSV(TA_data, printVar, matDirectory, output_name)

def SetReadVar():
    # variables to read out of the .mat-File
    # readVar[x][0] is the name of the variable in the mat-File to be read
    # readVar[x][1] determines how to read the mat-File
    # readVar[x][2] is the name of the variable which will be shown in the output file
    readVar = [['Buildings_DH_Energy.y', 'max', 'Buildings_Q_DH'], \
                 ['Buildings_DC_Energy.y', 'max', 'Buildings_Q_DC'], \
                 ['Buildings_eleHP_heat_Energy.y', 'max', 'Buildings_eleHP_H'], \
                 ['Buildings_eleHP_cool_Energy.y', 'max', 'Buildings_eleHP_C'], \
                 ['Buildings_IH_Energy.y', 'max', 'Buildings_inputEnergy_IH'], \
                 ['Buildings_IC_Energy.y', 'max', 'Buildings_inputEnergy_IC'], \
                 ['Buildings_PumpingElectricity_Energy.y', 'max', 'Buildings_elePumping'], \
                 ['DES_heat_Energy.y', 'max', 'DES_inputEnergy_H'], \
                 ['DES_cool_Energy.y', 'max', 'DES_inputEnergy_C'], \
                 ['HeatLoss_Energy.y','min', 'Pipes_HeatLoss_Q']\
                 ]
    return readVar

def SetPrintVar(resultVar, pipeList, modellist):
    # variables to be printed in the csv File
    # headers for the csv file
    printVar = ['name']
    printVar += ['NPV']
    printVar += [v[2] for v in resultVar]
    printVar += ['Total_Pipe_Length']
    printVar += [m.name for m in modellist] + [p.name for p in pipeList]
    return printVar

def ReadMat(dirname, matFileName, readVar, pipeList, modellist):#, lifetime, upv_File, co2_rate_file, co2_pricing_file, startYear):
    # read the MAT_Result File of the Modelica Simulation
    TA_data = []
    for case in os.listdir(dirname):
        if 'case' in case:
            matFile = dirname + "/" + case + "/" + matFileName
            r = Reader(matFile, "dymola")
            data = {'name': case}
            for v in readVar:
                if v[1] == 'max':
                    data.update({v[2]: r.max(v[0])})
                elif v[1] == 'min':
                    data.update({v[2]: r.min(v[0])})
                elif v[1] == 'integral':
                    data.update({v[2]: r.integral(v[0])})
            # if pipe is active, add its pipe length to the total pipe length
            pipeLength = 0
            for pipe in pipeList:
                data.update({pipe.name: r.max((pipe.name + ".active"))})
                if data[pipe.name] == 1:
                    pipeLength += r.max((pipe.name + ".length"))
                    pipeDiameter = r.max((pipe.name + ".diameter"))
            data.update({'Total_Pipe_Length': pipeLength})
            for m in modellist:
                data.update({m.name: r.max((m.name + ".connected"))})
            TA_data.append(data)
    return TA_data

def InvestmentPipe(diameter, lenght):
    #returns investment cost for dual-pipe based on lenght and diameter
    p_cost = 10 #cost per meter
    return p_cost * lenght

def ADD_ELCCA(upv_File, co2_rate_file, co2_pricing_file, startYear, lifetime, e_ele, e_gas, pipeLength):
    #energy life cycle cost analysis for the topology scenarios

    discount = 0.03
    # discount rate should be 3% as this was also assumed for the UPV --> this is the real discount rate meaning excluding inflation

    ele_p = 0.1173
    # electricty price per kWh for Colorado Residential by https://www.eia.gov/electricity/monthly/epm_table_grapher.php?t=epmt_5_6_a

    gas_p = 0.0258
    # gas price for Colorado Residential by https://www.eia.gov/dnav/ng/ng_pri_sum_a_EPG0_PRS_DMcf_m.htm
    # gas BTU https://www.eia.gov/dnav/ng/ng_cons_heat_a_EPG0_VGTH_btucf_a.htm

    pipe_p = 500
    # price per meter of pipe, including the installation costs

    em_co2_ele = 0.6395
    # CO2_emissions (kg_CO2/kwh_el) for Colorado
    # https://www.eia.gov/electricity/state/ : CO2_production_electricity_colorado =  34,802,861 t
    # https://www.eia.gov/electricity/data/state/ : electricity_production_colorado = 54,418,480 MWh

    em_co2_gas = 0.198

    investment = pipe_p * pipeLength

    upv = parseCSV(upv_File)

    ele_UPV = float(upv[str(lifetime)][1])
    c_ele = (e_ele * ele_UPV * ele_p)/(3600*1000)

    gas_UPV = float(upv[str(lifetime)][3])
    c_gas = (e_gas * gas_UPV * gas_p) / (3600 * 1000)

    m_co2 = em_co2_ele * e_ele/(3600*1000) + em_co2_gas * e_gas/(3600*1000)
    co2_rate = parseCSV(co2_rate_file)
    co2_pricing = parseCSV(co2_pricing_file)
    c_CO2 = 0
    for t in range(0, lifetime + 1):
        c_CO2_Year = m_co2 * float(co2_rate[str(startYear+t)][1]) * float(co2_pricing[str(startYear+t)][0]) * ((1 + discount) ** -t)
        c_CO2 += c_CO2_Year

    c_NPV = investment + c_ele + c_gas + c_CO2
    return c_NPV

def parseCSV(file):
    with open(file, 'rb') as csvfile:
        reader = csv.reader(csvfile, delimiter=',', quotechar='|')
        column = {}
        for row in reader:
            column[row[0]] = row[1:]
    return column

def WriteCSV(TA_data, printVar, resultDir, output_name):
    #Write the gained results to a csv-File
    for fieldnames in TA_data[0].keys():
        if fieldnames not in printVar:
            print "not in fieldnames:", fieldnames
    name = resultDir + '/' + output_name + '.csv'
    print name
    with open(name, 'w+') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=printVar)
        writer.writeheader()
        for data in TA_data:
            writer.writerow(data)

if __name__ == '__main__':
    import DHC_Model

    dirname = os.path.dirname(os.path.abspath(__file__))
    upv_file = dirname + "/ELLCA_Prices/" + "UPV_Residential_Colorado.csv"
    co2_rate_file = dirname + "/ELLCA_Prices/" + "CO2_Emissions_Rate_Indices.csv"
    co2_pricing_file = dirname + "/ELLCA_Prices/" + "CO2_Emission_pricing.csv"

    matFileName = "Test.mat"
    startYear = 2017
    lifetime = 20
    case = "ALL"
    dynamics = False

    if dynamics:
        output_name = "TA_" + case + "_dynamic"
        matDirectory = dirname + "/" + output_name
    else:
        output_name = "TA_" + case + "_steadyState"
        matDirectory = dirname + "/" + output_name

    temp = DHC_Model.main()
    modelList = temp[0]
    pipeList = temp[1]
    CreateResultCsv(matDirectory, matFileName, modelList, pipeList, upv_file, co2_rate_file, co2_pricing_file, startYear, lifetime, output_name)
