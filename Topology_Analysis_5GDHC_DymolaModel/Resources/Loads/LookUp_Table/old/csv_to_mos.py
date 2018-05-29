import csv
from datetime import datetime

def ConvertCSV_Mos(file):
    fileName = file[:file.find(".csv")]
    CSVdata = parseCSV(file)
    headers = CSVdata[0]
    column = CSVdata[1]
    initMos(column, fileName)
    with open(fileName + ".mos", "a") as outfile:
        writer = csv.writer(outfile, delimiter=",")
        writer.writerow(headers)
        writer.writerows(zip(*[column[key] for key in headers]))
    correctHeader((fileName + ".mos"), "datetime", str(0))
    print nominalLoad(column)

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
    f = open(fileName + ".mos", "w+")
    f.write(initStr)
    f.close()

def correctHeader(file, oldStr, newStr):
    f = open(file, 'r')
    filedata = f.read()
    f.close()

    newdata = filedata.replace(oldStr, newStr)

    f = open(file, 'w')
    f.write(newdata)
    f.close()

def main():
    files = []
    files.append("cooling_CoolingElectricity_mass_flow_0.75.csv")
    files.append("cooling_DistrictCoolingChilledWaterEnergy_mass_flow_0.75.csv")
    #files.append("cooling_ETSCoolingOutletTemperature_mass_flow_0.75.csv")
    files.append("heating_DistrictHeatingHotWaterEnergy_mass_flow_0.25.csv")
    #files.append("heating_ETSHeatingOutletTemperature_mass_flow_0.25.csv")
    files.append("heating_HeatingElectricity_mass_flow_0.25.csv")
    #cooling_CoolingElectricity_mass_flow_0.75.csv
    #cooling_DistrictCoolingChilledWaterEnergy_mass_flow_0.75.csv
    #cooling_ETSCoolingOutletTemperature_mass_flow_0.75.csv
    #heating_DistrictHeatingHotWaterEnergy_mass_flow_0.25.csv
    #heating_ETSHeatingOutletTemperature_mass_flow_0.25.csv
    #heating_HeatingElectricity_mass_flow_0.25.csv
    for file in files:
        ConvertCSV_Mos(file)
   # x = 9999649.0 / 3600

if __name__ == '__main__':
    main()