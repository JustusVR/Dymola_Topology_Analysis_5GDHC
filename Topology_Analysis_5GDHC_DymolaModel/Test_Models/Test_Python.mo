within Topology_Analysis_5GDHC_DymolaModel.Test_Models;
model Test_Python

replaceable package Medium =
      Buildings.Media.Water "Medium model for water";

  Modelica.Blocks.Sources.Constant Inlet_Temp(k=273.15)
    annotation (Placement(transformation(extent={{-120,-50},{-100,-30}})));
  Buildings.Utilities.Time.CalendarTime calTim(
    zerTim=Buildings.Utilities.Time.Types.ZeroTime.NY2018,
    year(start=2018),
    month(start=1))
    annotation (Placement(transformation(extent={{-120,-8},{-100,12}})));
public
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
      computeWetBulbTemperature=false, filNam=
        "/home/justus/Documents/Topology_Analysis_5GDHC/Resources/Weather_File/USA_CO_Golden-NREL.724666_TMY3dy.mos")
                                       "File reader that reads weather data"
    annotation (Placement(transformation(extent={{-120,40},{-100,60}})));
  Buildings.BoundaryConditions.WeatherData.Bus
                                     weaBus "Weather data bus"
     annotation (Placement(
        transformation(extent={{-88,42},{-72,58}}),     iconTransformation(
          extent={{-328,64},{-308,84}})));
  Loads.Random_Forest.Calc_py calc_py
    annotation (Placement(transformation(extent={{-30,-30},{36,34}})));
  Modelica.Blocks.Sources.Constant Inlet_Temp1(k=1)
    annotation (Placement(transformation(extent={{44,70},{24,90}})));
  Modelica.Blocks.Sources.Constant Inlet_Temp2(k=1)
    annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
equation

  connect(weaDat.weaBus,weaBus)  annotation (Line(
      points={{-100,50},{-80,50}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus.TDryBul, calc_py.tOutside) annotation (Line(
      points={{-80,50},{-60,50},{-60,26},{-35.5,26}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(weaBus.relHum, calc_py.humOut) annotation (Line(
      points={{-80,50},{-60,50},{-60,18},{-35.5,18}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(calTim.month, calc_py.month) annotation (Line(points={{-99,2.6},{
          -59.5,2.6},{-59.5,10},{-35.5,10}}, color={255,127,0}));
  connect(calTim.hour, calc_py.hour) annotation (Line(points={{-99,8.2},{-59.5,
          8.2},{-59.5,2},{-35.5,2}}, color={255,127,0}));
  connect(calTim.weekDay, calc_py.weekday) annotation (Line(points={{-99,-3},{
          -59.5,-3},{-59.5,-6},{-36.05,-6}},color={255,127,0}));
  connect(Inlet_Temp.y, calc_py.tInlet) annotation (Line(points={{-99,-40},{-70,
          -40},{-70,-18},{-35.5,-18}}, color={0,0,127}));
  connect(Inlet_Temp2.y, calc_py.season) annotation (Line(points={{-19,80},{-12,
          80},{-12,38},{-2.5,38}}, color={0,0,127}));
  connect(Inlet_Temp1.y, calc_py.modelType) annotation (Line(points={{23,80},{
          14,80},{14,38},{8.5,38}}, color={0,0,127}));
    annotation (choicesAllMatching = true,
    Diagram(coordinateSystem(extent={{-140,-100},{140,120}})),
    Icon(coordinateSystem(extent={{-140,-100},{140,120}})));
end Test_Python;
