within Topology_Analysis_5GDHC_DymolaModel.DES.Ideal_Source;
model Plant_Control
  import LinReg_District_Heating_Cooling = Topology_Analysis_5GDHC_DymolaModel;

    replaceable package Medium =
      Modelica.Media.Interfaces.PartialMedium "Medium model for water";

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
  Buildings.Experimental.DistrictHeatingCooling.Plants.HeatingCoolingCarnot_T
    heater_Chiller(redeclare package Medium = Medium, m_flow_nominal=0.01)
    annotation (Placement(transformation(extent={{-14,26},{14,52}})));
  Buildings.Experimental.DistrictHeatingCooling.Plants.HeatingCoolingCarnot_T
    heater_Chiller1(redeclare package Medium = Medium, m_flow_nominal=0.1)
    annotation (Placement(transformation(extent={{14,-54},{-14,-28}})));
  Buildings.Fluid.Actuators.Valves.ThreeWayLinear val1(
    redeclare package Medium = Medium,
    m_flow_nominal=0.1,
    dpValve_nominal=0)
    annotation (Placement(transformation(extent={{-58,-10},{-78,10}})));
  Buildings.Fluid.Actuators.Valves.ThreeWayLinear val2(
    redeclare package Medium = Medium,
    m_flow_nominal=0.1,
    dpValve_nominal=0)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{70,-10},{90,10}})));
  LinReg_District_Heating_Cooling.DES.Ideal_Source.Valve_Control.ValveControl2
    valveControl2_1
    annotation (Placement(transformation(extent={{68,56},{60,64}})));
  Modelica.Blocks.Interfaces.RealInput T_outside_dryBulb
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput T_Set_Hea
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput T_Set_Cool
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
equation
  connect(port_a, val1.port_2)
    annotation (Line(points={{-100,0},{-78,0}}, color={0,127,255}));
  connect(val1.port_1, heater_Chiller.port_a) annotation (Line(points={{-58,0},
          {-48,0},{-48,39},{-14,39}},color={0,127,255}));
  connect(val1.port_3, heater_Chiller1.port_b) annotation (Line(points={{-68,-10},
          {-48,-10},{-48,-41},{-14,-41}}, color={0,127,255}));
  connect(val2.port_3, heater_Chiller1.port_a) annotation (Line(points={{50,-10},
          {30,-10},{30,-41},{14,-41}}, color={0,127,255}));
  connect(val2.port_1, heater_Chiller.port_b) annotation (Line(points={{40,0},{30,
          0},{30,39},{14,39}}, color={0,127,255}));
  connect(port_b, senMasFlo.port_b)
    annotation (Line(points={{98,0},{90,0}}, color={0,127,255}));
  connect(val2.port_2, senMasFlo.port_a)
    annotation (Line(points={{60,0},{70,0}}, color={0,127,255}));
  connect(senMasFlo.m_flow, valveControl2_1.u)
    annotation (Line(points={{80,11},{80,60},{68.8,60}}, color={0,0,127}));
  connect(valveControl2_1.y, val2.y)
    annotation (Line(points={{59.6,60},{50,60},{50,12}}, color={0,0,127}));
  connect(valveControl2_1.y, val1.y)
    annotation (Line(points={{59.6,60},{-68,60},{-68,12}}, color={0,0,127}));
  connect(T_outside_dryBulb, heater_Chiller.TSink) annotation (Line(points={{-120,
          80},{-52,80},{-52,31.2},{-16.8,31.2}}, color={0,0,127}));
  connect(T_outside_dryBulb, heater_Chiller1.TSink) annotation (Line(points={{-120,
          80},{-52,80},{-52,-80},{40,-80},{40,-48.8},{16.8,-48.8}}, color={0,0,127}));
  connect(T_Set_Hea, heater_Chiller.TSetHea) annotation (Line(points={{-120,60},
          {-52,60},{-52,49.4},{-16.8,49.4}}, color={0,0,127}));
  connect(T_Set_Hea, heater_Chiller1.TSetHea) annotation (Line(points={{-120,60},
          {-52,60},{-52,-80},{40,-80},{40,-30.6},{16.8,-30.6}}, color={0,0,127}));
  connect(T_Set_Cool, heater_Chiller.TSetCoo) annotation (Line(points={{-120,40},
          {-52,40},{-52,44.2},{-16.8,44.2}}, color={0,0,127}));
  connect(T_Set_Cool, heater_Chiller1.TSetCoo) annotation (Line(points={{-120,40},
          {-52,40},{-52,-80},{40,-80},{40,-35.8},{16.8,-35.8}}, color={0,0,127}));
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
end Plant_Control;
