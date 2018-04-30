

class Building:
    def __init__(self, model, name, posX, posY, size):
        self.model = model
        self.name = name
        self.posX = posX
        self.posY = posY
        self.center = "{%s,%s}" % (str(posX), str(posY))
        self.size = size
        self.placer = "{%s,%s},{%s,%s}" %  (str(posX-size/2),str(posY-size/2),str(posX+size/2),str(posY+size/2))

class Pipe:
    def __init__(self, name, posX, posY, size):
        self.name = name
        self.posX = posX
        self.posY = posY
        self.size = size
        self.pos = "{%s,%s}" % (str(posX), str(posY))


class Port:
    def __init__(self, name, posX, posY, size):
        self.name = name
        self.posX = posX
        self.posY = posY
        self.size = size
        self.pos = "{%s,%s}" % (str(posX), str(posY))

def main():
    global modellist
    global pipeList
    global portList
    pipeList = []
    portList = []
    modellist = []

    modellist.append(Building("Plant.Heater_Chiller_automate", "plant", 0, 0, 20))
    modellist.append(Building("RFBuilding_unidirectional_automated", "Building1", 150, -100, 40))
    modellist.append(Building("RFBuilding_unidirectional_automated", "Building2", 150, 100, 40))
    modellist.append(Building("RFBuilding_unidirectional_automated", "Building3", -150,-100, 40))
    modellist.append(Building("RFBuilding_unidirectional_automated", "Building4", -150, 100, 40))

    fileName = "Automated_5GDHC"
    modelName = "Test"
    templateBuilding = "RFBuilding_unidirectional_automated_temp.mo"
    buildingModel = "RFBuilding_unidirectional_automated.mo"

    createModels(templateBuilding, buildingModel)
    create5GDHCModel(fileName, modelName)

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

def searchIndex(modelName):
    index = 1
    for x in modellist:
        if x.name == modelName:
            return index
        index += 1

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

def addModels(model, modelName, pos):
    str1 = ("    %s %s(\n" % (model, modelName))
    str2 = ("      redeclare package Medium = Medium)\n")
    str3 = ("      annotation (Placement(transformation(extent={%s})));\n" % (pos))
    str4  = str1 + str2 + str3
    return str4

def connectModels(fileName, model1, portModel1, model2, portModel2, path):
    str1 = "    connect(%s.%s, %s.%s)\n" % (model1, portModel1, model2, portModel2)
    #str2 = "      annotation (Line(points=%s, color={0,127,255}));\n" % path
    str3 = str1
    return str3

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


def initialiseModel(fileName, modelName):
    str1 = ("within LinReg_District_Heating_Cooling;\n")
    str2 = ("package %s\n" % (fileName))
    str3 = ("  model %s\n" % (modelName))
    str4 = ("\n")
    str5 = ("  replaceable package Medium =\n")
    str6 = ("       Buildings.Media.Water \"Medium model for water\";\n")
    str7 = ("\n")
    str8 = str1 + str2 + str3 + str4 + str5 + str6 + str7
    return str8

def create5GDHCModel(fileName, modelName):
    f = open((fileName + ".mo"), "w+")
    f.write(initialiseModel(fileName, modelName))
    i = 0
    #Adding load models
    for x in modellist:
        i += 1
        f.write(addModels(x.model, x.name, x.placer))

    f.write("\n")
    f.write("  equation\n")

    #Connection load models
    for x in modellist:
        i = 0
        y = 0
        while i < len(modellist):
            if x.name <> modellist[i].name:
                y +=1
                f.write(connectModels(fileName, x.name, ("pipeA_" + str(y)), modellist[i].name, "portB", "bla"))
            i += 1
    f.write("\n")
    f.write(endModel(fileName, modelName))
    f.close()

def endModel(fileName, modelName):
    str1 = ("    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-220,-180},{220,180}})), Diagram(\n")
    str2 = ("          coordinateSystem(preserveAspectRatio=false, extent={{-220,-180},{220,180}})));\n")
    str3 = ("  end %s;\n" % (modelName))
    str4 = ("end %s;" % (fileName) )
    str5 = str1 + str2 + str3 + str4
    return str5

def main2():

    n = 8
    posX = 0
    posY = 0
    sizeX = 56
    sizeY = 60
    buildingModel = "Substation.RFBuilding_unidirectional"
    buildingName = "Building"
    listBuildingsName = []
    listBuildingsPosX = []
    listBuildingsPosY = []


    posPlantX = posX
    posPlantY = posY
    createModels(posX, posY, sizeX, sizeY, "Plant.Heater_Chiller_automate", "plant")
    for i in range(1, (n + 1)):
        posX = posX + sizeX + 80
        posY = posY
        listBuildingsName.append(buildingName + str(i))
        listBuildingsPosX.append(posX)
        listBuildingsPosY.append(posY)
        createModels(posX, posY, sizeX, sizeY, buildingModel, (buildingName + str(i)))
    f = open("Automated_Building.mo", "a")
    f.write("  equation\n")
    f.close()
    plantConnectorXA = 0
    plantConnectorXB = sizeX
    plantConnectorY = sizeY / 2
    pathPlantB = "{%s,%s,%s," % (
    placer(plantConnectorXB, plantConnectorY), placer((plantConnectorXB + 20), plantConnectorY),
    placer((plantConnectorXB + 20), (plantConnectorY + 40)))
    pathPlantA = ",%s,%s,%s}" % (
    placer((plantConnectorXA - 20), (plantConnectorY - 40)), placer((plantConnectorXA - 20), plantConnectorY),
    placer(plantConnectorXA, plantConnectorY))
    for m in range(0, len(listBuildingsName)):
        portModelPosXA = listBuildingsPosX[m]
        portModelPosXB = listBuildingsPosX[m] + sizeX
        portModelPosY = listBuildingsPosY[m] + sizeY / 2
        connectionPath1 = pathPlantB + ("%s,%s,%s}" % (
        placer((portModelPosXA - 20), (portModelPosY + 40)), placer((portModelPosXA - 20), portModelPosY),
        placer(portModelPosXA, portModelPosY)))
        connectionPath2 = ("{%s,%s,%s" % (
        placer(portModelPosXB, portModelPosY), placer((portModelPosXB + 20), portModelPosY),
        placer((portModelPosXB + 20), (portModelPosY - 40)))) + pathPlantA
        connectModels("plant", "port_b", listBuildingsName[m], "port_a", connectionPath1)
        connectModels(listBuildingsName[m], "port_b", "plant", "port_a", connectionPath2)
    f = open("Automated_Building.mo", "a")
    f.write("    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(\n")
    f.write("          coordinateSystem(preserveAspectRatio=false)));\n")
    f.write("  end Test1;\n")
    f.write("end Automated_Building;\n")
    f.close()




def placer(posX, posY):
    pos = "{%s,%s}" % (str(posX), str(posY))
    return pos


if __name__ == "__main__":
    main()
