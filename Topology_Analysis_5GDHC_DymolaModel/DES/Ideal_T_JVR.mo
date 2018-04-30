within Topology_Analysis_5GDHC.DES;
model Ideal_T_JVR
  "Ideal heating and cooling plant with leaving temperature as set point"
  extends Topology_Analysis_5GDHC.DES.PartialTwoPortInterface_JVR(
    final m_flow(start=0),
    final allowFlowReversal = true,
    final dp(start=0));

  parameter Boolean connected = true;

  parameter Modelica.SIunits.Pressure dp_nominal(displayUnit="Pa")=30000
    "Pressure difference at nominal flow rate"
    annotation(Dialog(group="Design parameter"));

  parameter Boolean linearizeFlowResistance=false
    "= true, use linear relation between m_flow and dp for any flow rate"
    annotation(Dialog(tab="Advanced"));

  Modelica.Blocks.Interfaces.RealOutput Q_H_flow(unit="W")
    "Heat input into fluid"
    annotation (Placement(transformation(extent={{280,90},{300,110}})));

  Modelica.Blocks.Interfaces.RealOutput Q_C_flow(unit="W")
    "Heat extracted from fluid"
    annotation (Placement(transformation(extent={{280,30},{300,50}})));
protected
  final parameter Medium.ThermodynamicState sta_default = Medium.setState_pTX(
    T=Medium.T_default,
    p=Medium.p_default,
    X=Medium.X_default[1:Medium.nXi]) "Medium state at default properties";
  final parameter Modelica.SIunits.SpecificHeatCapacity cp_default=
    Medium.specificHeatCapacityCp(sta_default)
    "Specific heat capacity of the fluid";

  Buildings.Fluid.HeatExchangers.PrescribedOutlet coo(
    redeclare package Medium = Medium,
    allowFlowReversal=allowFlowReversal,
    m_flow_nominal=m_flow_nominal,
    show_T=true,
    QMax_flow=0,
    dp_nominal=0,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    tau=60,
    use_X_wSet=false)
            "Cooling supply"
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));

  Buildings.Fluid.HeatExchangers.PrescribedOutlet hea(
    redeclare package Medium = Medium,
    allowFlowReversal=allowFlowReversal,
    m_flow_nominal=m_flow_nominal,
    from_dp=false,
    show_T=true,
    QMin_flow=0,
    dp_nominal=dp_nominal,
    linearizeFlowResistance=linearizeFlowResistance,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    tau=60,
    use_X_wSet=false)
            "Heat supply"
    annotation (Placement(transformation(extent={{-20,-10},{-40,10}})));

public
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    tau=0) "Temperature sensor"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
public
  Modelica.Blocks.Sources.Constant TSetHeat(k=273.15 + 20)
    annotation (Placement(transformation(extent={{198,164},{158,204}})));
  Modelica.Blocks.Sources.Constant TSetCool(k=273.15 + 20)
    annotation (Placement(transformation(extent={{-220,142},{-182,180}})));
public
  Buildings.Fluid.Sources.FixedBoundary ref(
    redeclare package Medium = Medium,
    use_T=false,
    nPorts=1) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          origin={-190,-182})));
equation
  connect(Q_H_flow, hea.Q_flow) annotation (Line(points={{290,100},{-68,100},{-68,
          8},{-41,8}}, color={0,0,127}));
  connect(coo.Q_flow, Q_C_flow) annotation (Line(points={{41,8},{102,8},{102,40},
          {290,40}}, color={0,0,127}));
  connect(TSetHeat.y, hea.TSet) annotation (Line(points={{156,184},{-12,184},{
          -12,8},{-18,8}},   color={0,0,127}));
  connect(TSetCool.y, coo.TSet) annotation (Line(points={{-180.1,161},{12,161},
          {12,8},{18,8}}, color={0,0,127}));
  connect(ref.ports[1], port_a) annotation (Line(points={{-180,-182},{-80,-182},
          {-80,-300}}, color={0,127,255}));
  connect(hea.port_b, port_a)
    annotation (Line(points={{-40,0},{-80,0},{-80,-300}}, color={0,127,255}));
  connect(hea.port_a, senTem.port_a)
    annotation (Line(points={{-20,0},{-10,0}}, color={0,127,255}));
  connect(senTem.port_b, coo.port_a)
    annotation (Line(points={{10,0},{20,0}}, color={0,127,255}));
  connect(coo.port_b, port_b)
    annotation (Line(points={{40,0},{80,0},{80,-300}}, color={0,127,255}));
  annotation (
    Diagram(coordinateSystem(extent={{-280,-300},{280,300}})),
    Icon(coordinateSystem(extent={{-280,-300},{280,300}}),graphics={
        Rectangle(
        extent={{-280,-302},{280,300}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-72,70},{70,-70}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-103,6},{98,-4}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-2,-4},{98,6}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
Model of an ideal heating and cooling plant that takes as a parameter the set point
for the leaving fluid temperature.
</p>
</html>", revisions="<html>
<ul>
<li>
January 4, 2016, by Michael Wetter:<br/>
Set energy balance of heater and cooler to be dynamic and added
a temperature sensor.
This is due to a potential bug in Dymola 2016, Dassault SR00312338.
</li>
<li>
December 23, 2015, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end Ideal_T_JVR;
