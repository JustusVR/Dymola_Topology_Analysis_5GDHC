import DHC_Model
import ReadGeojson
import itertools
import numpy as np
import os

class ProsumerConnection:
    def __init__(self, name, model1, model2):
        self.name = name
        self.model1 = model1
        self.model2 = model2

def SetSimulations():
    simulationTopologies = []
    totalSimulations = 0
    dirname = os.path.dirname(os.path.abspath(__file__))
    urbanOptFile = dirname + '/GeoJson/exportGeo_2.json'
    resultdir = dirname + '/Modelica_5GDHC_TemplateModel'
    #modelicaDir = '/home/justus/Documents/Topology_Analysis_5GDHC/Automated_5GDHC'
    modelicaDir = dirname + '/Modelica_5GDHC_TemplateModel/Modelica'
    alwaysActiveProsumers = ["District System"]

    if not os.path.exists(modelicaDir):
        print "Error: The modelica path does not exist. Please adjust this!"
        return
    if not os.path.exists(resultdir):
        os.makedirs(resultdir)

    Set_5GDHC_TempModel(urbanOptFile, resultdir, modelicaDir)
    activeProsumerList = SetActiveProsumers(alwaysActiveProsumers)
    for activeProsumers in activeProsumerList:
        simulationTopologies.append(SetScenarioTopologies(activeProsumers))
    for s in simulationTopologies:
        totalSimulations += len(s[1])
    print "total Simulations:", totalSimulations
    print "total Building Combinations of being active", len(simulationTopologies)
    return simulationTopologies


def Set_5GDHC_TempModel(GeoJsonFile, resultdir, modelicadir):
    global modellist
    global pipelist
    urbanOptFile = GeoJsonFile
    data = ReadGeojson.GetData(urbanOptFile)
    tempModel = DHC_Model.SetTemplateModel(data, resultdir, modelicadir)
    modellist = tempModel[0]
    pipelist = tempModel[1]

def SetActiveProsumers(alwaysActiveProsumers):
    # iterate through the modellist to get the different combinations of buildings being part of the 5GDHC network
    # with the list alwaysActive prosumers can be selected which should always be part of the network, for example a heating/cooling source
    alwaysActive = []
    possibleActive = []
    activeBuildingList =[]
    for m in modellist:
        if m.prosumerType in alwaysActiveProsumers:
            alwaysActive.append(modellist.index(m))
        else:
            possibleActive.append(modellist.index(m))
    for l in range(1,len(possibleActive)+1):
        for subset in itertools.combinations(possibleActive, l):
            a = []
            for m in subset:
                a.append(modellist[m])
            for m in alwaysActive:
                a.append(modellist[m])
            activeBuildingList.append(a)
    return activeBuildingList

def SetScenarioTopologies(activeProsumers):
    activePipes = []
    parameters = []
    scenarioConnectionMatrices = SetScenarioConnectionMatrices(activeProsumers)
    for scm in scenarioConnectionMatrices:
        activePipes.append(FindPathPipes(scm))
    for p in activePipes:
        parameters.append(SetSimulationParameters(activeProsumers, p))
    simulations = [activeProsumers, scenarioConnectionMatrices, activePipes, parameters]
    return simulations

def SetScenarioConnectionMatrices(activeProsumers):
    # returns the connection matrices for a subset of buildings of the list models
    # 1. generate all possible connection of the active Prosumers in this Scenario
    # 2. iterate through all possible combinations of the prosumer connections
    # 3. varify that the current combinations of of prosumer connection involves all active buildings, so that a network is created
    #  As models is not containing all buildings of the district, the final connection matrix is created in CreateConnectionMatrix as buildings not taking part in the network have to be marked
    ProsumerConnections = []
    scenarioList = []
    connectionMatrices = []
    for subset in itertools.combinations(activeProsumers, 2):
        name = subset[0].name + subset[1].name
        ProsumerConnections.append(ProsumerConnection(name, subset[0], subset[1]))
    for l in range((len(activeProsumers)-1), max(len(ProsumerConnections)+1,3)):
        for subset in itertools.combinations(ProsumerConnections, l):
            connectedNodes = []
            selectedConnections = []
            for i in range (0, len(subset)):
                selectedConnections.append(subset[i])
                connectedNodes.append([subset[i].model1,subset[i].model2])
            if NetworkCheck(connectedNodes, activeProsumers) == True:
                scenarioList.append(selectedConnections)
    for scenario in scenarioList:
        connectionMatrices.append(CreateScenarioConnectionMatrix(scenario))
    return connectionMatrices
    #print "number of possible combinations:", (2**len(selectedConnections))
    #print "Number of Scenarios to be simulated: ",len(connectionMatrices)

def NetworkCheck(connectedNodes, activeProsumers):
    # check if the ProsumerConnections create a network with all nodes included
    # are all active buildings in the connected to a network
    networkNodes = CreateNetworkNodes(connectedNodes)
    check = True
    for ab in activeProsumers:
        if ab not in networkNodes:
            check = False
    #print check
    #print "network nodes:",
    #for m in networkNodes:
    #    print m.name,
    #print ""
    #print "active Prosumers:",
    #for m in activeProsumers:
    #    print m.name,
    #print "\n"
    return check

def CreateNetworkNodes(connectedNodes):
    #creates List of nodes connected to a network based on the list of ProsumerConnections for this scenario
    #iterating through the networkNodes and comparing them with the connectedNodes by the ProsumerConnections
    #results in a list of nodes connected to a network
    networkNodes = []
    networkNodes.append(connectedNodes[0][0])
    networkNodes.append(connectedNodes[0][1])
    for nn in networkNodes:
        for cn in connectedNodes:
            if nn in cn:
                for node in cn:
                    if node not in networkNodes:
                        networkNodes.append(node)
    return networkNodes

def CreateScenarioConnectionMatrix(scenario):
    # creating a symmetrical matrix for setting the pipes to connect the buildings
    # the connection matrix (a) shows which buildings are connected with each other
    size = len(modellist)
    a = np.zeros((size, size), dtype=np.int16)
    for connection in scenario:
        x = modellist.index(connection.model1)
        y = modellist.index(connection.model2)
        a[x][y] = 1
        a[y][x] = 1
    return a

def SetSimulationParameters(activeProsumers, activePipes):
    # based on the active buildings and active Pipes for the simulation the modellist and pipelist is translated for the buildingsPy package
    parameters = []
    for m in modellist:
        if m in activeProsumers:
            parameters.append([(m.name + ".connected"), True])
        else:
            parameters.append([(m.name + ".connected"), False])
    for p in pipelist:
        if p in activePipes:
            parameters.append([(p.name + ".active"), True])
        else:
            parameters.append(([(p.name + ".active"), False]))
    return parameters

def FindPathPipes(connectionMatrix):
    # for a connection matrix find the path for the connected buildings
    # a path resembles a collection of pipes connecting the buildings
    pipes = []
    for y in range(0, len(connectionMatrix)+1):
        for x in range(y, len(connectionMatrix +1)):
            if connectionMatrix[y][x] == 1:
                node1 =  modellist[y].name
                node2 = modellist[x].name
                pipes.append(FindPath(node1, node2))
    return pipes

def FindPath(node1, node2):
    # for 2 given nodes find the path with it's pipes
    # This will be optimized in future using the Graph-Theory
    pipeName = "Pipe_" + node1 + "_" + node2
    for p in pipelist:
        if p.name == pipeName:
            pipe = p
    return pipe





def maxNumberOfSimulation(n):
    # max number of possible network topologies in a district with buildings according to the modellist m
    m = range(1, n)
    sim = 0
    i = 0
    for l in range(2,len(m)+1):
        for subset in itertools.combinations(m, l):
            i += 1
            x = len(subset)
            numPipes = 0
            for n in range(1, x + 1):
                numPipes += n - 1
            sim += (2 ** numPipes)
    print "Total number of possible network topologies in a district with ", len(m)," buildings is: ", format(sim, ',d')
    simTime = 10
    print i
    #totalTime = sim * simTime / (3600)
    #print "The estimated simulation time with ", simTime, " seconds per simulation is: ", format(totalTime, ',d'), "hours"

#print SetSimulations()[0]
