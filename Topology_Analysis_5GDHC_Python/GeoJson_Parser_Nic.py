import ReadGeojson

class Load(object):
    def __init__(self, cooling_ChilledWaterEnergy, cooling_Electricity, heating_HotWaterEnergy, heating_Electricity, noETS_heating_Electricity, noETS_cooling_Electricity):
        self.cooling_ChilledWaterEnergy = cooling_ChilledWaterEnergy
        self.cooling_Electricity = cooling_Electricity
        self.heating_HotWaterEnergy = heating_HotWaterEnergy
        self.heating_Electricity = heating_Electricity
        self.noETS_heating_Electricity = noETS_heating_Electricity
        self.noETS_cooling_Electricity = noETS_cooling_Electricity

def GetBuildingLoads(dir, urbanOptFile):
    cooling_ChilledWaterEnergy = dir + "/lookup_DistrictCoolingChilledWaterEnergy.csv"
    cooling_Electricity = dir + "/lookup_CoolingElectricity.csv"
    heating_HotWaterEnergy = dir + "/lookup_DistrictHeatingHotWaterEnergy.csv"
    heating_Electricity = dir + "/lookup_HeatingElectricity.csv"
    noETS_heating_Electricity = dir + "/no_ets_HeatingElectricity.csv"
    noETS_cooling_Electricity = dir + "/no_ets_CoolingElectricity.csv"
    data = GetData(urbanOptFile)
    loads = {}
    for building in data:
        if building[0] <> "District System":
            loads[building[1]] = Load(cooling_ChilledWaterEnergy, cooling_Electricity, heating_HotWaterEnergy, heating_Electricity, noETS_heating_Electricity, noETS_cooling_Electricity)
    return loads

def GetData(urbanOptFile):
    data = ReadGeojson.GetData(urbanOptFile)
    return data

if __name__ == '__main__':
    dir = '/Users/justusvonrhein/Documents/Colorado/Ambient_Loops/Topology_Analysis_5GDHC_Python/loads'
    urbanOptFile = '/Users/justusvonrhein/Documents/Colorado/Ambient_Loops/Topology_Analysis_5GDHC_Python/GeoJson/exportGeo_NREL_Presentation.json'
    print GetBuildingLoads(dir, urbanOptFile)