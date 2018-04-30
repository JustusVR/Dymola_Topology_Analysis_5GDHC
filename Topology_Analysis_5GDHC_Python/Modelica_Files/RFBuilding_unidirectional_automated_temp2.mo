within LinReg_District_Heating_Cooling;
model RFBuilding_unidirectional_automated


parameter Modelica.SIunits.HeatFlowRate Q_nominal_heat = 12240;
parameter Modelica.SIunits.HeatFlowRate Q_nominal_cool = 19489;
parameter Modelica.SIunits.TemperatureDifference dT_nominal= 6;
parameter Modelica.SIunits.MassFlowRate m_flow_nominal = 5*Q_nominal_cool/(cp_nominal*dT_nominal);
parameter Modelica.SIunits.HeatCapacity cp_nominal = 4187;

protected
  Buildings.Fluid.Delays.DelayFirstOrder del_A(
    nPorts=3,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-212,20},{-192,40}})));
public
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_hea(
    redeclare package Medium = Medium,
    addPowerToMedium=false,
    inputType=Buildings.Fluid.Types.InputType.Continuous,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    use_inputFilter=true,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-150,140},{-130,160}})));
public
  Modelica.Blocks.Interfaces.RealOutput eleHP
    "Electrical power consumed for space heating" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={120,310})));
  Modelica.Blocks.Interfaces.RealOutput Qflow_heat "Space heating thermal load"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={180,310})));
protected
  Buildings.Fluid.Delays.DelayFirstOrder del_B(
    nPorts=3,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{230,18},{250,38}})));
public
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_Cool(
    redeclare package Medium = Medium,
    addPowerToMedium=false,
    inputType=Buildings.Fluid.Types.InputType.Continuous,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    use_inputFilter=true,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-150,-200},{-130,-180}})));
  Modelica.Blocks.Interfaces.RealOutput Qflow_cool "Space heating thermal load"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={220,310})));
protected
  Modelica.Blocks.Math.Gain gain(k=-1/(cp_nominal*dT_nominal))
    annotation (Placement(transformation(extent={{8,186},{-12,206}})));
  Modelica.Blocks.Math.Gain gain1(k=1/(cp_nominal*dT_nominal))
    annotation (Placement(transformation(extent={{4,-150},{-16,-130}})));
public
  Modelica.Blocks.Interfaces.RealOutput elePumps
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,310})));
  Modelica.Blocks.Math.Add  add
    annotation (Placement(transformation(extent={{-70,232},{-50,252}})));
  Buildings.Fluid.HeatExchangers.HeaterCooler_u hea(
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=30000,
    Q_flow_nominal=Q_nominal_heat)
    annotation (Placement(transformation(extent={{-26,126},{22,172}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_heat(
    tableOnFile=true,
    tableName="tab1",
    fileName=
        "/home/justus/Desktop/LinReg_District_Heating_Cooling/loads/heating_ambient.mos")
    annotation (Placement(transformation(extent={{-92,108},{-72,128}})));
  Modelica.Blocks.Math.Gain gain2(k=1/(Q_nominal_heat))
    annotation (Placement(transformation(extent={{-54,112},{-42,124}})));
  Buildings.Fluid.HeatExchangers.HeaterCooler_u cool(
    m_flow_nominal=1,
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    dp_nominal=30000,
    Q_flow_nominal=Q_nominal_cool)
    annotation (Placement(transformation(extent={{-24,-214},{24,-168}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_Cool(
    tableOnFile=true,
    tableName="tab1",
    fileName=
        "/home/justus/Desktop/LinReg_District_Heating_Cooling/loads/cooling_ambient.mos")
    annotation (Placement(transformation(extent={{-82,-230},{-62,-210}})));
  Modelica.Blocks.Math.Gain gain5(k=1/(Q_nominal_cool))
    annotation (Placement(transformation(extent={{-50,-226},{-38,-214}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{92,230},{112,250}})));
public
  Modelica.Blocks.Continuous.Integrator EPumps(y(unit="J"))
    "Electrical energy for space heating and hot water"
    annotation (Placement(transformation(extent={{-22,268},{-2,288}})));
equation

  connect(del_A.ports[1], pump_hea.port_a) annotation (Line(points={{-204.667,
          20},{-204.667,0},{-180,0},{-180,150},{-150,150}}, color={0,127,255}));
  connect(eleHP, eleHP)
    annotation (Line(points={{120,310},{120,310}}, color={0,0,127}));
  connect(gain.y, pump_hea.m_flow_in) annotation (Line(points={{-13,196},{
          -140,196},{-140,162}}, color={0,0,127}));
  connect(gain1.y, pump_Cool.m_flow_in) annotation (Line(points={{-17,-140},{
          -140,-140},{-140,-178}}, color={0,0,127}));
  connect(pump_hea.P, add.u1) annotation (Line(points={{-129,159},{-100.5,159},
          {-100.5,248},{-72,248}}, color={0,0,127}));
  connect(pump_Cool.P, add.u2) annotation (Line(points={{-129,-181},{-129,-180},
          {-100,-180},{-100,236},{-72,236}},       color={0,0,127}));
  connect(add.y, elePumps)
    annotation (Line(points={{-49,242},{60,242},{60,310}},
                                                   color={0,0,127}));

  connect(pump_Cool.port_a, del_A.ports[2]) annotation (Line(points={{-150,-190},
          {-198,-190},{-198,-8},{-198,-8},{-198,8},{-202,8},{-202,20}}, color={
          0,127,255}));
  connect(combiTimeTable_heat.y[1], gain2.u)
    annotation (Line(points={{-71,118},{-55.2,118}}, color={0,0,127}));
  connect(gain2.y, hea.u) annotation (Line(points={{-41.4,118},{-38,118},{-38,
          162.8},{-30.8,162.8}}, color={0,0,127}));
  connect(pump_hea.port_b, hea.port_a) annotation (Line(points={{-130,150},{
          -88,150},{-88,149},{-26,149}}, color={0,127,255}));
  connect(hea.port_b, del_B.ports[1]) annotation (Line(points={{22,149},{200,
          149},{200,0},{237.333,0},{237.333,18}}, color={0,127,255}));
  connect(hea.Q_flow, gain.u) annotation (Line(points={{24.4,162.8},{60,162.8},
          {60,196},{10,196}}, color={0,0,127}));
  connect(pump_Cool.port_b, cool.port_a) annotation (Line(points={{-130,-190},{-78,
          -190},{-78,-191},{-24,-191}}, color={0,127,255}));
  connect(cool.port_b, del_B.ports[2]) annotation (Line(points={{24,-191},{240,
          -191},{240,18}}, color={0,127,255}));
  connect(gain1.u, cool.Q_flow) annotation (Line(points={{6,-140},{38,-140},{38,
          -177.2},{26.4,-177.2}}, color={0,0,127}));
  connect(combiTimeTable_Cool.y[1], gain5.u)
    annotation (Line(points={{-61,-220},{-51.2,-220}}, color={0,0,127}));
  connect(gain5.y, cool.u) annotation (Line(points={{-37.4,-220},{-34,-220},{-34,
          -177.2},{-28.8,-177.2}}, color={0,0,127}));
  connect(cool.Q_flow, Qflow_cool) annotation (Line(points={{26.4,-177.2},{
          220.2,-177.2},{220.2,310},{220,310}},
                                            color={0,0,127}));
  connect(hea.Q_flow, Qflow_heat) annotation (Line(points={{24.4,162.8},{179.2,
          162.8},{179.2,310},{180,310}},       color={0,0,127}));
  connect(const.y, eleHP)
    annotation (Line(points={{113,240},{120,240},{120,310}}, color={0,0,127}));
  connect(add.y, EPumps.u) annotation (Line(points={{-49,242},{-40,242},{-40,
          278},{-24,278}}, color={0,0,127}));
  connect(Qflow_heat, Qflow_heat)
    annotation (Line(points={{180,310},{180,310}}, color={0,0,127}));

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
end RFBuilding_unidirectional_automated;
