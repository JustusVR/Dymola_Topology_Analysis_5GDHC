import itertools
import copy
import numpy as np

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

def runST(activeVertices, allVertices):
    prueferS = []
    aMatrices = []
    for v in itertools.product(activeVertices, repeat=(len(activeVertices)-2)):
        prueferS.append(v)
    for p in prueferS:
        x = copy.deepcopy(activeVertices)
        subgraph = createSTGraph(x, list(p))
        aMatrices.append(createAMatrixFromGraph(allVertices, subgraph))
    return aMatrices

def createAMatrixFromGraph(verticesMasterGraph, subGraph):
    #on the base of the all vertices (including the prosumers not being active in this Analyses) create the adjancency matrix
    size = len(verticesMasterGraph)
    a = np.zeros((size, size), dtype=np.int16)
    for key in subGraph.keys():
        x = verticesMasterGraph.index(key)
        for connectedV in subGraph[key]:
            y = verticesMasterGraph.index(connectedV)
            a[x][y] = 1
            a[y][x] = 1
    return a

activeV = ["A", "B", "C", "D"]
allV = ["A", "B", "C", "D", "E"]

print runST(activeV, allV)[0]




