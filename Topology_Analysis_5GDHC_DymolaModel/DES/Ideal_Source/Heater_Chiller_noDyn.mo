within Topology_Analysis_5GDHC.DES.Ideal_Source;
model Heater_Chiller_noDyn

  replaceable package Medium =
      Buildings.Media.Water "Medium model for water";

  parameter Modelica.SIunits.HeatFlowRate Q_nominal_heat = 12240;
  parameter Modelica.SIunits.HeatFlowRate Q_nominal_cool = 19489;
  parameter Modelica.SIunits.TemperatureDifference dT_nominal= 6;
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal = 5*Q_nominal_cool/(cp_nominal*dT_nominal);
  parameter Modelica.SIunits.HeatCapacity cp_nominal = 4187;

  Buildings.Fluid.HeatExchangers.Heater_T hea(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=1000)
    annotation (Placement(transformation(extent={{32,30},{52,50}})));
  Buildings.Fluid.HeatExchangers.SensibleCooler_T coo(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=1000)
    annotation (Placement(transformation(extent={{32,-50},{52,-30}})));
  Buildings.Fluid.Actuators.Valves.ThreeWayLinear val1(
    dpFixed_nominal={1,1},
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    use_inputFilter=false,
    m_flow_nominal=m_flow_nominal,
    dpValve_nominal=6000)
    annotation (Placement(transformation(extent={{-50,-10},{-70,10}})));
  Topology_Analysis_5GDHC.DES.Ideal_Source.Valve_Control.ValveControl
    valveControl annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-60,38})));
  Modelica.Fluid.Sensors.Temperature Temp_inlet(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-110,58},{-90,78}})));
  Modelica.Blocks.Interfaces.RealInput T_set annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-20,140})));
  Modelica.Blocks.Interfaces.RealOutput Q_flowHeat
    "Heat flow rate added to the fluid (if flow is from port_a to port_b)"
    annotation (Placement(transformation(extent={{140,50},{160,70}})));
  Modelica.Blocks.Interfaces.RealOutput Q_flowCool
    "Heat flow rate added to the fluid (if flow is from port_a to port_b)"
    annotation (Placement(transformation(extent={{140,-70},{160,-50}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(
    redeclare final package Medium = Medium,
    h_outflow(start=Medium.h_default)) "Fluid connector a"
    annotation (Placement(transformation(extent={{-152,-10},{-132,10}}),
        iconTransformation(extent={{-158,-20},{-118,20}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(
    redeclare final package Medium = Medium,
    h_outflow(start=Medium.h_default)) "Fluid connector b"
    annotation (Placement(transformation(extent={{152,-10},{132,10}}),
        iconTransformation(extent={{158,-20},{118,20}})));
  Buildings.Fluid.Actuators.Valves.ThreeWayLinear val2(
    dpFixed_nominal={1,1},
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    use_inputFilter=false,
    m_flow_nominal=m_flow_nominal,
    dpValve_nominal=6000)
    annotation (Placement(transformation(extent={{92,-10},{112,10}})));
equation
  connect(val1.port_1, hea.port_a) annotation (Line(points={{-50,0},{-40,0},{
          -40,40},{32,40}}, color={0,127,255}));
  connect(val1.port_3, coo.port_a) annotation (Line(points={{-60,-10},{-40,-10},
          {-40,-40},{32,-40}}, color={0,127,255}));
  connect(valveControl.y, val1.y)
    annotation (Line(points={{-60,27},{-60,12}}, color={0,0,127}));
  connect(Temp_inlet.T, valveControl.T_inlet)
    annotation (Line(points={{-93,68},{-66,68},{-66,50}}, color={0,0,127}));
  connect(hea.Q_flow, Q_flowHeat) annotation (Line(points={{53,48},{80,48},{80,
          60},{150,60}},
                     color={0,0,127}));
  connect(coo.Q_flow, Q_flowCool) annotation (Line(points={{53,-32},{80,-32},{
          80,-60},{150,-60}},
                           color={0,0,127}));
  connect(port_a, val1.port_2)
    annotation (Line(points={{-142,0},{-70,0}}, color={0,127,255}));
  connect(port_a, Temp_inlet.port)
    annotation (Line(points={{-142,0},{-100,0},{-100,58}}, color={0,127,255}));
  connect(val2.port_2, port_b)
    annotation (Line(points={{112,0},{142,0}}, color={0,127,255}));
  connect(val2.port_3, coo.port_b) annotation (Line(points={{102,-10},{102,-40},
          {52,-40}}, color={0,127,255}));
  connect(val2.port_1, hea.port_b) annotation (Line(points={{92,0},{72,0},{72,
          40},{52,40}}, color={0,127,255}));
  connect(valveControl.y, val2.y) annotation (Line(points={{-60,27},{-60,20},{
          102,20},{102,12}}, color={0,0,127}));
  connect(T_set, valveControl.T_set) annotation (Line(points={{-20,140},{-20,68},
          {-54,68},{-54,50}}, color={0,0,127}));
  connect(T_set, hea.TSet) annotation (Line(points={{-20,140},{-20,68},{20,68},
          {20,48},{30,48}}, color={0,0,127}));
  connect(T_set, coo.TSet)
    annotation (Line(points={{-20,140},{-20,-32},{30,-32}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(extent={{-140,-140},{140,120}}), graphics={
          Rectangle(
          extent={{-140,120},{140,-140}},
          lineColor={28,108,200},
          fillColor={238,46,47},
          fillPattern=FillPattern.Forward)}), Diagram(coordinateSystem(extent={
            {-140,-140},{140,120}})));
end Heater_Chiller_noDyn;
