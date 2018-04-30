within Topology_Analysis_5GDHC.DES.Ideal_Source.Valve_Control;
model Control_Valve_demo
  Topology_Analysis_5GDHC.DES.Ideal_Source.Valve_Control.ValveControl
    valveControl annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,40})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Buildings.Fluid.Sources.MassFlowSource_T boundary(nPorts=1)
    annotation (Placement(transformation(extent={{-74,-10},{-54,10}})));
  Buildings.Fluid.Sources.Boundary_pT bou(nPorts=1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={60,0})));
  Buildings.Fluid.Sensors.Temperature senTem
    annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=293.15)
    annotation (Placement(transformation(extent={{40,50},{20,70}})));
equation
  connect(boundary.ports[1], val.port_a)
    annotation (Line(points={{-54,0},{-10,0}}, color={0,127,255}));
  connect(bou.ports[1], val.port_b) annotation (Line(points={{50,1.33227e-15},
          {30,1.33227e-15},{30,0},{10,0}}, color={0,127,255}));
  connect(valveControl.y, val.y)
    annotation (Line(points={{0,29},{0,12}}, color={0,0,127}));
  connect(senTem.port, val.port_a)
    annotation (Line(points={{-30,50},{-30,0},{-10,0}}, color={0,127,255}));
  connect(senTem.T, valveControl.T_inlet)
    annotation (Line(points={{-23,60},{-6,60},{-6,52}}, color={0,0,127}));
  connect(realExpression.y, valveControl.T_set)
    annotation (Line(points={{19,60},{6,60},{6,52}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Control_Valve_demo;
