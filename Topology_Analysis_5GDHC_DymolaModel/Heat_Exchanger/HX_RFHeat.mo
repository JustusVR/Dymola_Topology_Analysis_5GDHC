within Topology_Analysis_5GDHC_DymolaModel.Heat_Exchanger;
model HX_RFHeat
  import Topology_Analysis_5GDHC = Topology_Analysis_5GDHC_DymolaModel;

  Buildings.Fluid.HeatExchangers.HeaterCooler_u
                                      hea(
    dp_nominal=10,
    redeclare package Medium = Medium,
    Q_flow_nominal=6000,
    m_flow_nominal=0.3)
    annotation (Placement(transformation(extent={{-24,-26},{28,24}})));

  Modelica.Blocks.Interfaces.RealOutput eleHP_heat(unit="W")
    "Electrical power consumed for space heating" annotation (Placement(
        transformation(extent={{280,230},{300,250}}), iconTransformation(extent=
           {{280,230},{300,250}})));
  Modelica.Blocks.Interfaces.RealOutput Qflow_heat(unit="W")
    "Space heating thermal load" annotation (Placement(transformation(extent={{
            280,50},{300,70}}), iconTransformation(extent={{280,50},{300,70}})));
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
  Topology_Analysis_5GDHC.Loads.Random_Forest.Calc_RFHeat_py python_ROM
    annotation (Placement(transformation(extent={{-104,96},{-80,128}})));
  Modelica.Blocks.Interfaces.RealOutput tOutletCalc
    annotation (Placement(transformation(extent={{280,102},{300,122}})));
  Modelica.Blocks.Math.Gain power(k=-1/6000)
    annotation (Placement(transformation(extent={{-52,40},{-32,60}})));
equation

  connect(port_a,hea. port_a)
    annotation (Line(points={{-280,0},{-24,0},{-24,-1}}, color={0,127,255}));
  connect(hea.port_b,port_b)
    annotation (Line(points={{28,-1},{28,0},{280,0}}, color={0,127,255}));
  connect(Temp_inlet.port, port_a) annotation (Line(points={{-240,90},{-240,0},
          {-280,0}}, color={0,127,255}));
  connect(Temp_inlet.T,python_ROM. tInlet)
    annotation (Line(points={{-233,100},{-106,100}}, color={0,0,127}));
  connect(m_flow.y,python_ROM. mFlow) annotation (Line(points={{-235,156},{-160,
          156},{-160,104},{-106,104}}, color={0,0,127}));
  connect(month,python_ROM. month) annotation (Line(points={{-300,200},{-140,
          200},{-140,108},{-106,108}}, color={255,127,0}));
  connect(hour,python_ROM. hour) annotation (Line(points={{-300,240},{-136,240},
          {-136,112},{-106,112}}, color={255,127,0}));
  connect(day,python_ROM. day) annotation (Line(points={{-300,280},{-132,280},{
          -132,116},{-106,116}}, color={255,127,0}));
  connect(Outside_Humidity,python_ROM. humOut) annotation (Line(points={{-300,
          320},{-126,320},{-126,120},{-106,120}}, color={0,0,127}));
  connect(T_outside_dryBulb,python_ROM. tOutside) annotation (Line(points={{
          -300,360},{-118,360},{-118,124},{-106,124}}, color={0,0,127}));
  connect(power.y, hea.u) annotation (Line(points={{-31,50},{-31,27},{-29.2,
          27},{-29.2,14}},
                       color={0,0,127}));
  connect(power.y, Qflow_heat) annotation (Line(points={{-31,50},{116,50},{
          116,60},{290,60}},
                         color={0,0,127}));
  connect(python_ROM.heatDemand, power.u) annotation (Line(points={{-77.9,
          111.9},{-77.9,120},{-66,120},{-66,50},{-54,50},{-54,50}}, color={0,
          0,127}));
  annotation (
    Diagram(coordinateSystem(extent={{-280,-100},{280,420}})),
    Icon(coordinateSystem(extent={{-280,-100},{280,420}}), graphics={Rectangle(
          extent={{-280,420},{280,-100}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Rectangle(
          extent={{-138,266},{158,60}},
          lineColor={28,108,200},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid)}));
end HX_RFHeat;
