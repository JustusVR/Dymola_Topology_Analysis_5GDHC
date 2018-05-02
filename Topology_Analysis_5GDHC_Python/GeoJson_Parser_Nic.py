import ReadGeojson


class Load(object):
    def __init__(self, cooling_ChilledWaterEnergy, cooling_Electricity, heating_HotWaterEnergy, heating_Electricity):
        self.cooling_ChilledWaterEnergy = cooling_ChilledWaterEnergy
        self.cooling_Electricity = cooling_Electricity
        self.heating_HotWaterEnergy = heating_HotWaterEnergy
        self.heating_Electricity = heating_Electricity

def GetBuildingLoads(dir, urbanOptFile):
    cooling_ChilledWaterEnergy = dir + "/cooling_DistrictCoolingChilledWaterEnergy_mass_flow_0.75.csv"
    cooling_Electricity = dir + "/cooling_CoolingElectricity_mass_flow_0.75.csv"
    heating_HotWaterEnergy = dir + "/heating_DistrictHeatingHotWaterEnergy_mass_flow_0.25.csv"
    heating_Electricity = dir + "/heating_HeatingElectricity_mass_flow_0.25.csv"
    data = GetData(urbanOptFile)
    loads = {}
    for building in data:
        if building[0] <> "District System":
            loads[building[1]] = Load(cooling_ChilledWaterEnergy, cooling_Electricity, heating_HotWaterEnergy, heating_Electricity)
    return loads

def GetData(urbanOptFile):
    data = ReadGeojson.GetData(urbanOptFile)
    return data

if __name__ == '__main__':
    dir = "/Users/justusvonrhein/Documents/Colorado/Ambient_Loops/Automated_Model_Building_v3/loads"
    urbanOptFile = '/Users/justusvonrhein/Documents/Colorado/Ambient_Loops/Automated_Model_Building/GeoJson/exportGeo_6_Buildings2.json'
    print GetBuildingLoads(dir, urbanOptFile)

