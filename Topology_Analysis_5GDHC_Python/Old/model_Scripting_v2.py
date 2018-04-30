import readingGeojson
import geopy.distance

class Prosumer:
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


        



class Port:
    def __init__(self, name, posX, posY, size):
        self.name = name
        self.posX = posX
        self.posY = posY
        self.size = size
        self.pos = "{%s,%s}" % (str(posX), str(posY))

def main():
    global modellist, pipeList, portList, stepSize
    pipeList = []
    portList = []
    modellist = []

    replaceablePackages = ["Medium = Buildings.Media.Water"]
    parameters = ["Modelica.SIunits.MassFlowRate m_flow_nominal = 1"]
    extendedModuls = ["Modelica.Icons.Example"]

    data = readingGeojson.readFile('/Users/justusvonrhein/Documents/Colorado/Ambient_Loops/Automated_Model_Building/exportGeo_2.json')
    prosumerModel = "Building.Automated_Model_Building.Building_bidirectional"
    sourceModel = "Topology_Analysis_5GDHC.DES.Ideal_T_JVR"
    nodeModel = "Buildings.Fluid.Delays.DelayFirstOrder"
    dualPipeModel = "Topology_Analysis_5GDHC.Dual_Pipe.Dual_Pipe"
    dhcModel = "Test.mo"

    gridcenter = data[0]
    stepSize = max((len(data[1]) * 20), 80)  # stepsize = edge length of a quadrat of the dymola grid
    for b in data[1]:
        # defining the prosumer and source models, based on the data from the geoJson file
        gridpos = [((round((b[3][0] - gridcenter[0]), 0)) * stepSize), ((round((b[3][1] - gridcenter[1]), 0)) *stepSize)]
        name = adjustName(b[1])
        node = [0,0]
        node[0] = Node(nodeModel,(name + "_node_a"),nodePos(gridpos,-5,-37),6,0,["nPorts=%d" % (len(data)),"redeclare package Medium = Medium","m_flow_nominal=1"])
        node[1] = Node(nodeModel,(name + "_node_b"), nodePos(gridpos, +5, -37), 6, 0,["nPorts=%d" % (len(data)), "redeclare package Medium = Medium", "m_flow_nominal=1"])
        if b[0] == "Building":
            modellist.append(Prosumer(prosumerModel, name, b[2], gridpos, b[3], 40, 0, ["redeclare package Medium = Medium"], node))
        elif b[0] == "District System":
            modellist.append(Prosumer(sourceModel, name, b[2], gridpos, b[3], 40, 0, ["redeclare package Medium = Medium"], node))
        else:
            print "This Model is not known"

    #create a pipeList of all pipes to be implemented in the 5GDHC Model
    pipeList.append(defineDualPipe(dualPipeModel, modellist[3],modellist[1],40))
    #pipeList.append(defineDualPipe(dualPipeModel, modellist[2], modellist[3], 40))

    templateBuilding = "RFBuilding_unidirectional_automated_temp.mo"
    buildingModel = "RFBuilding_unidirectional_automated.mo"

    #createModels(templateBuilding, buildingModel)

    create5GDHCModel(dhcModel, extendedModuls, replaceablePackages, parameters)



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

def create5GDHCModel(dhcModul, extendedModuls, replaceablePackages, parameters):
    f = open((dhcModul), "w+")
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
    print connectPipes()
    f.write(connectPipes())

    f.write("\n")
    f.write(end5GDHCModel(dhcModul))
    f.close()

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
    addStr = ("  annotation (Diagram(coordinateSystem(extent={{-200,-200},{200,200}})), Icon(coordinateSystem(extent={{-100,-120},{160,100}})));\n")
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
    print addstr
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
    y = model1.gridPos[1] + relY + 10
    pos = [x, y]
    length = round(geopy.distance.vincenty(model1.coords, model2.coords).m, 0)
    parameters = ["redeclare package Medium = Medium",("lenght=%d" %(length)), "m_flow_nominal=1"]
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
    points.append([dualpipe.model1.gridPos[0] + stepSize,points[-1][1]])
    points.append([points[-1][0], dualpipe.model2.gridPos[1] - stepSize])
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




def createModels(template, FileName):
    f = open(FileName, "w+")
    f.close()
    with open(template) as f:
        with open(FileName, "a") as f1:
            for line in f:
                f1.write(line)
                if line.find("model RFBuilding_unidirectional_automated") == 0:
                    for x in range(1, len(modellist)):
                        pipePosY = -300 + (600/(len(modellist)-2)) * (x-1)
                        f1.write(addPipe(("pipe_a" + str(x)), 20, -250, pipePosY))
                        f1.write(addPort(("port_a" + str(x)), 20, -280, pipePosY) )
                if line.find("equation") == 0:
                    f1.write(connectPipeDel())
                    f1.write(connectPipePort())

def searchIndex(modelName):
    index = 1
    for x in modellist:
        if x.name == modelName:
            return index
        index += 1



def connectPipePort():
    i = 0
    str3 = ""
    for x in portList:
        points = x.pos + "," + pipeList[i].pos
        str1 = "  connect(%s, %s.port_a)\n" % (x.name, pipeList[i].name)
        str2 = "    annotation (Line(points={%s}, color={0, 127, 255}));\n" % (points)
        str3 += (str1 + str2)
        i += 1
    return str3

def connectPipeDel():
    i = 0
    posDel = "{-210,-0}"
    str3 = ""
    for x in pipeList:
        i += 1
        points = x.pos + "," + mover(x.pos, "r", 20) + "," + "{-230,-0}" + "," + posDel
        str1 = "  connect(%s.port_b, del_A.ports[%s])\n" % (x.name, str(2+i))
        str2 = "    annotation (Line(points={%s}, color={0,0,127}));\n" %(points)
        str3 += (str1 + str2)
    return str3

def mover(pos, direction, stepSize):
    posX = pos[1:pos.find(",")]
    posY = pos[(pos.find(",") + 2):-1]
    if direction == "l":
        posX = int(posX) - stepSize
    elif direction == "r":
        posX = int(posX) + stepSize
    elif direction == "u":
        posY = int(posX) + stepSize
    elif direction == "d":
        posY = int(posX) - stepSize
    return "{%s,%s}" % (str(posX), str(posY))

def addPipe(name, size, posX, posY):
    pipeList.append(Pipe(name, (posX+size),(posY+size/2), size))
    placer = "{%s,%s},{%s,%s}" %  (str(posX-size/2),str(posY-size/2),str(posX+size/2),str(posY+size/2))
    str1 = "  Connector.Connector %s (redeclare final package Medium = Medium)\n" %(name)
    str2 = "    annotation (Placement(transformation(extent={%s}),\n" % (placer)
    str3 = "        iconTransformation(extent={{-300,-20},{-260,20}})));\n"
    return (str1 + str2 + str3)

def addPort(name, size, posX, posY):
    portList.append(Port(name, (posX + size), (posY + size / 2), size))
    placer = "{%s,%s},{%s,%s}" %  (str(posX-size/2),str(posY-size/2),str(posX+size/2),str(posY+size/2))
    str1 = "  Modelica.Fluid.Interfaces.FluidPort_a %s(redeclare package Medium = Medium)\n" %(name)
    str2 = "    annotation (Placement(transformation(extent={%s})));\n" % (placer)
    return (str1 + str2)





def placer(posX, posY):
    pos = "{%s,%s}" % (str(posX), str(posY))
    return pos


if __name__ == "__main__":
    main()











def blabla():
    #aus Building2, Building3
    portA = "plant"
    portB = "Building2"
    indexPortA = searchIndex(portA)
    indexPortB = searchIndex(portB)

    if indexPortB > indexPortA:
        print (portA + ".pipeA_" + str(indexPortB - 1))
    elif indexPortB < indexPortA:
        print (portA + ".pipeA_" + str(indexPortB))
    else:
        print "The Buildings cannot be found in the modellist!"