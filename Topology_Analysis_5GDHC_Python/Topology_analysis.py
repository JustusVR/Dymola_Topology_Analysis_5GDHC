import DHC_Model
import ReadGeojson
import GeoJson_Parser_Nic
import itertools
import numpy as np
from numpy import linalg as LA
import os
import copy

class ProsumerConnection:
    def __init__(self, name, model1, model2):
        self.name = name
        self.model1 = model1
        self.model2 = model2

def SetSimulations(urbanOptFile, case, modelicaDir, alwaysActiveProsumers, loads, dynamics):
    simulationTopologies = []
    if not os.path.exists(modelicaDir):
        print "Error: The modelica path does not exist. Please adjust this!"
        return

    Set_5GDHC_TempModel(urbanOptFile, modelicaDir, loads, dynamics)
    activeProsumerList = SetActiveProsumers(alwaysActiveProsumers)
    for activeProsumers in activeProsumerList:
        simulationTopologies.append(SetScenarioTopologies(activeProsumers, case))
    return simulationTopologies

def Set_5GDHC_TempModel(GeoJsonFile, modelicadir, loads, dynamics):
    global modellist
    global pipelist
    urbanOptFile = GeoJsonFile
    data = ReadGeojson.GetData(urbanOptFile)
    tempModel = DHC_Model.SetTemplateModel(data, modelicadir, loads, dynamics)
    modellist = tempModel[0]
    pipelist = tempModel[1]
    return tempModel

def SetActiveProsumers(alwaysActiveProsumers):
    # iterate through the modellist to get the different combinations of buildings being part of the 5GDHC network
    # with the list alwaysActive, prosumers can be selected which should always be part of the network, for example a heating/cooling source
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

def SetScenarioTopologies(activeProsumers, case):
    #for the active Prosumers, define all possible adjancency matrices, with the constrain of always having a connected graph
    activePipes = []
    parameters = []

    if case == "ST":
        aMatrices = SetAMatrices_ST(activeProsumers)
    elif case == "ALL":
        aMatrices = SetAMatrices_WithBFSearch(activeProsumers)
    else:
        print "This Case is not known"

    for am in aMatrices:
        activePipes.append(FindPathPipes(am))
    for p in activePipes:
        parameters.append(SetSimulationParameters(activeProsumers, p))
    simulations = [activeProsumers, aMatrices, activePipes, parameters]
    return simulations

def createSTGraph(vertices, prueferVertices):
    #create the spanning tree according to the Pruefer-Sequence
    graph = {}
    while prueferVertices:
        p = prueferVertices.pop(0)
        for v in vertices:
            if p <> v and v not in prueferVertices:
                graph = addConnection(graph, p, vertices.pop(vertices.index(v)))
                break
    graph = addConnection(graph, vertices[0], vertices[1])
    return graph

def addConnection(graph, v1, v2):
    #add the connection between v1 and v2 to the graph
    if v1 in graph:
        graph[v1] = graph[v1] + [v2]
    else:
        graph[v1] = [v2]
    if v2 in graph:
        graph[v2] = graph[v2] + [v1]
    else:
        graph[v2] = [v1]
    return graph

def SetAMatrices_ST(activeVertices):
    prueferS = []
    aMatrices = []
    for v in itertools.product(activeVertices, repeat=(len(activeVertices)-2)):
        prueferS.append(v)
    for p in prueferS:
        x = copy.copy(activeVertices)
        subgraph = createSTGraph(x, list(p))
        aMatrices.append(createAMatrixFromGraph(modellist, subgraph))
    return aMatrices

def createAMatrixFromGraph(verticesMasterGraph, subGraph):
    #on the base of the all vertices (including the prosumers not being active in this Analyses) create the adjancency matrix
    size = len(modellist)
    a = np.zeros((size, size), dtype=np.int16)
    for key in subGraph.keys():
        x = verticesMasterGraph.index(key)
        for connectedV in subGraph[key]:
            y = verticesMasterGraph.index(connectedV)
            a[x][y] = 1
            a[y][x] = 1
    return a

def SetAMatrices_WithBFSearch(activeProsumers):
    # returns the connection matrices for a subset of buildings of the list models
    # 1. generate all possible connection of the active Prosumers in this Scenario
    # 2. iterate through all possible combinations of the prosumer connections
    # 3. varify of having a connected graph with the breath-first search
    #  As models is not containing all buildings of the district, the final connection matrix is created in CreateConnectionMatrix as buildings not taking part in the network have to be marked
    edges = []
    aMatrices = []
    for vertices in itertools.combinations(activeProsumers, 2):
        edges.append(vertices)
    for l in range((len(activeProsumers) - 1), len(edges) + 1):
        for subset in itertools.combinations(edges, l):
            graph = createGraph(subset)
            if connectedGraphCheck(graph, activeProsumers) == True:
                aMatrices.append(createAMatrix(modellist, subset))
    return aMatrices

def createGraph(edges):
    #from the given edges (containing the connected vertecis) generate a graph in form of a dictonary
    graph = {}
    for edge in edges:
        if edge[0] in graph:
            graph[edge[0]] = graph[edge[0]] + [edge[1]]
        else:
            graph[edge[0]] = [edge[1]]
        if edge[1] in graph:
            graph[edge[1]] = graph[edge[1]] + [edge[0]]
        else:
            graph[edge[1]] = [edge[0]]
    return graph

def bfs_connected_component(graph):
    # https://stackoverflow.com/questions/46383493/python-implement-breadth-first-search
    # keep track of all visited nodes
    explored = []
    # keep track of nodes to be checked
    queue = [graph.keys()[0]]
    # keep looping until there are nodes still to be checked
    while queue:
        # pop shallowest node (first node) from queue
        node = queue.pop(0)
        if node not in explored:
            # add node to list of checked nodes
            explored.append(node)
            neighbours = graph[node]
            # add neighbours of node to queue
            for neighbour in neighbours:
                queue.append(neighbour)
    return explored

def connectedGraphCheck(graph, vertices):
    #verfy that nodes of the connected subgraph include all vertecies
    connectedVertices= bfs_connected_component(graph)
    connectedGraph = True
    for v in vertices:
        if v not in connectedVertices:
            connectedGraph = False
            break
    return connectedGraph

def createAMatrix(verticesMasterGraph, edges):
    #on the base of the all vertices (including the prosumers not being active in this Analyses) create the adjancency matrix
    size = len(verticesMasterGraph)
    a = np.zeros((size, size), dtype=np.int16)
    for edge in edges:
        x = verticesMasterGraph.index(edge[0])
        y = verticesMasterGraph.index(edge[1])
        a[x][y] = 1
        a[y][x] = 1
    return a

def SetSimulationParameters(activeProsumers, activePipes):
    # based on the active buildings and active Pipes for the simulation the modellist and pipelist is translated for the buildingsPy package
    # set paramters for the translated model
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

def FindPathPipes(aMatrix):
    # for a connection matrix find the path for the connected buildings
    # a path resembles a collection of pipes connecting the buildings
    pipes = []
    for y in range(0, len(aMatrix)+1):
        for x in range(y, len(aMatrix +1)):
            if aMatrix[y][x] == 1:
                vStart =  modellist[y].name
                vEnd = modellist[x].name
                pipes.append(FindPath(vStart, vEnd))
    return pipes

def FindPath(vStart, vEnd):
    # for 2 given nodes find the path with it's pipes
    # This will be optimized in future using the Graph-Theory
    pipeName = "Pipe_" + vStart + "_" + vEnd
    for p in pipelist:
        if p.name == pipeName:
            pipe = p
    return pipe

def maxNumberOfSimulation(n):
    # max number of possible network topologies in a district with buildings according to the modellist m
    pipes = 0
    for i in range(1,n+1):
        pipes += i - 1
    sim = 2 ** pipes
    return "Total number of possible network topologies in a district with ", n," buildings is: ", format(sim, ',d')
    simTime = 10
    #totalTime = sim * simTime / (3600)
    #print "The estimated simulation time with ", simTime, " seconds per simulation is: ", format(totalTime, ',d'), "hours"

def testNetworkCheck():
    #global allNodes
    allNodes = ['n1','n2','n3','n4','n5', 'n6']
    activeProsumers = ['n1','n2','n3','n4','n5', 'n6' ]
    edges = []
    aMatrices = []
    for vertices in itertools.combinations(activeProsumers, 2):
        edges.append(vertices)
    for l in range((len(activeProsumers) - 1), len(edges) + 1):
        for subset in itertools.combinations(edges, l):
            graph = createGraph(subset)
            if smEigenValues(createAMatrix(activeProsumers, subset)) > 0:
                if connectedGraphCheck(graph, activeProsumers) == False:
                    print PRsmEigenValues(createAMatrix(activeProsumers, subset))
                aMatrices.append(createAMatrix(allNodes, subset))
                    #if smEigenValues(createAMatrix(activeProsumers, subset)) <= 0:
                    #    print False
    print "total:",len(aMatrices)

def smEigenValues(a):
    # caculate all eigenvalues of the Laplacian matrix
    d = createDMatrix(a)
    l = d - a
    eig = LA.eigvalsh(l)
    return  np.partition(eig, 1)[1]

def createDMatrix(a):
    # create the degree matrix from the adjancency matrix
    size = a.shape[0]
    degrees = np.sum(a, axis=0)
    # create diagonal matrix
    d =  np.eye(size, dtype=int)
    for i in range(0, size):
        d[i] = d[i] * degrees
    return d

def SetScenarioConnectionMatrices_WithEigenvalue(activeProsumers):
    # returns the connection matrices for a subset of buildings of the list models
    # 1. generate all possible connection of the active Prosumers in this Scenario
    # 2. iterate through all possible combinations of the prosumer connections
    # 3. varify that the subgraph is a connected graph through the Algebraic Connectivity theorem (second smallest eigenvalue > 0 --> connected graph)
    #  As models is not containing all buildings of the district, the final connection matrix is created in CreateConnectionMatrix as buildings not taking part in the network have to be marked
    edges = []
    aMatrices = []
    for vertices in itertools.combinations(activeProsumers, 2):
        edges.append(vertices)
    for l in range((len(activeProsumers) - 1), len(edges) + 1):
        for subset in itertools.combinations(edges, l):
            if smEigenValues(createAMatrix(activeProsumers, subset)) > 0:
                aMatrices.append(createAMatrix(modellist, subset))
    print len(aMatrices)
    return aMatrices

def main():
    # case = ALL: Exhaustive Search of all possible topologies
    # case = ST: Analysing all possible "Spanning-Tree" topologies
    case = "ST"
    dynamics = False
    dirname = os.path.dirname(os.path.abspath(__file__))
    #modelicaDir = '/home/justus/Documents/Topology_Analysis_5GDHC/Automated_5GDHC'
    modelicaDir = dirname + '/Modelica_5GDHC_TemplateModel'
    alwaysActiveProsumers = ["District System"]
    urbanOptFile = dirname + '/GeoJson/exportGeo_2.json'
    loadDir = dirname + "/loads"
    loads = GeoJson_Parser_Nic.GetBuildingLoads(loadDir, urbanOptFile)
    scenario = SetSimulations(case = case, urbanOptFile = urbanOptFile, modelicaDir=modelicaDir, alwaysActiveProsumers=alwaysActiveProsumers, loads=loads, dynamics=dynamics)
    i = 0
    for s in scenario:
        for ta in s[1]:
            i += 1
    print "Total simulations:", i

if __name__ == '__main__':
    main()


