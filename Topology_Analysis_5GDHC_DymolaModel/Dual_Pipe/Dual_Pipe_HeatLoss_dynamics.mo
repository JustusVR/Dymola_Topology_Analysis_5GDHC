within Topology_Analysis_5GDHC_DymolaModel.Dual_Pipe;
model Dual_Pipe_HeatLoss_dynamics

  replaceable package Medium =
      Modelica.Media.Interfaces.PartialMedium "Medium model for water";

  parameter Modelica.SIunits.Length diameter = sqrt(4*m_flow_nominal/pip_hot.rho_default/pip_hot.v_nominal/Modelica.Constants.pi) "Pipe diameter";
  parameter Modelica.SIunits.Length length "lenght of pipe";
  parameter Modelica.SIunits.ThermalConductivity lambdaIns = 0.04 "Heat conductivity of insulation"; //value from the Eurac Lab
  parameter Modelica.SIunits.Length thicknessIns = 0.04 "Thickness of insulation";
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal;
  parameter Boolean active = true;
  parameter Boolean dynamics = true;
  final parameter Modelica.Fluid.Types.Dynamics energyDyn = if dynamics then Modelica.Fluid.Types.Dynamics.DynamicFreeInitial else Modelica.Fluid.Types.Dynamics.SteadyState;

  Buildings.Fluid.FixedResistances.Pipe pip_hot(
    m_flow_nominal=m_flow_nominal,
    thicknessIns=thicknessIns,
    lambdaIns=lambdaIns,
    length=length,
    redeclare package Medium = Medium,
    diameter=diameter,
    energyDynamics=energyDyn)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=0,origin={2,60})));
  Buildings.Fluid.FixedResistances.Pipe pip_cold(
    m_flow_nominal=m_flow_nominal,
    thicknessIns=thicknessIns,
    lambdaIns=lambdaIns,
    length=length,
    redeclare package Medium = Medium,
    diameter=diameter,
    energyDynamics=energyDyn)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=0,origin={0,-60})));

  Modelica.Fluid.Interfaces.FluidPort_a port_a_hot(redeclare final package
      Medium = Medium, h_outflow(start=Medium.h_default)) "Fluid connector a"
    annotation (Placement(transformation(extent={{-102,50},{-82,70}}),
        iconTransformation(extent={{-122,30},{-82,70}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_hot(redeclare final package
      Medium = Medium, h_outflow(start=Medium.h_default)) "Fluid connector b"
    annotation (Placement(transformation(extent={{108,50},{88,70}}),
        iconTransformation(extent={{118,30},{78,70}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_cold(redeclare final package
      Medium = Medium, h_outflow(start=Medium.h_default)) "Fluid connector a"
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}}),
        iconTransformation(extent={{-120,-80},{-80,-40}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_cold(redeclare final package
      Medium =                                                                       Medium, h_outflow(start=Medium.h_default))
    "Fluid connector b"
    annotation (Placement(transformation(extent={{110,-70},{90,-50}}), iconTransformation(extent={{118,-80},{78,-40}})));
  Modelica.Fluid.Valves.ValveDiscrete valve_a(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=100000,
    opening_min=1e-6)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=0,  origin={-50,-60})));
  Modelica.Fluid.Valves.ValveDiscrete valve_a1(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=100000,
    opening_min=1e-6)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},rotation=0,  origin={-50,60})));
  Modelica.Blocks.Sources.BooleanConstant pipeActive(k=active)
    annotation (Placement(transformation(extent={{-12,-12},{12,12}},rotation=0,origin={-72,0})));
  Buildings.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=273 + 12)
    annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=-180,
        origin={40,0})));
  Modelica.Blocks.Interfaces.RealOutput heatLoss "Electrical power consumed by heat pumps"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,110})));
  Modelica.Blocks.Sources.RealExpression pipHot_heatLoss(y=pip_hot.heatPort.Q_flow)
    annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={50,75})));
  Modelica.Blocks.Sources.RealExpression pipCold_heatLoss(y=pip_hot.heatPort.Q_flow)
    annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={70,75})));
  Modelica.Blocks.Math.Add Sum_HeatLoss
    annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=90,
        origin={60,90})));
equation
  connect(pip_hot.port_b, port_b_hot)
    annotation (Line(points={{12,60},{98,60}}, color={0,127,255}));
  connect(port_a_hot, port_a_hot) annotation (Line(points={{-92,60},{-92,60}}, color={0,127,255}));
  connect(pip_cold.port_b, port_b_cold) annotation (Line(points={{10,-60},{100,-60}}, color={0,127,255}));
  connect(port_a_cold, valve_a.port_a) annotation (Line(points={{-100,-60},{-60,-60}}, color={0,127,255}));
  connect(valve_a.port_b, pip_cold.port_a) annotation (Line(points={{-40,-60},{-10,-60}}, color={0,127,255}));
  connect(port_a_hot, valve_a1.port_a) annotation (Line(points={{-92,60},{-60,60}}, color={0,127,255}));
  connect(valve_a1.port_b, pip_hot.port_a) annotation (Line(points={{-40,60},{
          -8,60}},                                                                      color={0,127,255}));
  connect(pipeActive.y, valve_a.open)
    annotation (Line(points={{-58.8,0},{-50,0},{-50,-52}}, color={255,0,255}));
  connect(pipeActive.y, valve_a1.open)
    annotation (Line(points={{-58.8,0},{-50,0},{-50,52}}, color={255,0,255}));
  connect(fixedTemperature.port, pip_hot.heatPort)
    annotation (Line(points={{35,-8.88178e-16},{20,-8.88178e-16},{20,80},{2,80},
          {2,65}},                                                               color={191,0,0}));
  connect(fixedTemperature.port, pip_cold.heatPort) annotation (Line(points={{35,-8.88178e-16},{20,-8.88178e-16},{20,-40},{0,-40},{0,-55}},
                                                                                                                      color={191,0,0}));
  connect(heatLoss, Sum_HeatLoss.y) annotation (Line(points={{60,110},{60,93.3}}, color={0,0,127}));
  connect(pipHot_heatLoss.y, Sum_HeatLoss.u1) annotation (Line(points={{50,80.5},
          {50,83.3},{58.2,83.3},{58.2,86.4}},                                                                        color={0,0,127}));
  connect(pipCold_heatLoss.y, Sum_HeatLoss.u2)
    annotation (Line(points={{70,80.5},{70,84},{62,84},{62,86},{61.8,86},{61.8,
          86.4}},                                                                                color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={184,184,184},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,-40},{100,-80}},
          lineColor={28,108,200},
          fillColor={18,30,200},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,70},{100,30}},
          lineColor={28,108,200},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid)}),
                              Diagram(coordinateSystem(preserveAspectRatio=false)));
end Dual_Pipe_HeatLoss_dynamics;
