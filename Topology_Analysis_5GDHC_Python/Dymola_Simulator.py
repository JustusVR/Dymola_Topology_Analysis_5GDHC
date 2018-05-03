#!/usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import absolute_import
from __future__ import division
from __future__ import print_function
from __future__ import unicode_literals

from multiprocessing import Pool
import buildingspy.simulate.Simulator as si

import Topology_analysis as ta
import shutil
import copy
import ReadMat
import GeoJson_Parser_Nic
import DHC_Model
import os



def simulateModel(s):
    s.setStopTime((3600*24*100))
    s.setTimeOut(60 * 10) # Kill the process if it does not finish in 10 minutes
    s.showProgressBar(False)
    s.printModelAndTime()
    s.simulate()

def simulateTranslatedModel(s):
    s.setStopTime(3600*24*365)
    s.setTimeOut(60*10) # Kill the process if it does not finish in 3 minutes
    s.showProgressBar(False)
    s.printModelAndTime()
    s.simulate_translated()

def Run_TA(model, case, urbanOptFile, modelicaDir, alwaysActiveProsumers, loads, resultDir):
    s = si.Simulator(model, 'dymola')
    s.setSolver('dassl')
    s.showGUI(False)
    s.translate()

    if not os.path.exists(resultDir):
        os.makedirs(resultDir)

    li = []
    scenarios = ta.SetSimulations(case="ST", urbanOptFile=urbanOptFile, modelicaDir=modelicaDir, alwaysActiveProsumers=alwaysActiveProsumers, loads=loads)
    i = 0 
    x = 0 
    for activeBuildings in scenarios:
        for scenario in activeBuildings[3]:
            i += 1
            name = resultDir + "/case" + str(i)
            sc = copy.deepcopy(s)
            sc.setOutputDirectory(name)
            #print (sc.getOutputDirectory())
            for parameters in scenario:
                sc.addParameters({parameters[0]: parameters[1]})
            li.append(sc)
    # Run all cases
    po = Pool()
    po.map(simulateTranslatedModel, li)
    s.deleteTranslateDirectory()



def main():

    case = "ST"
    dirname = os.path.dirname(os.path.abspath(__file__))
    modelicaDir = '/home/justus/Documents/Topology_Analysis_5GDHC_DymolaModel/Automated_5GDHC'
    #modelicaDir = dirname + '/Modelica_5GDHC_TemplateModel'
    alwaysActiveProsumers = ["District System"]
    urbanOptFile = dirname + '/GeoJson/exportGeo_2.json'
    model = 'Topology_Analysis_5GDHC_DymolaModel.Automated_5GDHC.Test'
    loadDir = dirname + "/loads"
    loads = GeoJson_Parser_Nic.GetBuildingLoads(loadDir, urbanOptFile)
    resultDir = os.path.dirname(os.path.abspath(__file__)) + "/TA_" + case
    scenarios = ta.SetSimulations(case="ST", urbanOptFile=urbanOptFile, modelicaDir=modelicaDir, alwaysActiveProsumers=alwaysActiveProsumers, loads=loads)
    Run_TA(model, case, urbanOptFile, modelicaDir, alwaysActiveProsumers, loads, resultDir)

    modelName = DHC_Model.GetDHCModulName()
    matFileName = modelName[:modelName.find(".mo")]
    temp = DHC_Model.main()
    modelList = temp[0]
    pipeList = temp[1]
    #ReadMat.CreateResultCsv(resultDir, matFileName, modelList, pipeList)

if __name__ == '__main__':
    main()


