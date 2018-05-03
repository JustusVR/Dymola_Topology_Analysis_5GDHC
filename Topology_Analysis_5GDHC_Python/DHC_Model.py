import geopy.distance
import numpy as np
import os
import csv_to_mos as cm



class ModelicaModel(object):
    def __init__(self,model, name, pos, size, rotation, parameters):
        self.model = model
        self.name = name
        self.pos = pos
        self.size = size
        self.rotation = rotation
        self.parameters = parameters

class Prosumer(ModelicaModel):
    def __init__(self, model, name, pos, size, rotation, parameters, prosumerType, coords, nodes):
        super(Prosumer, self).__init__(model, name, pos, size, rotation, parameters)
        self.coords = coords
        self.nodes = nodes
        self.prosumerType = prosumerType


class Node(ModelicaModel):
    def __init__(self, model, name, pos, size, rotation, parameters=[]):
        super(Node, self).__init__(model, name, pos, size, rotation, parameters)
        self.ports = 0
    def portsUsed(self):
            self.ports += 1
            return self.ports

class Pipe(ModelicaModel):
    def __init__(self, model, name, pos, size, rotation, parameters, model1, model2):
        super(Pipe, self).__init__(model, name, pos, size, rotation, parameters)
        self.model1 = model1
        self.model2 = model2


def SetTemplateModel(data, modelicadir, loads):
    global modellist, pipeList, stepSize
    pipeList = []
    modellist = []

    replaceablePackages = ["Medium = Buildings.Media.Water"]
    parameters = ["Modelica.SIunits.MassFlowRate m_flow_nominal = 1"]
    extendedModuls = ["Modelica.Icons.Example"]

    prosumerModel = "Building.Automated_Model_Building.Building_TA_LookUp"
    sourceModel = "Topology_Analysis_5GDHC_DymolaModel.DES.Ideal_T_JVR"
    nodeModel = "Buildings.Fluid.Delays.DelayFirstOrder"
    dualPipeModel = "Topology_Analysis_5GDHC_DymolaModel.Dual_Pipe.Dual_Pipe_HeatLoss"

    stepSize = max((len(data) * 20), 140)  # stepsize = edge length of a quadrant in the dymola grid
    SetModellist(data, prosumerModel, sourceModel, nodeModel, loads)
    connectionMatrix = setConnectionMatrix(len(modellist))
    SetPipelist(connectionMatrix, dualPipeModel)
    create5GDHCModel(GetDHCModulName(), extendedModuls, replaceablePackages, parameters, modelicadir)
    return modellist, pipeList

def GetDHCModulName():
    dhcModel = "Test.mo"
    return dhcModel

def SetModellist(data, prosumerModel, sourceModel, nodeModel, loads):
    for b in data:
        # defining the prosumer and source models, based on the data from the geoJson file
        pos = [(b[3][0] * stepSize + stepSize/2), (b[3][1] * stepSize + stepSize/2)]
        name = adjustName(b[1])
        node = [0,0]
        node[0] = Node(nodeModel,(name + "_node_a"),nodePos(pos,-5,-37),6,0,["nPorts=%d" % (len(data)),"redeclare package Medium = Medium","m_flow_nominal=1"])
        node[1] = Node(nodeModel,(name + "_node_b"), nodePos(pos, +5, -37), 6, 0,["nPorts=%d" % (len(data)), "redeclare package Medium = Medium", "m_flow_nominal=1"])
        if b[0] == "Building":
            coolingDLoad = cm.ConvertCSV_Mos(loads[b[1]].cooling_ChilledWaterEnergy, name)
            coolingDLoad_File = "Cooling_DQ_File = \"" + coolingDLoad[0] + "\""
            coolingDLoad_nominal = "Q_nominal_cool = " + str(coolingDLoad[1])
            coolingEle = cm.ConvertCSV_Mos(loads[b[1]].cooling_Electricity, name)
            coolingEle_File = "Cooling_HP_ele_File =\"" + coolingEle[0] + "\""
            heatingDLoad = cm.ConvertCSV_Mos(loads[b[1]].heating_HotWaterEnergy, name)
            heatingDLoad_File = "Heating_DQ_File =\"" + heatingDLoad[0] + "\""
            heatingDLoad_nominal = "Q_nominal_heat = " + str(heatingDLoad[1])
            heatingEle = cm.ConvertCSV_Mos(loads[b[1]].heating_Electricity, name)
            heatingEle_File = "Heating_HP_ele_File = \"" + heatingEle[0] + "\""
            modellist.append(Prosumer(prosumerModel, name, pos, 40, 0, ["redeclare package Medium = Medium", coolingDLoad_File, coolingEle_File, heatingDLoad_File, heatingEle_File, heatingDLoad_nominal, coolingDLoad_nominal], b[0], b[2], node))
        elif b[0] == "District System":
            modellist.append(Prosumer(sourceModel, name, pos, 40, 0, ["redeclare package Medium = Medium", "m_flow_nominal=1"], b[0], b[2], node))
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
        for x in range(xStart, len(modellist)):  # positioning of the pipes in the Dymola Gui -- should be placed symmetrical to prosumer model
            if connectionMatrix[i][x] == 1:
                if nPipes % 2 == 0: #pos for an even number of pipes
                    s = stepSize - 40
                    stepYrel = (s) / (nPipes)
                    if pipe < nPipes / 2:
                        relY = stepYrel * pipe - s / 2
                    else:
                        relY = stepYrel * (pipe + 1) - s / 2
                elif nPipes == 1: # pos for one pipe
                    relY = 0
                else:   # pos for an uneven number of pipes
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

def create5GDHCModel(dhcModul, extendedModuls, replaceablePackages, parameters, modelicadir):
    resultFile = os.path.join(modelicadir, dhcModul)
    f = open(resultFile, "w+")
    f.write(initialise5GDHCModel(dhcModul, extendedModuls, replaceablePackages, parameters))
    for x in modellist: #Adding load models
        f.write("public\n")
        f.write(addModel(x.model, x.name, formatSize(x.size), x.rotation, formatPos(x.pos), x.parameters))
        f.write("protected\n")
        f.write(addModel(x.nodes[0].model, x.nodes[0].name, formatSize(x.nodes[0].size),x.nodes[0].rotation, formatPos(x.nodes[0].pos),x.nodes[0].parameters))
        f.write(addModel(x.nodes[1].model, x.nodes[1].name, formatSize(x.nodes[1].size), x.nodes[1].rotation,formatPos(x.nodes[1].pos), x.nodes[1].parameters))
        f.write("\n")
    f.write("\n")
    f.write("public\n")
    for pp in pipeList:
        f.write(addModel(pp.model, pp.name, formatSize(pp.size), pp.rotation, formatPos(pp.pos), pp.parameters))
        f.write("\n")
    f.write("\n")

    m = None
    for b in modellist:
        if m is None or m < max(b.pos):
            m = max(b.pos)
    size = m + stepSize / 2 + 100

    f.write(addAnalysisModels(size))

    f.write("\n")
    f.write("  equation;\n")
    f.write(connectNodesModel())
    f.write(connectPipes())
    f.write(connectAnalysisModels())
    f.write("\n")
    f.write(end5GDHCModel(dhcModul, size))
    f.close()


def initialise5GDHCModel(name, extendedModuls, replaceablePackages,  parameters):
    addStr = ("within Topology_Analysis_5GDHC_DymolaModel.Automated_5GDHC;\n")
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

def addAnalysisModels(gridSize):
    # add models for the Topology Analysis
    global analysisModels
    analysisModels = []
    analysedProsumers = []
    analysedDES = []
    for m in modellist:
        if m.prosumerType == "Building":
            analysedProsumers.append(m)
        elif m.prosumerType == "District System":
            analysedDES.append(m)

    startPosPumping = gridSize - 10
    startPosDH = startPosPumping - len(analysedProsumers) * 20 - 40
    startPosDC = startPosDH - len(analysedProsumers) * 20 - 40
    startPosIH = startPosDC - len(analysedProsumers) * 20 - 40
    startPosIC = startPosIH - len(analysedProsumers) * 20 - 40
    startPosHPheat = startPosIC - len(analysedProsumers) * 20 - 40
    startPosHPcool = startPosHPheat - len(analysedProsumers) * 20 - 40
    startPosDESH = startPosHPcool - len(analysedProsumers) * 20 - 40
    startPosDESC = startPosDESH - len(analysedDES) * 20 - 40
    startPosHeatLoss = startPosDESC - len(analysedDES) * 20 - 30


    analysisModels.append(SetAnalysesEnergyCalcModels(analysedProsumers, "Buildings_PumpingElectricity", gridSize, startPosPumping, "elePumps"))
    analysisModels.append(SetAnalysesEnergyCalcModels(analysedProsumers, "Buildings_DH", gridSize, startPosDH, "Q_DH"))
    analysisModels.append(SetAnalysesEnergyCalcModels(analysedProsumers, "Buildings_DC", gridSize, startPosDC, "Q_DC"))
    analysisModels.append(SetAnalysesEnergyCalcModels(analysedProsumers, "Buildings_IH", gridSize, startPosIH, "Q_IH"))
    analysisModels.append(SetAnalysesEnergyCalcModels(analysedProsumers, "Buildings_IC", gridSize, startPosIC, "Q_IC"))
    analysisModels.append(SetAnalysesEnergyCalcModels(analysedProsumers, "Buildings_eleHP_heat", gridSize, startPosHPheat, "eleHP_heat"))
    analysisModels.append(SetAnalysesEnergyCalcModels(analysedProsumers, "Buildings_eleHP_cool", gridSize, startPosHPcool, "eleHP_cool"))
    analysisModels.append(SetAnalysesEnergyCalcModels(analysedDES, "DES_heat", gridSize, startPosDESH, "Q_H_flow"))
    analysisModels.append(SetAnalysesEnergyCalcModels(analysedDES, "DES_cool", gridSize, startPosDESC, "Q_C_flow"))
    analysisModels.append(SetAnalysesEnergyCalcModels(pipeList, "HeatLoss", gridSize, startPosHeatLoss, "heatLoss"))

    addStr = ""
    for am in analysisModels:
        addStr += "public\n"
        addStr += addModel(am[1].model, am[1].name, formatSize(am[1].size), am[1].rotation, formatPos(am[1].pos),am[1].parameters)
        addStr += "protected\n"
        addStr += addModel(am[0].model, am[0].name, formatSize(am[0].size), am[0].rotation, formatPos(am[0].pos), am[0].parameters)
        for prosumer in am[2]:
            addStr += addModel(prosumer.model, prosumer.name, formatSize(prosumer.size), prosumer.rotation, formatPos(prosumer.pos), prosumer.parameters)
        addStr += ("\n")
    return addStr

def SetAnalysesEnergyCalcModels(analysedObjects, name, gridSize, startPos, variable):
    expressionModel = "Modelica.Blocks.Sources.RealExpression"
    multiSumModel = "Modelica.Blocks.Math.MultiSum"
    integratorModel = "Modelica.Blocks.Continuous.Integrator"

    analysis = []
    analysis.append(ModelicaModel(multiSumModel, "Sum_%s" % (name), [gridSize + 50, (startPos - 20 * len(analysedObjects) / 2)], 20, 0, ["nu = %d" % (len(analysedObjects))]))
    analysis.append(ModelicaModel(integratorModel, "%s_Energy" % (name), [gridSize + 90, (startPos - 20 * len(analysedObjects) / 2)], 20, 0, ["k = 1"]))
    analysis.append([])
    for ao in analysedObjects:
        analysis[2].append(ModelicaModel(expressionModel, ("%s_%s" %(name, ao.name)), [gridSize + 10, (startPos - 20 * analysedObjects.index(ao))], 20,0,["y = %s.%s" % (ao.name, variable)]))
    return analysis

def connectAnalysisModels():
    addStr = ""
    for am in analysisModels:
        addStr += "  connect(%s.y, %s.u)\n" % (am[0].name, am[1].name)
        addStr += "    annotation(Line(points={%s}, color={0, 127, 255}));\n" % (pathPoints([[am[0].pos[0] + am[0].size / 2, am[0].pos[1]], [am[1].pos[0] - am[1].size / 2, am[1].pos[1]]]))
        for prosumer in am[2]:
            addStr += "  connect(%s.y, %s.u[%d])\n" % (prosumer.name, am[0].name, am[2].index(prosumer)+1)
            addStr += "    annotation(Line(points={%s}, color={0, 127, 255}));\n" % (pathConnectAnalysisModel(prosumer.pos, prosumer.size, am[0].pos, am[0].size))
    return addStr

def end5GDHCModel(dhcModul, size):
    addStr = ("  annotation (Diagram(coordinateSystem(extent={{-%d,-%d},{%d,%d}})), \n") % (size, size, size, size)
    addStr += ("    Icon(coordinateSystem(extent={{-100,-120},{160,100}}))); \n")
    addStr += ("end %s;\n" % (dhcModul[:(len(dhcModul) - 3)]))
    return addStr

def connectNodesModel():
    # connect the nodes with their prosumers/sources
    addstr = ""
    for m in modellist:
        addstr += "  connect(%s.port_a, %s.ports[%d])\n" % (m.name, m.nodes[0].name, m.nodes[0].portsUsed())
        addstr += "    annotation(Line(points={%s}, color={0, 127, 255}));\n" %(pathConnectNodesModel(m.pos, m.size, m.nodes[0].pos, m.nodes[0].size))
        addstr += "  connect(%s.port_b, %s.ports[%d])\n" % (m.name, m.nodes[1].name, m.nodes[1].portsUsed())
        addstr += "    annotation(Line(points={%s}, color={0, 127, 255}));\n" % (pathConnectNodesModel(m.pos, m.size, m.nodes[1].pos, m.nodes[1].size))
    return addstr

def pathConnectAnalysisModel(pos1, size1, pos2, size2):
    #path of connectiing the Nodes with the Models for visualization in Dymola
    points = []
    startPoint = [pos1[0] + size1 / 2, pos1[1]]
    endPoint = [pos2[0] - size1 / 2, pos2[1]]
    points.append(startPoint)
    points.append(relPoint(startPoint, [10,0]))
    points.append([points[-1][0], endPoint[1]])
    points.append(endPoint)
    return pathPoints(points)

def pathConnectNodesModel(posModel, sizeModel, posNode, sizeNode):
    #path of connectiing the Nodes with the Models for visualization in Dymola
    points = []
    points.append([posNode[0], posModel[1] - sizeModel/2])
    points.append([posNode[0], posNode[1] - sizeNode/2])
    return pathPoints(points)

def defineDualPipe(dualPipeModul, model1, model2, relY):
    #relY is the relative Y-Position of the pipe to the model1
    x = model1.pos[0] + model1.size / 2 + 20 + 10
    y = model1.pos[1] + relY
    pos = [x, y]
    length = round(geopy.distance.vincenty(model1.coords, model2.coords).m, 0)
    parameters = ["redeclare package Medium = Medium",("length=%d" %(length)), "m_flow_nominal=1"]
    name = "Pipe_%s_%s" % (model1.name, model2.name)
    pipe = Pipe(dualPipeModul, name, pos, 10, 0, parameters, model1, model2)
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
        start = [dualpipe.pos[0] + dualpipe.size/2, dualpipe.pos[1] + dualpipe.size / 4]
    else:
        start = [dualpipe.pos[0] + dualpipe.size/2, dualpipe.pos[1] - dualpipe.size / 4]
    points.append(start)
    points.append([dualpipe.model1.pos[0] + stepSize/2,points[-1][1]])
    points.append([points[-1][0], dualpipe.model2.pos[1] - stepSize/2])
    points.append([dualpipe.model2.nodes[node].pos[0],points[-1][1]])
    points.append([points[-1][0], dualpipe.model2.nodes[node].pos[1] - dualpipe.model2.nodes[node].size/2])
    return pathPoints(points)

def pathConnectModel1Pipe(dualpipe, node):
    points = []
    # connects the node of Model1 with the dualpipe
    start = [dualpipe.model1.nodes[node].pos[0], dualpipe.model1.nodes[node].pos[1] - dualpipe.model1.nodes[node].size / 2]
    points.append(start)
    points.append(relPoint(start, [0,-20]))
    points.append([dualpipe.model1.pos[0] + dualpipe.model1.size / 2 + 20, points[-1][1]])
    if node == 0:
        points.append(relPoint(points[-1],[0, dualpipe.pos[1] - points[-1][1] + float(dualpipe.size) / 4]))
    else:
        points.append(relPoint(points[-1], [0, dualpipe.pos[1] - points[-1][1] - float(dualpipe.size) / 4]))
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



def main():
    import ReadGeojson
    import GeoJson_Parser_Nic
    dirname = os.path.dirname(os.path.abspath(__file__))
    urbanOptFile = dirname + '/GeoJson/exportGeo_2.json'
    modelicaDir = '/home/justus/Documents/Topology_Analysis_5GDHC_DymolaModel/Automated_5GDHC'
    #modelicaDir = dirname + '/Modelica_5GDHC_TemplateModel'
    loadDir = dirname + "/loads"

    loads = GeoJson_Parser_Nic.GetBuildingLoads(loadDir, urbanOptFile)
    data = ReadGeojson.GetData(urbanOptFile)
    tempModel = SetTemplateModel(data, modelicaDir, loads)
    return tempModel


if __name__ == '__main__':
   main()

