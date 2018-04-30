within Topology_Analysis_5GDHC.Compare_OpenStudio.Test;
model Test_Building

replaceable package Medium =
      Buildings.Media.Water "Medium model for water";

public
  Buildings.Fluid.Sources.FixedBoundary sin(redeclare package Medium = Medium,
      nPorts=1) annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          origin={70,0})));
public
  Buildings.Fluid.Sources.FixedBoundary sin1(
                                            redeclare package Medium = Medium,
      nPorts=1,
    use_T=false)
                annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          origin={-70,0})));
equation

public
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
      computeWetBulbTemperature=false, filNam=
        "modelica://Buildings/Resources/weatherdata/USA_CO_Golden-NREL.724666_TMY3dy.mos")
                                       "File reader that reads weather data"
    annotation (Placement(transformation(extent={{-74,90},{-54,110}})));
  Buildings.Utilities.Time.CalendarTime calTim(
    zerTim=Buildings.Utilities.Time.Types.ZeroTime.NY2018,
    year(start=2018),
    month(start=1))
    annotation (Placement(transformation(extent={{-74,52},{-54,72}})));
  Buildings.BoundaryConditions.WeatherData.Bus
                                     weaBus "Weather data bus"
     annotation (Placement(
        transformation(extent={{-8,92},{8,108}}),       iconTransformation(
          extent={{-328,64},{-308,84}})));
  Building.Random_Forest.RFBuilding_unidirectional_noDyn building_Lin_Reg(
      redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-28,-26},{28,26}})));
equation
  connect(weaDat.weaBus,weaBus)  annotation (Line(
      points={{-54,100},{0,100}},
      color={255,204,51},
      thickness=0.5));
  connect(calTim.month, building_Lin_Reg.month) annotation (Line(points={{-53,
          62.6},{-44,62.6},{-44,17.3333},{-30,17.3333}},
                                         color={255,127,0}));
  connect(calTim.hour, building_Lin_Reg.hour) annotation (Line(points={{-53,
          68.2},{-42,68.2},{-42,20.8},{-30,20.8}},
                                         color={255,127,0}));
  connect(calTim.weekDay, building_Lin_Reg.day) annotation (Line(points={{-53,57},
          {-40,57},{-40,24.2667},{-30,24.2667}},
                                           color={255,127,0}));
  connect(sin.ports[1], building_Lin_Reg.port_b)
    annotation (Line(points={{60,0},{27.8,0}},  color={0,127,255}));
  connect(weaBus, building_Lin_Reg.weaBus) annotation (Line(
      points={{0,100},{0,20.28}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(sin1.ports[1], building_Lin_Reg.port_a)
    annotation (Line(points={{-60,0},{-28,0}}, color={0,127,255}));
    annotation (choicesAllMatching = true,
    Diagram(coordinateSystem(extent={{-140,-100},{140,120}})),
    Icon(coordinateSystem(extent={{-140,-100},{140,120}})));
end Test_Building;
