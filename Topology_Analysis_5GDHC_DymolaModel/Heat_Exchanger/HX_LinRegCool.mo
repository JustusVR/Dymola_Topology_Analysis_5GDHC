within Topology_Analysis_5GDHC_DymolaModel.Heat_Exchanger;
model HX_LinRegCool
  import Topology_Analysis_5GDHC = Topology_Analysis_5GDHC_DymolaModel;

  Buildings.Fluid.HeatExchangers.HeaterCooler_u
                                      hea(
    m_flow_nominal=150,
    dp_nominal=10,
    Q_flow_nominal=18500,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{28,-26},{-24,24}})));

  Modelica.Blocks.Interfaces.RealOutput eleHP_cool(unit="W")
    "Electrical power consumed for space heating" annotation (Placement(
        transformation(extent={{280,230},{300,250}}), iconTransformation(extent=
           {{280,230},{300,250}})));
  Modelica.Blocks.Interfaces.RealOutput Qflow_cool(unit="W")
    "Space heating thermal load" annotation (Placement(transformation(extent={{
            280,50},{300,70}}), iconTransformation(extent={{280,50},{300,70}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(
    redeclare final package Medium = Medium,
    h_outflow(start=Medium.h_default)) "Fluid connector a"
    annotation (Placement(transformation(extent={{276,-10},{296,10}}),
        iconTransformation(extent={{260,-20},{300,20}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(
    redeclare final package Medium = Medium,
    h_outflow(start=Medium.h_default)) "Fluid connector b"
    annotation (Placement(transformation(extent={{-272,-10},{-292,10}}),
        iconTransformation(extent={{-258,-20},{-298,20}})));
  Modelica.Blocks.Interfaces.IntegerInput day
    annotation (Placement(transformation(extent={{-320,260},{-280,300}})));
  Modelica.Blocks.Interfaces.IntegerInput hour
    annotation (Placement(transformation(extent={{-320,220},{-280,260}})));
  Modelica.Blocks.Interfaces.RealInput T_outside_dryBulb
    annotation (Placement(transformation(extent={{-320,340},{-280,380}})));
  Modelica.Blocks.Interfaces.RealInput Outside_Humidity
    "Set temperature for ambient loop"
    annotation (Placement(transformation(extent={{-320,300},{-280,340}})));
  Modelica.Blocks.Interfaces.IntegerInput month
    annotation (Placement(transformation(extent={{-320,180},{-280,220}})));
  Modelica.Blocks.Sources.RealExpression m_flow(y=port_a.m_flow)
    annotation (Placement(transformation(extent={{-256,146},{-236,166}})));
  Modelica.Fluid.Sensors.Temperature Temp_inlet(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-250,90},{-230,110}})));
  replaceable package Medium =
      Modelica.Media.Interfaces.PartialMedium "Medium model for water";
  Topology_Analysis_5GDHC.Loads.Linear_Regression.Calc_LinRegCool linRegHeat
    annotation (Placement(transformation(extent={{-104,96},{-80,128}})));
  Modelica.Blocks.Math.Gain gain(k=1/18500)
    annotation (Placement(transformation(extent={{-58,50},{-38,70}})));
  Modelica.Blocks.Interfaces.RealOutput tOutletCalc
    annotation (Placement(transformation(extent={{-280,90},{-300,110}})));
equation

  connect(port_a,hea. port_a)
    annotation (Line(points={{286,0},{28,0},{28,-1}},    color={0,127,255}));
  connect(hea.port_b,port_b)
    annotation (Line(points={{-24,-1},{-24,0},{-282,0}},
                                                      color={0,127,255}));
  connect(Temp_inlet.port, port_a) annotation (Line(points={{-240,90},{-240,-80},
          {240,-80},{240,0},{286,0}},
                     color={0,127,255}));
  connect(Temp_inlet.T, linRegHeat.tInlet)
    annotation (Line(points={{-233,100},{-106,100}}, color={0,0,127}));
  connect(m_flow.y, linRegHeat.mFlow) annotation (Line(points={{-235,156},{-160,
          156},{-160,104},{-106,104}}, color={0,0,127}));
  connect(month, linRegHeat.month) annotation (Line(points={{-300,200},{-140,
          200},{-140,108},{-106,108}}, color={255,127,0}));
  connect(hour, linRegHeat.hour) annotation (Line(points={{-300,240},{-136,240},
          {-136,112},{-106,112}}, color={255,127,0}));
  connect(day, linRegHeat.day) annotation (Line(points={{-300,280},{-132,280},{
          -132,116},{-106,116}}, color={255,127,0}));
  connect(Outside_Humidity, linRegHeat.humOut) annotation (Line(points={{-300,
          320},{-126,320},{-126,120},{-106,120}}, color={0,0,127}));
  connect(gain.y, hea.u) annotation (Line(points={{-37,60},{34,60},{34,14},{
          33.2,14}},  color={0,0,127}));
  connect(linRegHeat.coolEleHP, eleHP_cool) annotation (Line(points={{-77.9,
          104.1},{0,104.1},{0,240},{290,240}}, color={0,0,127}));
  connect(linRegHeat.coolDemand, gain.u) annotation (Line(points={{-77.9,119.9},
          {-60,119.9},{-60,60}}, color={0,0,127}));
  connect(port_a, port_a)
    annotation (Line(points={{286,0},{286,0}}, color={0,127,255}));
  connect(linRegHeat.coolTOutlet, tOutletCalc) annotation (Line(points={{-77.9,
          112.1},{-70,112.1},{-70,80},{-180,80},{-180,120},{-260,120},{-260,100},
          {-290,100}}, color={0,0,127}));
  connect(T_outside_dryBulb, linRegHeat.tOutside) annotation (Line(points={{
          -300,360},{-120,360},{-120,124},{-106,124}}, color={0,0,127}));
  connect(linRegHeat.coolDemand, Qflow_cool) annotation (Line(points={{-77.9,
          119.9},{101.05,119.9},{101.05,60},{290,60}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(extent={{-280,-100},{280,420}})),
    Icon(coordinateSystem(extent={{-280,-100},{280,420}}), graphics={Rectangle(
          extent={{-280,420},{280,-100}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Rectangle(
          extent={{-138,266},{158,60}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid)}));
end HX_LinRegCool;
