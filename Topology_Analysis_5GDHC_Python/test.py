import geopy.distance
import numpy as np
import os
import shutil



class Person(object):
    def __init__(self, first, last, age):
        self.firstname = first
        self.lastname = last
        self.age = age

    def __str__(self):
        return self.firstname + " " + self.lastname + ", " + str(self.age)

class Employee(Person):
    def __init__(self, first, last, age, staffnum):
        super(Employee, self).__init__(first, last, age)
        self.staffnumber = staffnum

    def __str__(self):
        return super(Employee, self).__str__() + ", " +  self.staffnumber


x = Person("Marge", "Simpson", 36)
y = Employee("Homer", "Simpson", 28, "1007")

print(x)
print(y)

class ModelicaModel(object):
    def __init__(self,model, name, pos, size, rotation, parameters):
        self.model = model
        self.name = name
        self.size = size
        self.rotation = rotation
        self.parameters = parameters


class Prosumer:
    def __init__(self, prosumerType, model, name, coords, gridPos, matrixPos, size, rotation, parameters, nodes):
        self.model = model
        self.name = name
        self.coords = coords
        self.gridPos = gridPos
        self.matrixPos = matrixPos
        self.size = size
        self.rotation = rotation
        self.parameters = parameters
        self.nodes = nodes
        self.prosumerType = prosumerType

class Source:
    def __init__(self, model, name, coords, gridPos, matrixPos, size, rotation, parameters, nodes):
        self.model = model
        self.name = name
        self.coords = coords
        self.gridPos = gridPos
        self.matrixPos = matrixPos
        self.size = size
        self.rotation = rotation
        self.parameters = parameters
        self.nodes = nodes

class Node:
    def __init__(self, model, name, gridPos, size, rotation, parameters=[]):
        self.model = model
        self.name = name
        self.gridPos = gridPos
        self.size = size
        self.rotation = rotation
        self.parameters = parameters
        self.ports = 0
    def portsUsed(self):
            self.ports += 1
            return self.ports

class Pipe:
    def __init__(self, model, name, gridPos, size, rotation, model1, model2, parameters=[]):
        self.model = model          #model = Modelica Dual Pipe Model
        self.name = name            #name of pipe
        self.gridPos = gridPos      #pos in Dymola Grid
        self.size = size            #size of Dymola Model for visualization
        self.rotation = rotation    #rotation of Dymola Model
        self.parameters = parameters
        self.model1 = model1
        self.model2 = model2





def SetTemplateModel(data, resultdir, modelicadir):
    global modellist, pipeList, stepSize
    pipeList = []
    modellist = []

    replaceablePackages = ["Medium = Buildings.Media.Water"]
    parameters = ["Modelica.SIunits.MassFlowRate m_flow_nominal = 1"]
    extendedModuls = ["Modelica.Icons.Example"]

    prosumerModel = "Building.Automated_Model_Building.Building_bidirectional"
    sourceModel = "Topology_Analysis_5GDHC.DES.Ideal_T_JVR"
    nodeModel = "Buildings.Fluid.Delays.DelayFirstOrder"
    dualPipeModel = "Topology_Analysis_5GDHC.Dual_Pipe.Dual_Pipe"

    stepSize = max((len(data[1]) * 20), 140)  # stepsize = edge length of a quadrat of the dymola grid

    SetModellist(data, prosumerModel, sourceModel, nodeModel)
    connectionMatrix = setConnectionMatrix(len(modellist))
    SetPipelist(connectionMatrix, dualPipeModel)
    create5GDHCModel(GetDHCModulName(), extendedModuls, replaceablePackages, parameters, resultdir, modelicadir)
    return modellist, pipeList

def GetDHCModulName():
    dhcModel = "Test.mo"
    return dhcModel

def SetModellist(data, prosumerModel, sourceModel, nodeModel):
    gridcenter = data[0]
    for b in data[1]:
        # defining the prosumer and source models, based on the data from the geoJson file
        gridpos = [((round((b[3][0] - gridcenter[0]), 0)) * stepSize + stepSize/2), ((round((b[3][1] - gridcenter[1]), 0)) * stepSize + stepSize/2)]
        name = adjustName(b[1])
        node = [0,0]
        node[0] = Node(nodeModel,(name + "_node_a"),nodePos(gridpos,-5,-37),6,0,["nPorts=%d" % (len(data[1])),"redeclare package Medium = Medium","m_flow_nominal=1"])
        node[1] = Node(nodeModel,(name + "_node_b"), nodePos(gridpos, +5, -37), 6, 0,["nPorts=%d" % (len(data[1])), "redeclare package Medium = Medium", "m_flow_nominal=1"])
        if b[0] == "Building":
            modellist.append(Prosumer(b[0], prosumerModel, name, b[2], gridpos, b[3], 40, 0, ["redeclare package Medium = Medium"], node))
        elif b[0] == "District System":
            modellist.append(Prosumer(b[0], sourceModel, name, b[2], gridpos, b[3], 40, 0, ["redeclare package Medium = Medium", "m_flow_nominal=1"], node))
        else:
            print "This Model is not known"

def SetPipelist(connectionMatrix, pipeModel):
    xStart = -1
    for i in range(0, len(modellist)):
        xStart += 1
        if (len(modellist) - xStart - 1) == 0:
            break
        nPipes = (len(modellist)) - xStart - 1  # number of Pipes for this building
        pipe = 0
        for x in range(xStart, len(modellist)):  # positioning of the pipes in the Dymola Gui
            if connectionMatrix[i][x] == 1:
                if nPipes % 2 == 0:
                    s = stepSize - 40
                    stepYrel = (s) / (nPipes)
                    if pipe < nPipes / 2:
                        relY = stepYrel * pipe - s / 2
                    else:
                        relY = stepYrel * (pipe + 1) - s / 2
                elif nPipes == 1:
                    relY = 0
                else:
                    s = stepSize - 40
                    stepYrel = (s) / (nPipes - 1)
                    relY = stepYrel * pipe - s / 2
                pipe += 1
                pipeList.append(defineDualPipe(pipeModel, modellist[i], modellist[x], relY))
                # print "pos: ", i, ",", x ," : ", modellist[i].name, " and ", modellist[x].name, "with relY:", relY

def setConnectionMatrix(size):
    # creating a symmetrical matrix for setting the pipes to connect the buildings
    a = np.ones( (size,size), dtype=np.int16 )
    for i in range(0,size):
        a[i][i] = 0
    return a

def nodePos(buildingPos, x, y):
    relX = buildingPos[0] + x
    relY = buildingPos[1] + y
    return [relX, relY]

def formatPos(pos):
    posStr = "{%d,%d}" % (pos[0],pos[1])
    return posStr

def formatSize(size):
    org = 0
    x = [(org - size/2), (org + size/2)]
    y = [(org - size / 2), (org + size / 2)]
    sizeStr = "{{%d,%d},{%d,%d}}" % (x[0],y[0],x[1],y[1])
    return sizeStr

def create5GDHCModel(dhcModul, extendedModuls, replaceablePackages, parameters, resultdir, modelicadir):
    resultFile = os.path.join(resultdir, dhcModul)
    f = open(resultFile, "w+")
    f.write(initialise5GDHCModel(dhcModul, extendedModuls, replaceablePackages, parameters))
    for x in modellist: #Adding load models
        f.write(addModel(x.model, x.name, formatSize(x.size), x.rotation, formatPos(x.gridPos), x.parameters))
        f.write(addModel(x.nodes[0].model, x.nodes[0].name, formatSize(x.nodes[0].size),x.nodes[0].rotation, formatPos(x.nodes[0].gridPos),x.nodes[0].parameters))
        f.write(addModel(x.nodes[1].model, x.nodes[1].name, formatSize(x.nodes[1].size), x.nodes[1].rotation,formatPos(x.nodes[1].gridPos), x.nodes[1].parameters))
        f.write("\n")
    f.write("\n")
    for pp in pipeList:
        f.write(addModel(pp.model, pp.name, formatSize(pp.size), pp.rotation, formatPos(pp.gridPos), pp.parameters))
        f.write("\n")
    f.write("\n")
    f.write("  equation;\n")
    f.write(connectNodesModel())
    f.write(connectPipes())
    f.write("\n")
    f.write(end5GDHCModel(dhcModul))
    f.close()
    shutil.copy(resultFile, modelicadir)

def initialise5GDHCModel(name, extendedModuls, replaceablePackages,  parameters):
    addStr = ("within Topology_Analysis_5GDHC.Automated_5GDHC;\n")
    addStr += ("model %s\n" % (name[:(len(name)-3)]))
    addStr += ("\n")
    for e in extendedModuls: #defining extended Moduls
        addStr += "  extends " + e + ";\n"
    addStr += ("\n")
    for r in replaceablePackages: #adding the replaceable packages to the model
        addStr += "  replaceable package " + r + ";\n"
    addStr += ("\n")
    for p in parameters: #defining the parameters of the model
        addStr += "  parameter " + p + ";\n"
    addStr += ("\n")
    return addStr

def adjustName(name): #The given names in UrbanOpt have to be adjusted to be used/allowed in Modelica
    name = name.replace(" ", "")
    name = name.replace("-", "")
    return name

def addModel(model, modelName, size, rotation, pos, parameters):
    addStr = ("  %s %s(" % (model, modelName))
    for p in parameters:
        addStr += ("\n      %s") %(p)
        if parameters.index(p) < (len(parameters)-1):
            addStr += ","
    addStr += (")\n")
    addStr += ("      annotation (Placement(transformation(extent=%s,rotation = %s, origin = %s)));" % (size, rotation, pos))
    addStr += ("\n")
    return addStr

def end5GDHCModel(dhcModul):
    m = None
    for b in modellist:
        if m is None or m < max(b.gridPos):
            m = max(b.gridPos)
    size = m + stepSize / 2
    addStr = ("  annotation (Diagram(coordinateSystem(extent={{-%d,-%d},{%d,%d}})), \n") % (size, size, size, size)
    addStr += ("    Icon(coordinateSystem(extent={{-100,-120},{160,100}}))); \n")
    addStr += ("end %s;\n" % (dhcModul[:(len(dhcModul) - 3)]))
    return addStr

def connectNodesModel():
    # connect the nodes with their prosumers/sources
    addstr = ""
    for m in modellist:
        addstr += "  connect(%s.port_a, %s.ports[%d])\n" % (m.name, m.nodes[0].name, m.nodes[0].portsUsed())
        addstr += "    annotation(Line(points={%s}, color={0, 127, 255}));\n" %(pathConnectNodesModel(m.gridPos, m.size, m.nodes[0].gridPos, m.nodes[0].size))
        addstr += "  connect(%s.port_b, %s.ports[%d])\n" % (m.name, m.nodes[1].name, m.nodes[1].portsUsed())
        addstr += "    annotation(Line(points={%s}, color={0, 127, 255}));\n" % (pathConnectNodesModel(m.gridPos, m.size, m.nodes[1].gridPos, m.nodes[1].size))
    return addstr

def pathConnectNodesModel(posModel, sizeModel, posNode, sizeNode):
    #path of connectiing the Nodes with the Models for visualization in Dymola
    points = []
    points.append([posNode[0], posModel[1] - sizeModel/2])
    points.append([posNode[0], posNode[1] - sizeNode/2])
    return pathPoints(points)

def defineDualPipe(dualPipeModul, model1, model2, relY):
    #relY is the relative Y-Position of the pipe to the model1
    x = model1.gridPos[0] + model1.size / 2 + 20 + 10
    y = model1.gridPos[1] + relY
    pos = [x, y]
    length = round(geopy.distance.vincenty(model1.coords, model2.coords).m, 0)
    parameters = ["redeclare package Medium = Medium",("length=%d" %(length)), "m_flow_nominal=1"]
    name = "Pipe_%s_%s" % (model1.name, model2.name)
    pipe = Pipe(dualPipeModul, name, pos, 10, 0, model1, model2, parameters)
    return pipe

def connectPipes():
    addstr = ""
    for pp in pipeList:
        #connect side a of dual-pipe to model 1
        addstr += "  connect(%s.ports[%d], %s.port_a_hot)\n" % (pp.model1.nodes[0].name, pp.model1.nodes[0].portsUsed(), pp.name)
        addstr += "    annotation(Line(points={%s}, color={0, 127, 255}));\n" % (pathConnectModel1Pipe(pp, 0))
        addstr += "  connect(%s.ports[%d], %s.port_a_cold)\n" % (pp.model1.nodes[1].name, pp.model1.nodes[1].portsUsed(), pp.name)
        addstr += "    annotation(Line(points={%s}, color={0, 127, 255}));\n" % (pathConnectModel1Pipe(pp, 1))
        #connect side b of dual-pipe to model 2
        addstr += "  connect(%s.port_b_hot, %s.ports[%d])\n" % (pp.name, pp.model2.nodes[0].name, pp.model2.nodes[0].portsUsed())
        addstr += "    annotation(Line(points={%s}, color={0, 127, 255}));\n" % (pathConnectModel2Pipe(pp, 0))
        addstr += "  connect(%s.port_b_cold, %s.ports[%d])\n" % (pp.name, pp.model2.nodes[1].name, pp.model2.nodes[1].portsUsed())
        addstr += "    annotation(Line(points={%s}, color={0, 127, 255}));\n" % (pathConnectModel2Pipe(pp, 1))
    return addstr

def pathConnectModel2Pipe(dualpipe, node):
    points = []
    # connects the node of Model2 with the dualpipe
    if node == 0:
        start = [dualpipe.gridPos[0] + dualpipe.size/2, dualpipe.gridPos[1] + dualpipe.size / 4]
    else:
        start = [dualpipe.gridPos[0] + dualpipe.size/2, dualpipe.gridPos[1] - dualpipe.size / 4]
    points.append(start)
    points.append([dualpipe.model1.gridPos[0] + stepSize/2,points[-1][1]])
    points.append([points[-1][0], dualpipe.model2.gridPos[1] - stepSize/2])
    points.append([dualpipe.model2.nodes[node].gridPos[0],points[-1][1]])
    points.append([points[-1][0], dualpipe.model2.nodes[node].gridPos[1] - dualpipe.model2.nodes[node].size/2])
    return pathPoints(points)

def pathConnectModel1Pipe(dualpipe, node):
    points = []
    # connects the node of Model1 with the dualpipe
    start = [dualpipe.model1.nodes[node].gridPos[0], dualpipe.model1.nodes[node].gridPos[1] - dualpipe.model1.nodes[node].size / 2]
    points.append(start)
    points.append(relPoint(start, [0,-20]))
    points.append([dualpipe.model1.gridPos[0] + dualpipe.model1.size / 2 + 20, points[-1][1]])
    if node == 0:
        points.append(relPoint(points[-1],[0, dualpipe.gridPos[1] - points[-1][1] + float(dualpipe.size) / 4]))
    else:
        points.append(relPoint(points[-1], [0, dualpipe.gridPos[1] - points[-1][1] - float(dualpipe.size) / 4]))
    points.append(relPoint(points[-1], [5, 0]))
    return pathPoints(points)

def pathPoints(points):
    path = ""
    for p in points:
        path += "{%d,%d}" % (p[0], p[1])
        if points.index(p) < (len(points) - 1):
            path += ","
    return path

def relPoint(start, relPath, onEdge = False):
    if onEdge:
        point = [round(start[0] + relPath[0], -1), round(start[1] + relPath[1], -1)]
    else:
        point = [start[0] + relPath[0], start[1] + relPath[1]]
    return point

def tester():
    import ReadGeojson

    dirname = os.path.dirname(os.path.abspath(__file__))
    urbanOptFile = dirname + '/GeoJson/exportGeo_2.json'
    resultdir = dirname + '/Modelica_5GDHC_TemplateModel'
    modelicaDir = dirname + '/Modelica_5GDHC_TemplateModel/Modelica'
    data = ReadGeojson.readFile(urbanOptFile)


    tempModel = SetTemplateModel(data, resultdir, modelicaDir)
    modellist = tempModel[0]
    pipelist = tempModel[1]

   # print modellist
   # print pipelist



#tester()