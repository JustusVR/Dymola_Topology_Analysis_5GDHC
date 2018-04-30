# package geopy needed: pip install geopy

import json
import geopy.distance
import itertools
from math import sin, cos, sqrt, atan2, radians

def GetData(GeoJsonFile):
    loadData = ReadGeoJsonData(GeoJsonFile)
    for load in loadData:
        loadData[loadData.index(load)][2] = CalcLoadCenter(load[2])
   # stepsize = max(MinStepSize(loadData), [5, 40])
    stepsize = max(MinStepSize(loadData), [20,20])
    loadData = AssingLoadsToGrid(loadData, stepsize)
    loadData = AssingLoadsAroundCenter(loadData)
    return loadData

def ReadGeoJsonData(fileName):
    #reads the GeoJson file from UrbanOpt and returns the necessary information of the loads/buildings
    loads = []
    with open(fileName, 'r') as f:
        data = json.load(f)
    for feature in data['features']:
        coords = feature['geometry']['coordinates'][0]
        loadType = str(feature['properties']['type'])
        name = str(feature['properties']['name'])
        loads.append([loadType, name, coords])
    return loads

def CalcLoadCenter(coords):
    #returns the centers of the loads based on their coordinates
    #the building shapes are assumed to be rectangeled
    xCoords = []
    yCoords = []
    for c in coords:
        xCoords.append(c[0])
        yCoords.append(c[1])
    xCenter = (max(xCoords) - min(xCoords)) / 2 + min(xCoords)
    yCenter = (max(yCoords) - min(yCoords)) / 2 + min(yCoords)
    return [xCenter, yCenter]

def MinStepSize(loads):
    #calculates the minimum distance (x,y) between every possible two loads
    dis = []
    for subset in itertools.combinations(loads, 2):
        dis.append(DisXY(subset,-1))
    dx = min(l[0] for l in dis)
    dy = min(l[1] for l in dis)
    return [dx, dy]

def DisXY(coords, precision):
    #calculates the distance (x,y) between two points in meters: https://www.kompf.de/gps/distcalc.html
    lat1 = float(format((coords[0][2][0]), '.18g'))
    lat2 = float(format((coords[1][2][0]), '.18g'))
    lon1 = float(format((coords[0][2][1]), '.18g'))
    lon2 = float(format((coords[1][2][1]), '.18g'))
    lat = (lat1 + lat2) / 2 * 0.01745
    dx = round(abs(111.3 * cos(lat) * (lon1 - lon2)*1000),precision)
    dy = round(abs((111.3 * (lat1 - lat2))*1000),precision)
    return [dx, dy]

def AssingLoadsToGrid(loadData, stepsize):
    #sorts the footprint of the building to a grid according to their center of the building and the minimal step size
    for l in loadData:
        loadData[loadData.index(l)].append([])
    for i in range(0,2):
        step = -1
        lastLoad = None
        loadDataSorted = sorted(loadData, key=lambda x: (x[2][i]))
        for l in loadDataSorted:
            if (lastLoad is None) or DisXY([l,lastLoad],2)[i] >= stepsize[i]:
                step += 1
                lastLoad = l
            loadData[loadData.index(l)][3].append(step)
    return loadData

def CalcGridCenter(loadData):
    #calculates the medium of the pre-assigned grid values for the loads
    x = max(l[3][0] for l in loadData)
    y = max(l[3][1] for l in loadData)
    return [float(x)/2, float(y)/2]

def AssingLoadsAroundCenter(loadData):
    gridCenter = CalcGridCenter(loadData)
    for l in loadData:
        pos = [((round((l[3][0] - gridCenter[0]), 0))),((round((l[3][1] - gridCenter[1]), 0)))]
        loadData[loadData.index(l)][3] = pos
    return loadData


def GeoDis(coords, direction):
    return round(geopy.distance.vincenty(co1, co2).m, 0)




#print GetData('/Users/justusvonrhein/Documents/Colorado/Ambient_Loops/Automated_Model_Building/GeoJson/exportGeo_2.json')

def tester():
    fn =  '/Users/justusvonrhein/Documents/Colorado/Ambient_Loops/Automated_Model_Building/GeoJson/exportGeo_6_Buildings2.json'
    #co = GetBuildingCenter(fn)
    #print dis2(co)
    #print minDis(co)

    #print dis([co[1], co[4]],4)
    #print  dis([co[3][2], co[4][2]],1)

    noDuplicates = False
    s = [10, 10]
    i = 0
    while noDuplicates == False:
        dups = set()
        duplicates = []
        i += 1
        data = readFile(fn)
        routes1 = []
        for d in data[1]:
            routes1.append(d[3])
        for route in routes1:
            if tuple(route) in dups:
                duplicates.append(tuple(route))
                #print('%s is a duplicate route' % route)
            else:
                dups.add(tuple(route))
        if len(duplicates) <> 0:
            noDuplicates = True
        s = [s[0] + 5, s[1] + 5]
        if i == 40:
            noDuplicates = True
            print "break"
    for d in data[1]:
        print d[3]











#tester()


