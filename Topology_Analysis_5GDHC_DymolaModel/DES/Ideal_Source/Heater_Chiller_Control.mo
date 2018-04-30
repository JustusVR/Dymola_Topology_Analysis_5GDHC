within Topology_Analysis_5GDHC.DES.Ideal_Source;
model Heater_Chiller_Control
  import LinReg_District_Heating_Cooling = Topology_Analysis_5GDHC;

  Modelica.Fluid.Interfaces.FluidPort_a port_a(
    redeclare final package Medium = Medium,
     m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0),
     h_outflow(start = Medium.h_default))
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(
    redeclare final package Medium = Medium,
    m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0),
     h_outflow(start = Medium.h_default))
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{108,-10},{88,10}})));
  LinReg_District_Heating_Cooling.DES.Ideal_Source.Heater_Chiller_noDyn
    heater_Chiller
    annotation (Placement(transformation(extent={{-14,26},{14,52}})));
  LinReg_District_Heating_Cooling.DES.Ideal_Source.Heater_Chiller_noDyn
    heater_Chiller1
    annotation (Placement(transformation(extent={{14,-54},{-14,-28}})));
  Buildings.Fluid.Actuators.Valves.ThreeWayLinear val1
    annotation (Placement(transformation(extent={{-60,-10},{-80,10}})));
  Buildings.Fluid.Actuators.Valves.ThreeWayLinear val2
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFlo
    annotation (Placement(transformation(extent={{70,-10},{90,10}})));
  LinReg_District_Heating_Cooling.DES.Ideal_Source.Valve_Control.ValveControl2
    valveControl2_1
    annotation (Placement(transformation(extent={{68,56},{60,64}})));
equation
  connect(port_a, val1.port_2)
    annotation (Line(points={{-100,0},{-80,0}}, color={0,127,255}));
  connect(val1.port_1, heater_Chiller.port_a) annotation (Line(points={{-60,0},{
          -48,0},{-48,40},{-13.8,40}},  color={0,127,255}));
  connect(val1.port_3, heater_Chiller1.port_b) annotation (Line(points={{-70,-10},
          {-48,-10},{-48,-40},{-13.8,-40}},      color={0,127,255}));
  connect(val2.port_3, heater_Chiller1.port_a) annotation (Line(points={{50,-10},
          {30,-10},{30,-40},{13.8,-40}}, color={0,127,255}));
  connect(val2.port_1, heater_Chiller.port_b) annotation (Line(points={{40,0},{30,
          0},{30,40},{13.8,40}},    color={0,127,255}));
  connect(port_b, senMasFlo.port_b)
    annotation (Line(points={{98,0},{90,0}}, color={0,127,255}));
  connect(val2.port_2, senMasFlo.port_a)
    annotation (Line(points={{60,0},{70,0}}, color={0,127,255}));
  connect(senMasFlo.m_flow, valveControl2_1.u)
    annotation (Line(points={{80,11},{80,60},{68.8,60}}, color={0,0,127}));
  connect(valveControl2_1.y, val2.y)
    annotation (Line(points={{59.6,60},{50,60},{50,12}}, color={0,0,127}));
  connect(valveControl2_1.y, val1.y)
    annotation (Line(points={{59.6,60},{-70,60},{-70,12}}, color={0,0,127}));
  annotation (Icon(graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={238,46,47},
          fillPattern=FillPattern.Forward), Text(
          extent={{-32,14},{30,-26}},
          lineColor={0,0,0},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid,
          textString="C",
          textStyle={TextStyle.Bold})}));
end Heater_Chiller_Control;
