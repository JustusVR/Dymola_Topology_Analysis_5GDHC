
from buildingspy.io.outputfile import Reader
import os
import csv


def CreateResultCsv(matDirectory, matFileName, modelList, pipeList):
    resultVar = SetResultVar()
    printVar = SetPrintVar(resultVar, pipeList, modelList)
    TA_data = ReadMat(matDirectory, matFileName, resultVar, pipeList, modelList)
    WriteCSV(TA_data, printVar, matDirectory)

def SetResultVar():
    #variables to read out of the .mat-File
    #resultVar[x][2] is the name which will be shown in the output file
    resultVar = [['Buildings_DH_Energy.y', 'min', 'Buildings_Q_DH'], \
                 ['Buildings_DC_Energy.y', 'max', 'Buildings_Q_DC'], \
                 ['Buildings_eleHP_heat_Energy.y', 'max', 'Buildings_eleHP_H'], \
                 ['Buildings_eleHP_cool_Energy.y', 'max', 'Buildings_eleHP_C'], \
                 ['Buildings_IH_Energy.y', 'max', 'Buildings_Q_IH'], \
                 ['Buildings_IC_Energy.y', 'max', 'Buildings_Q_IC'], \
                 ['Buildings_PumpingElectricity_Energy.y', 'max', 'Buildings_elePumping'], \
                 ['DES_heat_Energy.y', 'max', 'DES_Q_H'], \
                 ['DES_cool_Energy.y', 'min', 'DES_Q_C'], \
                 ['HeatLoss_Energy.y','min', 'Pipes_HeatLoss_Q']\
                 ]
    return resultVar

def SetPrintVar(resultVar, pipeList, modellist):
    # headers for the csv file
    printVar = ['name']
    printVar += ['NPV']
    printVar += [v[2] for v in resultVar]
    printVar += ['Total_Pipe_Length']
    printVar += [m.name for m in modellist] + [p.name for p in pipeList]
    return printVar

def ReadMat(dirname, matFileName, resultVar, pipeList, modellist):
    #read the MAT_Result File
    TA_data = []
    for case in os.listdir(dirname):
        if 'case' in case:
            matFile = dirname + "/" + case + "/" + matFileName
            r = Reader(matFile, "dymola")
            data = {'name': case}
            for v in resultVar:
                if v[1] == 'max':
                    data.update({v[2]: r.max(v[0])})
                elif v[1] == 'min':
                    data.update({v[2]: r.min(v[0])})
                elif v[1] == 'integral':
                    data.update({v[2]: r.integral(v[0])})
            # if pipe is active, add its pipelenght to the total pipelenght
            pipeLength = 0
            pipeInvestment = 0
            for pipe in pipeList:
                data.update({pipe.name: r.max((pipe.name + ".active"))})
                if data[pipe.name] == 1:
                    pipeLength += r.max((pipe.name + ".length"))
                    pipeDiameter = r.max((pipe.name + ".diameter"))
                    pipeInvestment += InvestmentPipe(pipeDiameter, pipeLength)
            data.update({'Total_Pipe_Length': pipeLength})
            for m in modellist:
                data.update({m.name: r.max((m.name + ".connected"))})
            E_ele = data['Buildings_elePumping'] + data['Buildings_eleHP_H'] + data['Buildings_eleHP_C']
            E_des = data['DES_Q_H'] + data['DES_Q_C']
            E_i = data['Buildings_Q_IH'] + data['Buildings_Q_IC']
            data.update({"NPV": ELCCA(20, 0.02, E_ele + E_des + E_i, 0, pipeInvestment, 0)})
            TA_data.append(data)
    return TA_data

def InvestmentPipe(diameter, lenght):
    #returns investment cost for dual-pipe based on lenght and diameter
    p_cost = 10 #cost per meter
    return p_cost * lenght

def ELCCA(lifetime, interest, e_ele, e_gas, investment, maintenance ):
    #energy life cycle cost analysis for the topology scenarios
    ele_pe= 0.02    # Electricity Price Escalation Rate
    gas_pe = 0.01   # Gas Price Escalation Rate
    mai_pe = 0.02   # Maintenance Price Escalation Rate
    ele_p = 0.3     # electricty price
    gas_p = 0.06    # oil price

    c_t = investment
    for t in range (0, lifetime + 1):
        c_ele = e_ele * ele_p * (1 + ele_pe) ** t
        c_gas = e_gas * gas_p * (1 + gas_pe) ** t
        c_mai = maintenance * (1 + mai_pe) ** t
        c_t += ((c_ele + c_gas + c_mai) * ((1 + interest) ** -t))
    return c_t

def WriteCSV(TA_data, printVar, resultDir):
    #Write the gained results to a csv-File
    for fieldnames in TA_data[0].keys():
        if fieldnames not in printVar:
            print "not in fieldnames:", fieldnames
    name = resultDir + '/TA.csv'
    print name
    with open(name, 'w+') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=printVar)
        writer.writeheader()
        for data in TA_data:
            writer.writerow(data)

if __name__ == '__main__':
    import DHC_Model
    matDirectory = os.path.dirname(os.path.abspath(__file__)) + "/Results_v1"
    matFileName = "Test.mat"
    temp = DHC_Model.main()
    modelList = temp[0]
    pipeList = temp[1]
    CreateResultCsv(matDirectory, matFileName, modelList, pipeList)