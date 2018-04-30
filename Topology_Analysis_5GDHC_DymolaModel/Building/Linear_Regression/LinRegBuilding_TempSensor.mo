within Topology_Analysis_5GDHC.Building.Linear_Regression;
model LinRegBuilding_TempSensor

  Modelica.Fluid.Interfaces.FluidPort_a port_a(
    redeclare final package Medium = Medium,
    h_outflow(start=Medium.h_default)) "Fluid connector a"
    annotation (Placement(transformation(extent={{-290,-10},{-270,10}}),
        iconTransformation(extent={{-300,-20},{-260,20}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(
    redeclare final package Medium = Medium,
    h_outflow(start=Medium.h_default)) "Fluid connector b"
    annotation (Placement(transformation(extent={{290,-10},{270,10}}),
        iconTransformation(extent={{298,-20},{258,20}})));
  Modelica.Blocks.Interfaces.IntegerInput day
    annotation (Placement(transformation(extent={{-320,260},{-280,300}})));
  Modelica.Blocks.Interfaces.IntegerInput hour
    annotation (Placement(transformation(extent={{-320,220},{-280,260}})));
  Modelica.Blocks.Interfaces.IntegerInput month
    annotation (Placement(transformation(extent={{-320,180},{-280,220}})));
  replaceable package Medium =
      Modelica.Media.Interfaces.PartialMedium "Medium model for water";
  Buildings.BoundaryConditions.WeatherData.Bus
                                     weaBus annotation (Placement(
        transformation(extent={{-20,260},{20,300}}), iconTransformation(extent=
            {{-10,224},{10,244}})));
  Topology_Analysis_5GDHC.Heat_Exchanger.HX_LinRegHeat linRegHeat_HX(redeclare
      package Medium = Medium)
    annotation (Placement(transformation(extent={{-30,140},{26,192}})));
protected
  Buildings.Fluid.Delays.DelayFirstOrder del(
    nPorts=3,
    redeclare package Medium = Medium,
    m_flow_nominal=1)
    annotation (Placement(transformation(extent={{-250,22},{-230,42}})));
public
  Buildings.Fluid.Movers.FlowControlled_m_flow pump(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    addPowerToMedium=false,
    inputType=Buildings.Fluid.Types.InputType.Continuous)
    annotation (Placement(transformation(extent={{-150,140},{-130,160}})));
protected
  Modelica.Blocks.Sources.Constant const(k=0.07)
    annotation (Placement(transformation(extent={{-176,172},{-160,188}})));
public
  Modelica.Blocks.Interfaces.RealOutput eleHP_heat
    "Electrical power consumed for space heating"
    annotation (Placement(transformation(extent={{280,164},{300,184}})));
  Modelica.Blocks.Interfaces.RealOutput Qflow_heat "Space heating thermal load"
    annotation (Placement(transformation(extent={{280,146},{300,166}})));
protected
  Buildings.Fluid.Delays.DelayFirstOrder del1(
    nPorts=3,
    redeclare package Medium = Medium,
    m_flow_nominal=1)
    annotation (Placement(transformation(extent={{230,18},{250,38}})));
public
  Topology_Analysis_5GDHC.Heat_Exchanger.HX_LinRegCool linRegCool_HX(redeclare
      package Medium = Medium)
    annotation (Placement(transformation(extent={{-28,-192},{28,-140}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump1(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    addPowerToMedium=false,
    inputType=Buildings.Fluid.Types.InputType.Continuous)
    annotation (Placement(transformation(extent={{144,-172},{124,-192}})));
protected
  Modelica.Blocks.Sources.Constant const1(k=0.09)
    annotation (Placement(transformation(extent={{102,-228},{118,-212}})));
public
  Modelica.Blocks.Interfaces.RealOutput eleHP_cool
    "Electrical power consumed for space heating"
    annotation (Placement(transformation(extent={{280,-168},{300,-148}})));
  Modelica.Blocks.Interfaces.RealOutput Qflow_cool "Space heating thermal load"
    annotation (Placement(transformation(extent={{280,-186},{300,-166}})));
protected
  Modelica.Fluid.Sensors.Temperature Temp_b(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{190,-270},{210,-250}})));
  Modelica.Blocks.Math.UnitConversions.To_degC toCb
    annotation (Placement(transformation(extent={{232,-270},{252,-250}})));
protected
  Modelica.Fluid.Sensors.Temperature Temp_a(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-190,-270},{-210,-250}})));
  Modelica.Blocks.Math.UnitConversions.To_degC toCa
    annotation (Placement(transformation(extent={{-232,-270},{-252,-250}})));
public
  Modelica.Blocks.Interfaces.RealOutput tempB "Temperature in port medium"
    annotation (Placement(transformation(extent={{280,-270},{300,-250}})));
public
  Modelica.Blocks.Interfaces.RealOutput tempA "Temperature in port medium"
    annotation (Placement(transformation(extent={{-282,-270},{-302,-250}})));
equation

  connect(port_a, del.ports[1]) annotation (Line(points={{-280,0},{-242.667,0},
          {-242.667,22}}, color={0,127,255}));
  connect(del.ports[2], pump.port_a) annotation (Line(points={{-240,22},{-240,
          22},{-240,0},{-220,0},{-220,150},{-150,150}}, color={0,127,255}));
  connect(pump.port_b, linRegHeat_HX.port_a)
    annotation (Line(points={{-130,150},{-30,150}}, color={0,127,255}));
  connect(port_a, port_a)
    annotation (Line(points={{-280,0},{-280,0}}, color={0,127,255}));
  connect(day, linRegHeat_HX.day) annotation (Line(points={{-300,280},{-80,280},
          {-80,178},{-32,178}}, color={255,127,0}));
  connect(hour, linRegHeat_HX.hour) annotation (Line(points={{-300,240},{-80,
          240},{-80,174},{-32,174}}, color={255,127,0}));
  connect(month, linRegHeat_HX.month) annotation (Line(points={{-300,200},{-80,
          200},{-80,170},{-32,170}},           color={255,127,0}));
  connect(weaBus.TDryBul, linRegHeat_HX.T_outside_dryBulb) annotation (Line(
      points={{0,280},{-60,280},{-60,186},{-32,186}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(weaBus.relHum, linRegHeat_HX.Outside_Humidity) annotation (Line(
      points={{0,280},{-60,280},{-60,182},{-32,182}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(const.y, pump.m_flow_in) annotation (Line(points={{-159.2,180},{-140,
          180},{-140,162}}, color={0,0,127}));
  connect(linRegHeat_HX.eleHP_heat, eleHP_heat)
    annotation (Line(points={{27,174},{290,174}}, color={0,0,127}));
  connect(linRegHeat_HX.Qflow_heat, Qflow_heat)
    annotation (Line(points={{27,156},{290,156}}, color={0,0,127}));
  connect(linRegHeat_HX.port_b, del1.ports[1]) annotation (Line(points={{25.8,
          150},{220,150},{220,0},{237.333,0},{237.333,18}}, color={0,127,255}));
  connect(port_b, del1.ports[2])
    annotation (Line(points={{280,0},{240,0},{240,18}}, color={0,127,255}));
  connect(eleHP_heat, eleHP_heat)
    annotation (Line(points={{290,174},{290,174}}, color={0,0,127}));
  connect(pump1.port_a, del1.ports[3]) annotation (Line(points={{144,-182},{
          242.667,-182},{242.667,18}}, color={0,127,255}));
  connect(const1.y, pump1.m_flow_in) annotation (Line(points={{118.8,-220},{134,
          -220},{134,-194}}, color={0,0,127}));
  connect(linRegCool_HX.eleHP_cool, eleHP_cool)
    annotation (Line(points={{29,-158},{290,-158}}, color={0,0,127}));
  connect(eleHP_cool, eleHP_cool)
    annotation (Line(points={{290,-158},{290,-158}}, color={0,0,127}));
  connect(linRegCool_HX.Qflow_cool, Qflow_cool)
    annotation (Line(points={{29,-176},{290,-176}}, color={0,0,127}));
  connect(weaBus.relHum, linRegCool_HX.Outside_Humidity) annotation (Line(
      points={{0,280},{-60,280},{-60,-150},{-30,-150}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(weaBus.TDryBul, linRegCool_HX.T_outside_dryBulb) annotation (Line(
      points={{0,280},{-60,280},{-60,-146},{-30,-146}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(day, linRegCool_HX.day) annotation (Line(points={{-300,280},{-80,280},
          {-80,-154},{-30,-154}}, color={255,127,0}));
  connect(hour, linRegCool_HX.hour) annotation (Line(points={{-300,240},{-80,
          240},{-80,-158},{-30,-158}}, color={255,127,0}));
  connect(month, linRegCool_HX.month) annotation (Line(points={{-300,200},{-80,
          200},{-80,-162},{-30,-162}}, color={255,127,0}));
  connect(pump1.port_b, linRegCool_HX.port_a)
    annotation (Line(points={{124,-182},{28,-182}}, color={0,127,255}));
  connect(linRegCool_HX.port_b, del.ports[3]) annotation (Line(points={{-27.8,
          -182},{-237.333,-182},{-237.333,22}}, color={0,127,255}));
  connect(Temp_b.T,toCb. u)
    annotation (Line(points={{207,-260},{230,-260}}, color={0,0,127}));
  connect(toCb.y,tempB)
    annotation (Line(points={{253,-260},{290,-260}}, color={0,0,127}));
  connect(Temp_b.port, port_b) annotation (Line(points={{200,-270},{180,-270},{
          180,-42},{262,-42},{262,0},{280,0}}, color={0,127,255}));
  connect(Temp_a.T,toCa. u)
    annotation (Line(points={{-207,-260},{-230,-260}}, color={0,0,127}));
  connect(Temp_a.port, port_a) annotation (Line(points={{-200,-270},{-182,-270},
          {-182,-20},{-260,-20},{-260,0},{-280,0}}, color={0,127,255}));
  connect(toCa.y,tempA)
    annotation (Line(points={{-253,-260},{-292,-260}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(extent={{-280,-300},{280,300}})),
    Icon(coordinateSystem(extent={{-280,-300},{280,300}}), graphics={Rectangle(
          extent={{-280,300},{280,-300}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Rectangle(
          extent={{-266,118},{262,-282}},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{58,46},{176,-52}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
      Polygon(
        points={{0,264},{-266,118},{262,118},{0,264}},
        lineColor={95,95,95},
        smooth=Smooth.None,
        fillPattern=FillPattern.Solid,
        fillColor={95,95,95}),
        Rectangle(
          extent={{-188,-116},{-74,-282}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{58,-4},{116,-52}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{58,46},{116,-2}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{118,46},{176,-2}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{118,-4},{176,-52}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-98,-200},{-84,-214}},
          pattern=LinePattern.None,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid)}));
end LinRegBuilding_TempSensor;
