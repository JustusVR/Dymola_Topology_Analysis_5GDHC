import csv
from datetime import datetime
import os

def ConvertCSV_Mos(csvDir, buildingName):
    mosDir = csvDir[:csvDir.rfind("/")] + "/TA/" +buildingName + "_mos_loads"
    fileName = mosDir + "/" + csvDir[(csvDir.rfind("/") + 1):csvDir.find(".csv")] + ".mos"

    if not os.path.exists(mosDir):
        os.makedirs(mosDir)

    CSVdata = parseCSV(csvDir)
    headers = CSVdata[0]
    column = CSVdata[1]
    initMos(column, fileName)
    with open(fileName, "a") as outfile:
        writer = csv.writer(outfile, delimiter=",")
        writer.writerow(headers)
        writer.writerows(zip(*[column[key] for key in headers]))
    correctHeader(fileName, "datetime", str(0))
    return [fileName, nominalLoad(column)]

def parseCSV(file):
    with open(file, 'rb') as csvfile:
        reader = csv.reader(csvfile, delimiter=',', quotechar='|')
        headers = reader.next()
        column = {}
        for h in headers:
            column[h] = []
        for row in reader:
            for h, v in zip(headers, row):
                if h == "datetime":
                    dt = datetime.strptime(v, "%m/%d/%Y %H:%M")
                    r = ((dt.timetuple().tm_yday - 1) * 24 + dt.hour) * 3600
                else:
                    r = float(v)/3600
                column[h].append(r)
    return [headers, column]

def nominalLoad(data):
    globalMax = None
    excludes = set(["datetime"])
    keys = set(data.keys())
    for key in keys.difference(excludes):
        localMax = max(data[key])
        if globalMax == None or globalMax < localMax:
            globalMax = localMax
    return round(globalMax, 2)

def initMos(csvData, fileName):
    initStr = "#1\n"
    initStr += "#column 1 = seconds of the year\n"
    initStr += "#column 2-10 = energy based on inlet temperature\n"
    initStr += "double data(%d, %d)\n" % (len(csvData[csvData.keys()[0]])+1, len(csvData.keys()))
    f = open(fileName, "w+")
    f.write(initStr)
    f.close()

def correctHeader(file, oldStr, newStr):
    # in a mos-File no text is allowed, even if this is of no importance to the table
    # the header "datetime" has to be deleted
    # can only be done at the end, as this header is an important key for converting the csv-File to mos-File
    f = open(file, 'r')
    filedata = f.read()
    f.close()

    newdata = filedata.replace(oldStr, newStr)

    f = open(file, 'w')
    f.write(newdata)
    f.close()

def main():
    dirname = os.path.dirname(os.path.abspath(__file__))
    files = [ dirname + '/loads/cooling_DistrictCoolingChilledWaterEnergy_mass_flow_0.75.csv', dirname + '/loads/cooling_CoolingElectricity_mass_flow_0.75.csv', dirname + '/loads/heating_DistrictHeatingHotWaterEnergy_mass_flow_0.25.csv', dirname + '/loads/heating_HeatingElectricity_mass_flow_0.25.csv']
    testMosDir = 'test1'
    for file in files:
        print ConvertCSV_Mos(file, testMosDir)



if __name__ == '__main__':
    main()