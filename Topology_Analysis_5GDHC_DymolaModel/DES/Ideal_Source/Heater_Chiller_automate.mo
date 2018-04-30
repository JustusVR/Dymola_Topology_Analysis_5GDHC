within Topology_Analysis_5GDHC.DES.Ideal_Source;
model Heater_Chiller_automate

  replaceable package Medium =
      Buildings.Media.Water "Medium model for water";

  Buildings.Fluid.HeatExchangers.Heater_T hea(
    redeclare package Medium = Medium,
    m_flow_nominal=10,
    dp_nominal=10)
    annotation (Placement(transformation(extent={{32,30},{52,50}})));
  Buildings.Fluid.HeatExchangers.SensibleCooler_T coo(
    redeclare package Medium = Medium,
    m_flow_nominal=10,
    dp_nominal=10)
    annotation (Placement(transformation(extent={{32,-50},{52,-30}})));
  Buildings.Fluid.Actuators.Valves.ThreeWayLinear val1(
    m_flow_nominal=10,
    dpValve_nominal=10,
    dpFixed_nominal={1,1},
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    use_inputFilter=false)
    annotation (Placement(transformation(extent={{-50,-10},{-70,10}})));
  Topology_Analysis_5GDHC.DES.Ideal_Source.Valve_Control.ValveControl
    valveControl annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-60,38})));
  Modelica.Fluid.Sensors.Temperature Temp_inlet(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-110,58},{-90,78}})));
  Modelica.Blocks.Interfaces.RealOutput Q_flowHeat
    "Heat flow rate added to the fluid (if flow is from port_a to port_b)"
    annotation (Placement(transformation(extent={{280,110},{300,130}})));
  Modelica.Blocks.Interfaces.RealOutput Q_flowCool
    "Heat flow rate added to the fluid (if flow is from port_a to port_b)"
    annotation (Placement(transformation(extent={{280,-68},{300,-48}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(
    redeclare final package Medium = Medium,
    h_outflow(start=Medium.h_default)) "Fluid connector a"
    annotation (Placement(transformation(extent={{-70,-310},{-50,-290}}),
        iconTransformation(extent={{-50,-312},{-30,-290}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(
    redeclare final package Medium = Medium,
    h_outflow(start=Medium.h_default)) "Fluid connector b"
    annotation (Placement(transformation(extent={{72,-310},{52,-290}}),
        iconTransformation(extent={{54,-312},{32,-288}})));
  Buildings.Fluid.Actuators.Valves.ThreeWayLinear val2(
    m_flow_nominal=10,
    dpValve_nominal=10,
    dpFixed_nominal={1,1},
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    use_inputFilter=false)
    annotation (Placement(transformation(extent={{92,-10},{112,10}})));
  Buildings.Fluid.Sources.Boundary_pT pSet1(
                                           redeclare package Medium = Medium,
      nPorts=1) "Model to set the reference pressure"
                                          annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        origin={-90,-58})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=293)
    annotation (Placement(transformation(extent={{-30,90},{-10,110}})));
equation
  connect(val1.port_1, hea.port_a) annotation (Line(points={{-50,0},{-40,0},{
          -40,40},{32,40}}, color={0,127,255}));
  connect(val1.port_3, coo.port_a) annotation (Line(points={{-60,-10},{-40,-10},
          {-40,-40},{32,-40}}, color={0,127,255}));
  connect(valveControl.y, val1.y)
    annotation (Line(points={{-60,27},{-60,12}}, color={0,0,127}));
  connect(Temp_inlet.T, valveControl.T_inlet)
    annotation (Line(points={{-93,68},{-66,68},{-66,50}}, color={0,0,127}));
  connect(hea.Q_flow, Q_flowHeat) annotation (Line(points={{53,48},{80,48},{80,120},{290,120}},
                     color={0,0,127}));
  connect(coo.Q_flow, Q_flowCool) annotation (Line(points={{53,-32},{80,-32},{80,-58},{290,-58}},
                           color={0,0,127}));
  connect(port_a, val1.port_2)
    annotation (Line(points={{-60,-300},{-106,-300},{-106,0},{-70,0}},
                                                color={0,127,255}));
  connect(port_a, Temp_inlet.port)
    annotation (Line(points={{-60,-300},{-100,-300},{-100,58}},
                                                           color={0,127,255}));
  connect(val2.port_2, port_b)
    annotation (Line(points={{112,0},{128,0},{128,-300},{62,-300}},
                                               color={0,127,255}));
  connect(val2.port_3, coo.port_b) annotation (Line(points={{102,-10},{102,-40},
          {52,-40}}, color={0,127,255}));
  connect(val2.port_1, hea.port_b) annotation (Line(points={{92,0},{72,0},{72,
          40},{52,40}}, color={0,127,255}));
  connect(valveControl.y, val2.y) annotation (Line(points={{-60,27},{-60,20},{
          102,20},{102,12}}, color={0,0,127}));
  connect(pSet1.ports[1], port_a) annotation (Line(points={{-100,-58},{-120,-58},{-120,-300},{-60,-300}},
                                   color={0,127,255}));
  connect(realExpression.y, valveControl.T_set) annotation (Line(points={{-9,
          100},{0,100},{0,68},{-54,68},{-54,50}}, color={0,0,127}));
  connect(realExpression.y, hea.TSet) annotation (Line(points={{-9,100},{0,
          100},{0,48},{30,48}}, color={0,0,127}));
  connect(realExpression.y, coo.TSet) annotation (Line(points={{-9,100},{0,
          100},{0,-32},{30,-32}}, color={0,0,127}));
  annotation (
      Diagram(coordinateSystem(extent={{-280,-300},{280,300}})),
      Icon(coordinateSystem(extent={{-280,-300},{280,300}}), graphics={
          Rectangle(
          extent={{-284,300},{280,-300}},
          lineColor={28,108,200},
          fillColor={238,46,47},
          fillPattern=FillPattern.Forward)}), Diagram(coordinateSystem(extent={
            {-140,-140},{140,120}})));
end Heater_Chiller_automate;
