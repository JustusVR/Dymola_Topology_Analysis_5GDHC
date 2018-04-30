import linecache
import os

moFile = "Pipe.mo"
basePackagePath = "/Users/justusvonrhein/Documents/Colorado/Ambient_Loops/shared_ubuntu/"
packagePath = "/Users/justusvonrhein/Documents/Colorado/Ambient_Loops/shared_ubuntu/Buildings/Fluid/FixedResistances"

extendedModul = []
predefinedParameters = []
parameter = []
os.chdir(packagePath)

def main():
    findParameters(moFile)
    findExtendedModules(moFile)
    print " "
    while len(extendedModul) <> 0:  #iteration through all extended module, Note: if extended module are further extended modules, these will be added to list extendedModule[]
        currentModel = extendedModul[0][(extendedModul[0].rfind(".")+1):] + ".mo"       #define *.mo File from string extendedModule
        currentPath = basePackagePath + (extendedModul[0][:(extendedModul[0].rfind("."))]).replace(".","/")     #define path for *.mo File from string extendedModule
        os.chdir(currentPath)
        findParameters(currentModel)
        findExtendedModules(currentModel)
        extendedModul.pop(0)
    #print parameter
    #print predefinedParameters


def findParameters(model):
    global parameter
    marker = ["=", " ", "(", r' "']                               #these mark the end of the parameter name declaration
    with  open(model, "r") as fp:
        for line in fp:
            if line.find("  parameter ") == 0:                     #is it a paramter defining line
                x1 = line[(len("  parameter ")):].find(" ")        #find beginning of parameter name after its declaration
                x1 += len("  parameter ") + 1
                s = False
                x2 = x1
                while s == False:
                    x2 += 1
                    if len(line) == x2:
                        x2 -=1
                        break
                    if line[x2] in marker:
                        s = True
                parameter.append(line[x1:x2])
                if (line[(len("  parameter ")):].find("=") <> -1) and (line[x1:x2] not in predefinedParameters ):
                    predefinedParameters.append(line[x1:x2])
    return parameter


def findExtendedModules(model):
    global extendedModul
    global predefinedParameters
    marker = ["=", "("]
    z = 0
    print model
    with  open(model, "r") as fp:
        for line in fp:
            z += 1       #counting lines
            #print z
            #print line
            if line.find("  extends ") <> -1:
                x1 = len("  extends ")
                x2 = line[(len("  extends ")):].find("(")
                if x2 == -1:
                    extendedModul.append(line[x1:-2])     #line ends, no parameter predefined
                else:
                    s = False
                    while s == False:                     # if False, parameters are still being defined in the next line
                        #print linecache.getline(model, z)
                        if linecache.getline(model, z).find("=") <> -1 :
                            while (linecache.getline(model, z)[x1]) == " ":
                                x1 += 1
                            x2 = x1
                            while linecache.getline(model, z)[x2] not in marker:
                                x2 += 1
                            #print linecache.getline(model, z)[x1:x2]
                            if linecache.getline(model, z)[x1:x2] == "final":
                                print "hi"
                                x1 = x2
                                continue
                            predefinedParameters.append(linecache.getline(model, z)[x1:x2])
                        if linecache.getline(model, z).find(";") <> -1:
                            s = True
                        x1 = 0
                        x2 = 0
                        z += 1
    return extendedModul

def findPredefinedParameters(model, extendedModel):
    predefinedParameters = []
    with  open(model, "r") as fp:
        for line in fp:
            if line.find(extendedModul) <> -1:
                x1 = line.find(extendedModul)
                x2 = line[(len("  extends ")):].find("(")
                if x2 <> -1:    #if x2 == -1 then no parameters are predefined for this model
                    x2 += x1
                    print line[x1:x2]
                    extendedModul.append(line[x1:x2])
                    if line[x2:].find("=") <> -1:
                        p = line[(x2 + 1):line.find("=")]
                        predefinedParameters.append(p)
                    while True:
                        z += 1
                        p = linecache.getline(moFile, z)[:(linecache.getline(moFile, z).find("="))]
                        x3 = p.find("(")
                        if x3 <> -1: p = p[:x3]
                        while (p.find(" ")) <> - 1:  # delete spaces infront of parameter
                            p = p[(p.find(" ") + 1):]
                        predefinedParameters.append(p)
                        if linecache.getline(moFile, z).find(
                                ";") <> -1:  # declaration of parameters for this model is done
                            break
    return predefinedParameters



def teester():
    test = [1,2]
    i = 2
    while len(test) <> 0:
        print test[0]
        test.pop(0)
        if i < 5:
            i += 1
            test.append(i)

#teester()

#extendedModul = findExtendedModules(moFile)

#raw_string_with_quotes = r'double"' r"single'" r'''double triple""" ''' r"""single triple''' """









if __name__ == '__main__':
    main()


#parameter = findParameters()


#for p in parameter:



