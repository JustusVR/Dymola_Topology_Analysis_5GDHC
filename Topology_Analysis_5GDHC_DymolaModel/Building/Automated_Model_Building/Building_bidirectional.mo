within Topology_Analysis_5GDHC.Building.Automated_Model_Building;
model Building_bidirectional

  replaceable package Medium =
      Modelica.Media.Interfaces.PartialMedium "Medium model for water";

parameter Modelica.SIunits.HeatFlowRate Q_nominal_heat = 12240;
parameter Modelica.SIunits.HeatFlowRate Q_nominal_cool = 19489;
parameter Modelica.SIunits.TemperatureDifference dT_nominal= 6;
parameter Modelica.SIunits.MassFlowRate m_flow_nominal = Q_nominal_cool/(cp_nominal*dT_nominal);
parameter Modelica.SIunits.HeatCapacity cp_nominal = 4187;
parameter String heatingLoad_FileName = "/home/justus/Documents/Topology_Analysis_5GDHC/Resources/Loads/LookUp_Table/heating_ambient.mos";
parameter String coolingLoad_FileName = "/home/justus/Documents/Topology_Analysis_5GDHC/Resources/Loads/LookUp_Table/cooling_ambient.mos";
parameter Boolean connected = true;

protected
  Buildings.Fluid.Delays.DelayFirstOrder del_A(
    nPorts=3,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,origin={-220,0})));
  Buildings.Fluid.Delays.DelayFirstOrder del_B(
    nPorts=3,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=90,origin={220,0})));

public
  Modelica.Fluid.Interfaces.FluidPort_a port_a(
    redeclare final package Medium = Medium,
    h_outflow(start=Medium.h_default)) "Fluid connector a"
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},rotation=0,origin={-80,-300})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(
    redeclare final package Medium = Medium,
    h_outflow(start=Medium.h_default)) "Fluid connector b"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=0, origin={80,-300})));

public
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_heat(
    redeclare package Medium = Medium,
    addPowerToMedium=false,
    inputType=Buildings.Fluid.Types.InputType.Continuous,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    use_inputFilter=true,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},rotation=0,origin={-80,140})));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_cool(
    redeclare package Medium = Medium,
    addPowerToMedium=false,
    inputType=Buildings.Fluid.Types.InputType.Continuous,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    use_inputFilter=true,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},rotation=0,origin={80,-140})));

protected
  Modelica.Blocks.Math.Gain control_cool(k=1/(cp_nominal*dT_nominal)) "Proportional Control for circulation pump of heat exchanger"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={0,-198})));
  Modelica.Blocks.Math.Gain control_heat(k=-1/(cp_nominal*dT_nominal))
                                                                      "Proportional Control for circulation pump of heat exchanger"
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={0,200})));

public
  Modelica.Blocks.Interfaces.RealOutput elePumps "Electrical power consumed by circulation pumps"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-200,310})));
  Modelica.Blocks.Interfaces.RealOutput eleHP_heat
    "Electrical power consumed by heat pumps" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-140,310})));
  Modelica.Blocks.Interfaces.RealOutput Q_DH "Space heating thermal load"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={180,310})));
  Modelica.Blocks.Interfaces.RealOutput Q_DC "Space Cooling thermal load"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={220,310})));

protected
  Modelica.Blocks.Math.Gain propotional_Q_heat(k=1/(Q_nominal_heat))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},rotation=0,origin={-60,80})));
  Modelica.Blocks.Math.Gain proportional_Q_cool(k=1/(Q_nominal_cool))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},rotation=0,origin={-60,-80})));
public
  Buildings.Fluid.HeatExchangers.HeaterCooler_u heat(
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=30000,
    Q_flow_nominal=Q_nominal_heat)
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={0,140})));
protected
  Buildings.Fluid.HeatExchangers.HeaterCooler_u cool(
    m_flow_nominal=1,
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    dp_nominal=30000,
    Q_flow_nominal=Q_nominal_cool)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},rotation=0,origin={0,-140})));

  Modelica.Blocks.Sources.RealExpression ExpEleHP_heat(y=1) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-140,250})));
  Modelica.Blocks.Sources.RealExpression ExpQ_DH(y=heatingLoad.I_Load)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={180,250})));
  Modelica.Blocks.Sources.RealExpression ExpQ_DC(y=coolingLoad.I_Load)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={220,250})));
  Modelica.Blocks.Sources.RealExpression ExpElePumpsCool(y=pump_cool.P)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-180,250})));
  Modelica.Blocks.Sources.RealExpression ExpElePumpsHeat(y=pump_heat.P)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-220,250})));
protected
  Modelica.Blocks.Math.Add Sum_ExpElePumps annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-200,280})));
public
  Modelica.Fluid.Valves.ValveDiscrete valve_a(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    dp_nominal=100000,
    opening_min=1e-6)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=0,  origin={-140,-280})));
  Modelica.Fluid.Valves.ValveDiscrete valve_b(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    dp_nominal=100000,
    opening_min=1e-6)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=0,  origin={140,-280})));
  Modelica.Blocks.Sources.BooleanConstant buildingConnected( k=connected)
    annotation (Placement(transformation(extent={{-12,-12},{12,12}},rotation=0,origin={-170,0})));
  Loads.Load_Calc_old coolingLoad(Load_FileName=coolingLoad_FileName)
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,-80})));
  Loads.Load_Calc_old heatingLoad(Load_FileName=heatingLoad_FileName)
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,80})));

protected
  Modelica.Blocks.Sources.RealExpression ExpEleHP_cool(y=1) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-100,250})));
public
  Modelica.Blocks.Interfaces.RealOutput eleHP_cool
    "Electrical power consumed by heat pumps" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-100,310})));
protected
  Modelica.Blocks.Sources.RealExpression ExpQ_IH(y=1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={80,250})));
public
  Modelica.Blocks.Interfaces.RealOutput Q_IH
    "Electrical power consumed by heat pumps" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={80,310})));
protected
  Modelica.Blocks.Sources.RealExpression ExpQ_IC(y=1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={120,250})));
public
  Modelica.Blocks.Interfaces.RealOutput Q_IC
    "Electrical power consumed by heat pumps" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={120,310})));
equation

  connect(del_A.ports[1], pump_heat.port_a)
    annotation (Line(points={{-230,2.66667},{-230,4},{-240,4},{-240,140},{-90,140}},  color={0,127,255}));
  connect(control_cool.y,pump_cool. m_flow_in)
    annotation (Line(points={{11,-198},{80,-198},{80,-152}},                                        color={0,0,127}));

  connect(pump_heat.port_b, heat.port_a)
    annotation (Line(points={{-70,140},{-20,140}},                      color={0,127,255}));
  connect(heat.port_b, del_B.ports[1])
    annotation (Line(points={{20,140},{238,140},{238,-2.66667},{230,-2.66667}}, color={0,127,255}));
  connect(control_cool.u, cool.Q_flow) annotation (Line(points={{-12,-198},{-38,-198},{-38,-172},{40,-172},{40,-128},{22,-128}},
                                                                                                          color={0,0,127}));
  connect(Q_DH, Q_DH)
    annotation (Line(points={{180,310},{180,310}}, color={0,0,127}));
  connect(ExpEleHP_heat.y, eleHP_heat)
    annotation (Line(points={{-140,261},{-140,310}}, color={0,0,127}));
  connect(ExpQ_DH.y, Q_DH)
    annotation (Line(points={{180,261},{180,310}}, color={0,0,127}));
  connect(ExpQ_DC.y, Q_DC)
    annotation (Line(points={{220,261},{220,310}}, color={0,0,127}));
  connect(eleHP_heat, eleHP_heat)
    annotation (Line(points={{-140,310},{-140,310}}, color={0,0,127}));
  connect(control_heat.u, heat.Q_flow) annotation (Line(points={{12,200},{40,200},{40,152},{22,152}},
                                                                                                    color={0,0,127}));
  connect(control_heat.y, pump_heat.m_flow_in) annotation (Line(points={{-11,200},{-80,200},{-80,152}}, color={0,0,127}));
  connect(ExpElePumpsHeat.y, Sum_ExpElePumps.u1) annotation (Line(points={{-220,
          261},{-206,261},{-206,268}},                                   color=
          {0,0,127}));
  connect(ExpElePumpsCool.y, Sum_ExpElePumps.u2)
    annotation (Line(points={{-180,261},{-194,261},{-194,268}},
                                                          color={0,0,127}));
  connect(Sum_ExpElePumps.y, elePumps)
    annotation (Line(points={{-200,291},{-200,310}},
                                                 color={0,0,127}));
  connect(port_a, valve_a.port_b)
    annotation (Line(points={{-80,-300},{-80,-280},{-130,-280}},
                                                      color={0,127,255}));
  connect(valve_a.port_a, del_A.ports[2]) annotation (Line(points={{-150,-280},{-258,-280},{-258,0},{-228,0},{-228,1.77636e-15},
          {-230,1.77636e-15}},                         color={0,127,255}));
  connect(buildingConnected.y, valve_a.open) annotation (Line(points={{-156.8,0},{-140,0},{-140,-272}},   color={255,0,255}));
  connect(cool.u, proportional_Q_cool.y) annotation (Line(points={{-24,-128},{-40,-128},{-40,-80},{-49,-80}},
                                          color={0,0,127}));
  connect(proportional_Q_cool.u, coolingLoad.D_Load) annotation (Line(points={{
          -72,-80},{-76,-80},{-76,-88},{-78,-88}}, color={0,0,127}));
  connect(buildingConnected.y, coolingLoad.u)
    annotation (Line(points={{-156.8,0},{-140,0},{-140,-80},{-124,-80}},       color={255,0,255}));
  connect(buildingConnected.y, heatingLoad.u)
    annotation (Line(points={{-156.8,0},{-140,0},{-140,80},{-124,80}},   color={255,0,255}));
  connect(heatingLoad.D_Load, propotional_Q_heat.u) annotation (Line(points={{-78,
          72},{-76,72},{-76,80},{-72,80}}, color={0,0,127}));
  connect(propotional_Q_heat.y, heat.u) annotation (Line(points={{-49,80},{-42,80},{-42,152},{-24,152}},
                                color={0,0,127}));
  connect(port_b, valve_b.port_a)
    annotation (Line(points={{80,-300},{80,-280},{130,-280}},
                                                    color={0,127,255}));
  connect(valve_b.port_b, del_B.ports[2]) annotation (Line(points={{150,-280},{260,-280},{260,-4.44089e-16},{230,-4.44089e-16}},
                                              color={0,127,255}));
  connect(buildingConnected.y, valve_b.open)
    annotation (Line(points={{-156.8,0},{-140,0},{-140,-242},{140,-242},{140,-272}},   color={255,0,255}));
  connect(cool.port_b, pump_cool.port_b) annotation (Line(points={{20,-140},{70,-140}}, color={0,127,255}));
  connect(pump_cool.port_a, del_B.ports[3])
    annotation (Line(points={{90,-140},{238,-140},{238,2.66667},{230,2.66667}}, color={0,127,255}));
  connect(cool.port_a, del_A.ports[3])
    annotation (Line(points={{-20,-140},{-240,-140},{-240,-2.66667},{-230,-2.66667}}, color={0,127,255}));
  connect(ExpEleHP_cool.y, eleHP_cool)
    annotation (Line(points={{-100,261},{-100,310}}, color={0,0,127}));
  connect(eleHP_cool, eleHP_cool)
    annotation (Line(points={{-100,310},{-100,310}}, color={0,0,127}));
  connect(ExpQ_IH.y, Q_IH)
    annotation (Line(points={{80,261},{80,310}}, color={0,0,127}));
  connect(Q_IH, Q_IH)
    annotation (Line(points={{80,310},{80,310}}, color={0,0,127}));
  connect(ExpQ_IC.y, Q_IC)
    annotation (Line(points={{120,261},{120,310}}, color={0,0,127}));
  connect(Q_IC, Q_IC)
    annotation (Line(points={{120,310},{120,310}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(extent={{-280,-300},{280,300}})),
    Icon(coordinateSystem(extent={{-280,-300},{280,300}}),graphics={
      Rectangle(
          extent={{-280,300},{280,-300}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Rectangle(
          extent={{-266,128},{262,-272}},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{58,46},{176,-52}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
      Polygon(
        points={{0,274},{-266,128},{262,128},{0,274}},
        lineColor={95,95,95},
        smooth=Smooth.None,
        fillPattern=FillPattern.Solid,
        fillColor={95,95,95}),
        Rectangle(
          extent={{-188,-106},{-74,-272}},
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
          extent={{-98,-198},{-84,-212}},
          pattern=LinePattern.None,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid)}));
end Building_bidirectional;
