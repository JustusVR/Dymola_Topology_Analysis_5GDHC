import csv
from datetime import datetime
import os

def ConvertCSV_Mos(csvDir):
    mosDir = csvDir[:csvDir.rfind("/")] + "/MOS/"
    fileName = mosDir + "/" + csvDir[(csvDir.rfind("/") + 1):csvDir.find(".csv")] + ".mos"

    if not os.path.exists(mosDir):
        os.makedirs(mosDir)

    CSVdata = parseCSV(csvDir)
    headers = CSVdata[0]
    column = CSVdata[1]
    initMos(column, fileName)
    with open(fileName, "a") as outfile:
        writer = csv.writer(outfile, delimiter=",")
        #writer.writerow(headers)
        writer.writerows(zip(*[column[key] for key in headers]))
    return [fileName]

def parseCSV(file):
    with open(file, 'rb') as csvfile:
        reader = csv.reader(csvfile, delimiter=',', quotechar='|')
        headers = reader.next()
        column = {}
        for h in headers:
            column[h] = []
        for row in reader:
            for h, v in zip(headers, row):
                r = float(v)
                column[h].append(r)
    return [headers, column]

def initMos(csvData, fileName):
    initStr = "#1\n"
    initStr += "#column 1 = seconds of the year\n"
    initStr += "#column 2 = measurement data\n"
    initStr += "double data(%d, %d)\n" % (len(csvData[csvData.keys()[0]]), len(csvData.keys()))
    f = open(fileName, "w+")
    f.write(initStr)
    f.close()

def main():
    validationdir = '/Users/justusvonrhein/Documents/Colorado/Ambient_Loops/Validation/Data/TEST1'
    validationFiles = [validationdir + '/TEST1_FM01.csv', validationdir + '/TEST1_TM02.csv', validationdir + '/TEST1_TM20.csv', validationdir + '/TEST1_TM01.csv', validationdir + '/TEST1_WS01.csv']
    for file in validationFiles:
        print ConvertCSV_Mos(file)





if __name__ == '__main__':
    main()