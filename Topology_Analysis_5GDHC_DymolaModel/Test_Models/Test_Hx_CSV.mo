within Topology_Analysis_5GDHC_DymolaModel.Test_Models;
model Test_Hx_CSV

replaceable package Medium =
      Buildings.Media.Water "Medium model for water";

parameter String Heating_DQ_File = Modelica.Utilities.Files.loadResource("modelica://Topology_Analysis_5GDHC_DymolaModel/Resources/Loads/LookUp_Table/heating_DistrictHeatingHotWaterEnergy_mass_flow_0.25.mos");
parameter String Cooling_DQ_File = Modelica.Utilities.Files.loadResource("modelica://Topology_Analysis_5GDHC_DymolaModel/Resources/Loads/LookUp_Table/cooling_DistrictCoolingChilledWaterEnergy_mass_flow_0.75.mos");
parameter String Heating_IQ_File = Modelica.Utilities.Files.loadResource("modelica://Topology_Analysis_5GDHC_DymolaModel/Resources/Loads/LookUp_Table/no_ets_HeatingElectricity.mos");
parameter String Cooling_IQ_File = Modelica.Utilities.Files.loadResource("modelica://Topology_Analysis_5GDHC_DymolaModel/Resources/Loads/LookUp_Table/no_ets_CoolingElectricity.mos");
parameter String Heating_HP_ele_File = Modelica.Utilities.Files.loadResource("modelica://Topology_Analysis_5GDHC_DymolaModel/Resources/Loads/LookUp_Table/heating_HeatingElectricity_mass_flow_0.25.mos");
parameter String Cooling_HP_ele_File = Modelica.Utilities.Files.loadResource("modelica://Topology_Analysis_5GDHC_DymolaModel/Resources/Loads/LookUp_Table/cooling_CoolingElectricity_mass_flow_0.75.mos");


  Modelica.Blocks.Sources.Ramp ramp(
    duration(displayUnit="d") = 8640000,
    height=4,
    offset=273.15 + 18)
    annotation (Placement(transformation(extent={{-120,-20},{-100,0}})));

protected
  Modelica.Blocks.Sources.BooleanConstant buildingConnected(k=true)
    annotation (Placement(transformation(extent={{-12,-12},{12,12}},rotation=0,origin={-110,30})));
public
  Loads.Load_Calc heatingLoad(DQ_FileName=Heating_DQ_File, HP_ele_FileName=
        Heating_HP_ele_File,
    IQ_FileName=Heating_IQ_File)
                             annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={0,0})));
equation

  connect(buildingConnected.y, heatingLoad.u) annotation (Line(points={{-96.8,
          30},{-90,30},{-90,0},{-24,0}}, color={255,0,255}));
  connect(ramp.y, heatingLoad.T_Inlet) annotation (Line(points={{-99,-10},{-64,
          -10},{-64,-12},{-24,-12}}, color={0,0,127}));
    annotation (choicesAllMatching = true,
    Diagram(coordinateSystem(extent={{-140,-100},{140,120}})),
    Icon(coordinateSystem(extent={{-140,-100},{140,120}})));
end Test_Hx_CSV;
