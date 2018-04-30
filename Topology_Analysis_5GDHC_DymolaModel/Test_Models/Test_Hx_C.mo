within Topology_Analysis_5GDHC_DymolaModel.Test_Models;
model Test_Hx_C

replaceable package Medium =
      Buildings.Media.Water "Medium model for water";

public
  Buildings.Fluid.Sources.FixedBoundary sin(redeclare package Medium = Medium,
      nPorts=1) annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          origin={110,0})));
public
  Buildings.Fluid.Sources.MassFlowSource_T sou(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1)      "Mass flow source"
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Modelica.Blocks.Sources.Constant const1(k=293.15)
    annotation (Placement(transformation(extent={{-136,-30},{-116,-10}})));
  Modelica.Blocks.Math.Gain gain(k=1/(4187*6))
    annotation (Placement(transformation(extent={{-38,-44},{-58,-24}})));
  Heat_Exchanger.HX_LinRegHeat hX_LinRegHeat(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-30,-10},{26,42}})));
public
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
      computeWetBulbTemperature=false, filNam=
        "/home/justus/Documents/Topology_Analysis_5GDHC/Resources/Weather_File/USA_CO_Golden-NREL.724666_TMY3dy.mos")
                                       "File reader that reads weather data"
    annotation (Placement(transformation(extent={{-100,90},{-80,110}})));
  Buildings.BoundaryConditions.WeatherData.Bus
                                     weaBus "Weather data bus"
     annotation (Placement(
        transformation(extent={{-68,66},{-52,82}}),     iconTransformation(
          extent={{-328,64},{-308,84}})));
  Buildings.Utilities.Time.CalendarTime calTim(
    zerTim=Buildings.Utilities.Time.Types.ZeroTime.NY2018,
    year(start=2018),
    month(start=1))
    annotation (Placement(transformation(extent={{-100,52},{-80,72}})));
equation

  connect(gain.y, sou.m_flow_in) annotation (Line(points={{-59,-34},{-72,-34},{
          -72,32},{-108,32},{-108,8},{-100,8}}, color={0,0,127}));
  connect(const1.y, sou.T_in) annotation (Line(points={{-115,-20},{-110,-20},{
          -110,4},{-102,4}}, color={0,0,127}));
  connect(sou.ports[1], hX_LinRegHeat.port_a)
    annotation (Line(points={{-80,0},{-30,0}}, color={0,127,255}));
  connect(sin.ports[1], hX_LinRegHeat.port_b)
    annotation (Line(points={{100,0},{25.8,0}}, color={0,127,255}));
  connect(hX_LinRegHeat.Qflow_heat, gain.u) annotation (Line(points={{27,6},{
          40,6},{40,-34},{-36,-34}}, color={0,0,127}));
  connect(weaDat.weaBus, weaBus) annotation (Line(
      points={{-80,100},{-60,100},{-60,74}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(weaBus.TDryBul, hX_LinRegHeat.T_outside_dryBulb) annotation (Line(
      points={{-60,74},{-60,36},{-32,36}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(weaBus.relHum, hX_LinRegHeat.Outside_Humidity) annotation (Line(
      points={{-60,74},{-60,32},{-32,32}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(calTim.hour, hX_LinRegHeat.hour) annotation (Line(points={{-79,68.2},
          {-65.5,68.2},{-65.5,24},{-32,24}}, color={255,127,0}));
  connect(calTim.weekDay, hX_LinRegHeat.day) annotation (Line(points={{-79,57},
          {-65.5,57},{-65.5,28},{-32,28}}, color={255,127,0}));
  connect(calTim.month, hX_LinRegHeat.month) annotation (Line(points={{-79,
          62.6},{-66.5,62.6},{-66.5,20},{-32,20}}, color={255,127,0}));
    annotation (choicesAllMatching = true,
    Diagram(coordinateSystem(extent={{-140,-100},{140,120}})),
    Icon(coordinateSystem(extent={{-140,-100},{140,120}})));
end Test_Hx_C;
