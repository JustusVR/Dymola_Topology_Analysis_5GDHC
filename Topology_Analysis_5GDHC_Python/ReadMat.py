
from buildingspy.io.outputfile import Reader
import os
import csv
import DHC_Model

def CreateOutputCSV():
    temp = DHC_Model.tester()
    modellist = temp[0]
    pipeList = temp[1]

    dirname = os.path.dirname(os.path.abspath(__file__)) + "/Results_v2"
    matFileName = "Test.mat"

    resultVar = SetResultVar()
    printVar = SetPrintVar(resultVar, pipeList, modellist)

    TA_data = ReadMat(dirname, matFileName, resultVar, pipeList, modellist)
    WriteCSV(TA_data, printVar)

def SetResultVar():
    resultVar = [['Buildings_DH_Energy.y', 'min'], \
                 ['Buildings_DC_Energy.y', 'max'], \
                 ['Buildings_eleHP_heat_Energy.y', 'max'], \
                 ['Buildings_eleHP_cool_Energy.y', 'max'], \
                 ['Buildings_IH_Energy.y', 'max'], \
                 ['Buildings_IC_Energy.y', 'max'], \
                 ['Buildings_PumpingElectricity_Energy.y', 'max'], \
                 ['DES_heat_Energy.y', 'max'], \
                 ['DES_cool_Energy.y', 'min'], \
                 ['HeatLoss_Energy.y','min']\
                 ]
    return resultVar

def SetPrintVar(resultVar, pipeList, modellist):
    printVar = ['name']
    printVar += [v[0] for v in resultVar]
    printVar += ['Total_Pipe_Length']
    printVar += [m.name for m in modellist] + [p.name for p in pipeList]
    return printVar

def ReadMat(dirname, matFileName, resultVar, pipeList, modellist):
    TA_data = []
    for case in os.listdir(dirname):
        if 'case' in case:
            matFile = dirname + "/" + case + "/" + matFileName
            r = Reader(matFile, "dymola")
            data = {'name': case}
            for v in resultVar:
                if v[1] == 'max':
                    data.update({v[0]: r.max(v[0])})
                elif v[1] == 'min':
                    data.update({v[0]: r.min(v[0])})
                elif v[1] == 'integral':
                    data.update({v[0]: r.integral(v[0])})
            pipeLength = 0
            for pipe in pipeList:
                data.update({pipe.name: r.max((pipe.name + ".active"))})
                if data[pipe.name] == 1:
                    pipeLength += r.max((pipe.name + ".length"))
            data.update({'Total_Pipe_Length': pipeLength})
            for m in modellist:
                data.update({m.name: r.max((m.name + ".connected"))})
            TA_data.append(data)
    return TA_data

def WriteCSV(TA_data, printVar):
    for fieldnames in TA_data[0].keys():
        if fieldnames not in printVar:
            print "not in fieldnames", fieldnames

    with open('output.csv', 'w+') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=printVar)
        writer.writeheader()
        for data in TA_data:
            writer.writerow(data)


CreateOutputCSV()