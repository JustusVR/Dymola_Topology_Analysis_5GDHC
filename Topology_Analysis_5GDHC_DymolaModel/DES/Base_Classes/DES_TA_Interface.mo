within Topology_Analysis_5GDHC_DymolaModel.DES.Base_Classes;
model DES_TA_Interface
  "Ideal heating and cooling plant with leaving temperature as set point"
  extends
    Topology_Analysis_5GDHC_DymolaModel.DES.Base_Classes.PartialTwoPortInterface_JVR(
    final m_flow(start=0),
    final allowFlowReversal=true,
    final dp(start=0));

  replaceable package Medium = Buildings.Media.Water "Medium model for water";
  //parameter Modelica.SIunits.MassFlowRate m_flow_nominal_district "nominal mass flow rate of the whole district";
  parameter Modelica.SIunits.TemperatureDifference dT_set = 6 "Setpoint temperature difference between hot & cold pipe";
  parameter Modelica.SIunits.Temp_C Tset_hotPipe = 20 "Setpoint temperature for the hot pipe";
  parameter Modelica.SIunits.Pressure dp_nominal(displayUnit="Pa")=30000 "Pressure difference at nominal flow rate" annotation(Dialog(group="Design parameter"));
  parameter Boolean linearizeFlowResistance=false "= true, use linear relation between m_flow and dp for any flow rate" annotation(Dialog(tab="Advanced"));
  parameter String weatherFile = Modelica.Utilities.Files.loadResource("modelica://Topology_Analysis_5GDHC_DymolaModel/Resources/Weather_File/USA_CO_Golden-NREL.724666_TMY3dy.mos");
  parameter Boolean connected = true;
  parameter Boolean dynamics = true;
  final parameter Modelica.Fluid.Types.Dynamics energyDyn = if dynamics then Modelica.Fluid.Types.Dynamics.DynamicFreeInitial else Modelica.Fluid.Types.Dynamics.SteadyState;
  final parameter Boolean useFilter = dynamics;

protected
  final parameter Medium.ThermodynamicState sta_default = Medium.setState_pTX(
    T=Medium.T_default,
    p=Medium.p_default,
    X=Medium.X_default[1:Medium.nXi]) "Medium state at default properties";
  final parameter Modelica.SIunits.SpecificHeatCapacity cp_default=
    Medium.specificHeatCapacityCp(sta_default)
    "Specific heat capacity of the fluid";

protected
  Buildings.Fluid.Sources.FixedBoundary ref(
    redeclare package Medium = Medium,
    use_T=false,
    nPorts=1) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          origin={-190,-182})));
public
  Modelica.Blocks.Interfaces.RealOutput Q_H_flow(unit="W")
    "Heat input into fluid"
    annotation (Placement(transformation(extent={{280,-130},{300,-110}})));
  Modelica.Blocks.Interfaces.RealOutput Q_C_flow(unit="W")
    "Heat extracted from fluid"
    annotation (Placement(transformation(extent={{280,-210},{300,-190}})));
  Modelica.Blocks.Interfaces.RealOutput P_ele_heat_input(unit="W")
    "Electrical power input of the DES for heating"
    annotation (Placement(transformation(extent={{280,230},{300,210}})));
  Modelica.Blocks.Interfaces.RealOutput P_ele_cool_input(unit="W")
    "Electrical power input of the DES for cooling"
    annotation (Placement(transformation(extent={{280,190},{300,170}})));
  Modelica.Blocks.Interfaces.RealOutput P_gas_heat_input(unit="W")
    "Gas power input of the DES for heating"
    annotation (Placement(transformation(extent={{280,130},{300,110}})));
  Modelica.Blocks.Interfaces.RealOutput P_gas_cool_input(unit="W")
    "Gas power input of the DES for cooling"
    annotation (Placement(transformation(extent={{280,90},{300,70}})));
equation
  connect(ref.ports[1], port_a) annotation (Line(points={{-180,-182},{-80,-182},
          {-80,-300}}, color={0,127,255}));
  annotation (
    Diagram(coordinateSystem(extent={{-280,-300},{280,300}})),
    Icon(coordinateSystem(extent={{-280,-300},{280,300}}), graphics={
        Rectangle(
        extent={{-280,-302},{280,300}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-72,-92},{70,-232}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-87,-164},{82,-174}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-86,-174},{-2,-164}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-66.75,4.75},{66.75,-4.75}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          origin={79.25,-230.75},
          rotation=-90),
        Rectangle(
          extent={{-67.5,-4.5},{67.5,4.5}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          origin={-82.5,-232.5},
          rotation=90)}),
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
end DES_TA_Interface;
