within Topology_Analysis_5GDHC_DymolaModel.Building.Random_Forest;
model RFBuilding_unidirectional_noDynPr

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
  replaceable package Medium =
      Modelica.Media.Interfaces.PartialMedium "Medium model for water";

  parameter Modelica.SIunits.HeatFlowRate Q_nominal_heat = 12240;
  parameter Modelica.SIunits.HeatFlowRate Q_nominal_cool = 19489;
  parameter Modelica.SIunits.TemperatureDifference dT_nominal= 6;
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal = 5*Q_nominal_cool/(cp_nominal*dT_nominal);
  parameter Modelica.SIunits.HeatCapacity cp_nominal = 4187;

protected
  Buildings.Fluid.Delays.DelayFirstOrder del(
    nPorts=3,
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-250,22},{-230,42}})));
public
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_hea(
    redeclare package Medium = Medium,
    addPowerToMedium=false,
    inputType=Buildings.Fluid.Types.InputType.Continuous,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    use_inputFilter=false,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-150,140},{-130,160}})));
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
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{230,18},{250,38}})));
public
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_Cool(
    redeclare package Medium = Medium,
    addPowerToMedium=false,
    inputType=Buildings.Fluid.Types.InputType.Continuous,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    use_inputFilter=false,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-150,-200},{-130,-180}})));
public
  Modelica.Blocks.Interfaces.RealOutput eleHP_cool
    "Electrical power consumed for space heating"
    annotation (Placement(transformation(extent={{282,-248},{302,-228}})));
  Modelica.Blocks.Interfaces.RealOutput Qflow_cool "Space heating thermal load"
    annotation (Placement(transformation(extent={{280,-272},{300,-252}})));
protected
  Modelica.Blocks.Math.Gain gain(k=-1/(cp_nominal*dT_nominal))
    annotation (Placement(transformation(extent={{8,186},{-12,206}})));
  Modelica.Blocks.Math.Gain gain1(k=1/(cp_nominal*dT_nominal))
    annotation (Placement(transformation(extent={{4,-150},{-16,-130}})));
public
  Modelica.Blocks.Interfaces.RealOutput elePumps
    annotation (Placement(transformation(extent={{280,230},{300,250}})));
  Modelica.Blocks.Math.Add  add
    annotation (Placement(transformation(extent={{104,230},{124,250}})));
  Buildings.Fluid.HeatExchangers.HeaterCooler_u hea(
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    Q_flow_nominal=Q_nominal_heat,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=30000)
    annotation (Placement(transformation(extent={{-26,126},{22,172}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_heat(
    tableOnFile=true,
    tableName="tab1",
    fileName=
        "/home/justus/Documents/LinReg_District_Heating_Cooling/loads/heating_ambient.mos")
    annotation (Placement(transformation(extent={{-82,108},{-62,128}})));
  Modelica.Blocks.Math.Gain gain2(k=1/Q_nominal_heat)
    annotation (Placement(transformation(extent={{-54,112},{-42,124}})));
  Buildings.Fluid.HeatExchangers.HeaterCooler_u hea2(
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=30000,
    Q_flow_nominal=Q_nominal_cool)
    annotation (Placement(transformation(extent={{-24,-212},{24,-166}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_Cool(
    tableOnFile=true,
    tableName="tab1",
    fileName=
        "/home/justus/Documents/LinReg_District_Heating_Cooling/loads/cooling_ambient.mos")
    annotation (Placement(transformation(extent={{-82,-230},{-62,-210}})));
  Modelica.Blocks.Math.Gain gain5(k=1/Q_nominal_cool)
    annotation (Placement(transformation(extent={{-50,-226},{-38,-214}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{138,-64},{158,-44}})));
public
  Modelica.Blocks.Continuous.Integrator EPumps(y(unit="J"))
    "Electrical energy for space heating and hot water"
    annotation (Placement(transformation(extent={{160,270},{180,290}})));
equation

  connect(port_a, del.ports[1]) annotation (Line(points={{-280,0},{-242.667,0},
          {-242.667,22}}, color={0,127,255}));
  connect(del.ports[2], pump_hea.port_a) annotation (Line(points={{-240,22},{
          -240,0},{-220,0},{-220,150},{-150,150}}, color={0,127,255}));
  connect(port_a, port_a)
    annotation (Line(points={{-280,0},{-280,0}}, color={0,127,255}));
  connect(port_b, del1.ports[1])
    annotation (Line(points={{280,0},{237.333,0},{237.333,18}},
                                                        color={0,127,255}));
  connect(eleHP_heat, eleHP_heat)
    annotation (Line(points={{290,174},{290,174}}, color={0,0,127}));
  connect(gain.y, pump_hea.m_flow_in) annotation (Line(points={{-13,196},{
          -140,196},{-140,162}}, color={0,0,127}));
  connect(gain1.y, pump_Cool.m_flow_in) annotation (Line(points={{-17,-140},{
          -140,-140},{-140,-178}}, color={0,0,127}));
  connect(pump_hea.P, add.u1) annotation (Line(points={{-129,159},{-100.5,159},
          {-100.5,246},{102,246}}, color={0,0,127}));
  connect(pump_Cool.P, add.u2) annotation (Line(points={{-129,-181},{-129,
          -180},{-100,-180},{-100,234},{102,234}}, color={0,0,127}));
  connect(add.y, elePumps)
    annotation (Line(points={{125,240},{290,240}}, color={0,0,127}));

  connect(pump_Cool.port_a, del.ports[3]) annotation (Line(points={{-150,-190},
          {-237.333,-190},{-237.333,22}},
                                  color={0,127,255}));
  connect(combiTimeTable_heat.y[1], gain2.u)
    annotation (Line(points={{-61,118},{-55.2,118}}, color={0,0,127}));
  connect(gain2.y, hea.u) annotation (Line(points={{-41.4,118},{-38,118},{-38,
          162.8},{-30.8,162.8}}, color={0,0,127}));
  connect(pump_hea.port_b, hea.port_a) annotation (Line(points={{-130,150},{
          -88,150},{-88,149},{-26,149}}, color={0,127,255}));
  connect(hea.port_b, del1.ports[2]) annotation (Line(points={{22,149},{200,
          149},{200,0},{240,0},{240,18}}, color={0,127,255}));
  connect(hea.Q_flow, gain.u) annotation (Line(points={{24.4,162.8},{60,162.8},
          {60,196},{10,196}}, color={0,0,127}));
  connect(pump_Cool.port_b, hea2.port_a) annotation (Line(points={{-130,-190},
          {-78,-190},{-78,-189},{-24,-189}}, color={0,127,255}));
  connect(hea2.port_b, del1.ports[3]) annotation (Line(points={{24,-189},{
          242.667,-189},{242.667,18}},
                           color={0,127,255}));
  connect(gain1.u, hea2.Q_flow) annotation (Line(points={{6,-140},{38,-140},{
          38,-175.2},{26.4,-175.2}}, color={0,0,127}));
  connect(combiTimeTable_Cool.y[1], gain5.u)
    annotation (Line(points={{-61,-220},{-51.2,-220}}, color={0,0,127}));
  connect(gain5.y, hea2.u) annotation (Line(points={{-37.4,-220},{-34,-220},{
          -34,-175.2},{-28.8,-175.2}}, color={0,0,127}));
  connect(hea2.Q_flow, Qflow_cool) annotation (Line(points={{26.4,-175.2},{
          218.2,-175.2},{218.2,-262},{290,-262}}, color={0,0,127}));
  connect(hea.Q_flow, Qflow_heat) annotation (Line(points={{24.4,162.8},{
          241.2,162.8},{241.2,156},{290,156}}, color={0,0,127}));
  connect(const.y, eleHP_heat) annotation (Line(points={{159,-54},{224,-54},{
          224,174},{290,174}}, color={0,0,127}));
  connect(eleHP_cool, const.y) annotation (Line(points={{292,-238},{226,-238},
          {226,-54},{159,-54}}, color={0,0,127}));
  connect(add.y, EPumps.u) annotation (Line(points={{125,240},{126,240},{126,
          240},{124,240},{142,240},{142,280},{158,280}}, color={0,0,127}));
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
end RFBuilding_unidirectional_noDynPr;
