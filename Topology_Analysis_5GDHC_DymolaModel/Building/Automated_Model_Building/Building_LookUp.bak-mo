within Topology_Analysis_5GDHC_DymolaModel.Building.Automated_Model_Building;
model Building_LookUp

  replaceable package Medium =
      Modelica.Media.Interfaces.PartialMedium "Medium model for water";

parameter Modelica.SIunits.HeatFlowRate Q_nominal_heat = 12240;
parameter Modelica.SIunits.HeatFlowRate Q_nominal_cool = 19489;
parameter Modelica.SIunits.TemperatureDifference dT_nominal= 6;
parameter Modelica.SIunits.MassFlowRate m_flow_nominal = 5*Q_nominal_cool/(cp_nominal*dT_nominal);
parameter Modelica.SIunits.HeatCapacity cp_nominal = 4187;
parameter String heatingLoad = "/home/justus/Documents/Topology_Analysis_5GDHC/Resources/Loads/LookUp_Table/heating_ambient.mos";
parameter String coolingLoad = "/home/justus/Documents/Topology_Analysis_5GDHC/Resources/Loads/LookUp_Table/cooling_ambient.mos";

protected
  Buildings.Fluid.Delays.DelayFirstOrder del_A(
    nPorts=3,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,origin={-200,0})));
  Buildings.Fluid.Delays.DelayFirstOrder del_B(
    nPorts=3,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=90,origin={200,0})));

public
  Modelica.Fluid.Interfaces.FluidPort_a port_a(
    redeclare final package Medium = Medium,
    h_outflow(start=Medium.h_default)) "Fluid connector a"
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},rotation=180,
                                                                                origin={-40,-300})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(
    redeclare final package Medium = Medium,
    h_outflow(start=Medium.h_default)) "Fluid connector b"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=0, origin={40,-300})));

public
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_heat(
    redeclare package Medium = Medium,
    addPowerToMedium=false,
    inputType=Buildings.Fluid.Types.InputType.Continuous,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    use_inputFilter=true,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-140,140})));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_cool(
    redeclare package Medium = Medium,
    addPowerToMedium=false,
    inputType=Buildings.Fluid.Types.InputType.Continuous,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    use_inputFilter=true,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},rotation=0,origin={-140,-140})));

protected
  Modelica.Blocks.Math.Gain control_cool(k=1/(cp_nominal*dT_nominal)) "Proportional Control for circulation pump of heat exchanger"
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={0,-200})));
  Modelica.Blocks.Math.Gain control_heat(k=1/(cp_nominal*dT_nominal)) "Proportional Control for circulation pump of heat exchanger"
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={0,80})));

public
  Modelica.Blocks.Interfaces.RealOutput eleHP "Electrical power consumed by heat pumps"
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={80,310})));
  Modelica.Blocks.Interfaces.RealOutput elePumps "Electrical power consumed by circulation pumps"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={20,310})));
  Modelica.Blocks.Interfaces.RealOutput Qflow_heat "Space heating thermal load"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={140,310})));
  Modelica.Blocks.Interfaces.RealOutput Qflow_cool "Space Cooling thermal load"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={200,310})));

protected
  Modelica.Blocks.Math.Gain propotional_Q_heat(k=1/(Q_nominal_heat))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-60,180})));
  Modelica.Blocks.Math.Gain proportional_Q_cool(k=1/(Q_nominal_cool))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-60,-100})));
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
  Modelica.Blocks.Sources.CombiTimeTable LookUp_heatingLoad(
    tableOnFile=true,
    tableName="tab1",
    fileName=heatingLoad)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-100,180})));
  Buildings.Fluid.HeatExchangers.HeaterCooler_u cool(
    m_flow_nominal=1,
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    dp_nominal=30000,
    Q_flow_nominal=Q_nominal_cool)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},rotation=0,origin={0,-140})));
  Modelica.Blocks.Sources.CombiTimeTable LookUp_coolingLoad(
    tableOnFile=true,
    tableName="tab1",
    fileName= coolingLoad)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-100,-100})));

  Modelica.Blocks.Sources.RealExpression ExpEleHP(y=1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={80,250})));
  Modelica.Blocks.Sources.RealExpression ExpQflow_heat(y=heat.Q_flow)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={140,250})));
  Modelica.Blocks.Sources.RealExpression EXPQflow_cool(y=cool.Q_flow)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={200,250})));
  Modelica.Blocks.Sources.RealExpression ExpElePumpsCool(y=pump_cool.P)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,250})));
  Modelica.Blocks.Sources.RealExpression ExpElePumpsHeat(y=pump_heat.P)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,250})));
public
  Modelica.Blocks.Math.Add Sum_ExpElePumps annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={20,280})));
equation

  connect(del_A.ports[1], pump_heat.port_a)
    annotation (Line(points={{-210,2.66667},{-210,2},{-240,2},{-240,140},{-150,140}}, color={0,127,255}));
  connect(control_cool.y,pump_cool. m_flow_in)
    annotation (Line(points={{-11,-200},{-76,-200},{-76,-200},{-142,-200},{-142,-152},{-140,-152}}, color={0,0,127}));

  connect(pump_cool.port_a, del_A.ports[2]) annotation (Line(points={{-150,-140},{-240,-140},{-240,1.77636e-15},{-210,1.77636e-15}},
        color={0,127,255}));
  connect(LookUp_heatingLoad.y[1], propotional_Q_heat.u)
    annotation (Line(points={{-89,180},{-70,180},{-70,180},{-72,180}}, color={0,0,127}));
  connect(propotional_Q_heat.y, heat.u) annotation (Line(points={{-49,180},{-38,180},{-38,152},{-24,152}}, color={0,0,127}));
  connect(pump_heat.port_b, heat.port_a)
    annotation (Line(points={{-130,140},{-88,140},{-88,140},{-20,140}}, color={0,127,255}));
  connect(heat.port_b, del_B.ports[1])
    annotation (Line(points={{20,140},{238,140},{238,-2.66667},{210,-2.66667}}, color={0,127,255}));
  connect(pump_cool.port_b, cool.port_a) annotation (Line(points={{-130,-140},{-108,-140},{-108,-140},{-20,-140}},
                                        color={0,127,255}));
  connect(cool.port_b, del_B.ports[2]) annotation (Line(points={{20,-140},{238,-140},{238,-2},{210,-2},{210,-4.44089e-16}},
                               color={0,127,255}));
  connect(control_cool.u, cool.Q_flow) annotation (Line(points={{12,-200},{38,-200},{38,-128},{22,-128}}, color={0,0,127}));
  connect(LookUp_coolingLoad.y[1], proportional_Q_cool.u)
    annotation (Line(points={{-89,-100},{-76,-100},{-76,-100},{-72,-100}}, color={0,0,127}));
  connect(proportional_Q_cool.y, cool.u)
    annotation (Line(points={{-49,-100},{-40,-100},{-40,-128},{-24,-128}}, color={0,0,127}));
  connect(Qflow_heat, Qflow_heat)
    annotation (Line(points={{140,310},{140,310}}, color={0,0,127}));
  connect(port_b, del_B.ports[3]) annotation (Line(points={{40,-300},{40,-300},{40,-280},{260,-280},{260,0},{210,0},{210,2},{210,2},{210,
          2},{210,2.66667}},                 color={0,127,255}));
  connect(del_A.ports[3], port_a) annotation (Line(points={{-210,-2.66667},{-212,-2.66667},{-212,-2},{-258,-2},{-258,-280},{-40,-280},{
          -40,-300}},
        color={0,127,255}));
  connect(ExpEleHP.y, eleHP) annotation (Line(points={{80,261},{80,310}}, color={0,0,127}));
  connect(ExpQflow_heat.y, Qflow_heat) annotation (Line(points={{140,261},{140,
          310}},                                                                      color={0,0,127}));
  connect(EXPQflow_cool.y, Qflow_cool) annotation (Line(points={{200,261},{200,
          310}},                                                                                color={0,0,127}));
  connect(eleHP, eleHP)
    annotation (Line(points={{80,310},{80,310}}, color={0,0,127}));
  connect(control_heat.u, heat.Q_flow) annotation (Line(points={{12,80},{40,80},{40,152},{22,152}}, color={0,0,127}));
  connect(control_heat.y, pump_heat.m_flow_in) annotation (Line(points={{-11,80},{-140,80},{-140,128}}, color={0,0,127}));
  connect(ExpElePumpsHeat.y, Sum_ExpElePumps.u1) annotation (Line(points={{
          8.88178e-16,261},{8,261},{14,261},{14,262},{14,268},{14,268}}, color=
          {0,0,127}));
  connect(ExpElePumpsCool.y, Sum_ExpElePumps.u2)
    annotation (Line(points={{40,261},{26,261},{26,268}}, color={0,0,127}));
  connect(Sum_ExpElePumps.y, elePumps)
    annotation (Line(points={{20,291},{20,310}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(extent={{-280,-300},{280,300}})),
    Icon(coordinateSystem(extent={{-280,-300},{280,300}}), graphics={Rectangle(
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
end Building_LookUp;
