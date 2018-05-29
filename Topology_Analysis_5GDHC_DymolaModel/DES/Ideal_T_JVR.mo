within Topology_Analysis_5GDHC_DymolaModel.DES;
model Ideal_T_JVR
  "Ideal heating and cooling plant with leaving temperature as set point"
  extends Topology_Analysis_5GDHC_DymolaModel.DES.Base_Classes.DES_TA_Interface;

  Buildings.Fluid.HeatExchangers.PrescribedOutlet coo(
    redeclare package Medium = Medium,
    allowFlowReversal=allowFlowReversal,
    m_flow_nominal=m_flow_nominal,
    show_T=true,
    QMax_flow=0,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    tau=60,
    use_X_wSet=false,
    dp_nominal=dp_nominal)
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
  Modelica.Blocks.Sources.Constant TSetHeat(k=273.15 + Tset_hotPipe)
    annotation (Placement(transformation(extent={{-240,60},{-200,100}})));
  Modelica.Blocks.Sources.Constant TSetCool(k=273.15 + Tset_hotPipe - dT_set)
    annotation (Placement(transformation(extent={{-238,142},{-200,180}})));
  Modelica.Blocks.Sources.RealExpression const(y=0)
    annotation (Placement(transformation(extent={{180,88},{200,108}})));
equation
  connect(Q_H_flow, hea.Q_flow) annotation (Line(points={{290,-120},{-68,-120},
          {-68,8},{-41,8}},
                       color={0,0,127}));
  connect(coo.Q_flow, Q_C_flow) annotation (Line(points={{41,8},{102,8},{102,
          -200},{290,-200}},
                     color={0,0,127}));
  connect(TSetHeat.y, hea.TSet) annotation (Line(points={{-198,80},{-12,80},{-12,
          8},{-18,8}},       color={0,0,127}));
  connect(TSetCool.y, coo.TSet) annotation (Line(points={{-198.1,161},{12,161},{
          12,8},{18,8}},  color={0,0,127}));
  connect(hea.port_b, port_a)
    annotation (Line(points={{-40,0},{-80,0},{-80,-300}}, color={0,127,255}));
  connect(hea.port_a, senTem.port_a)
    annotation (Line(points={{-20,0},{-10,0}}, color={0,127,255}));
  connect(senTem.port_b, coo.port_a)
    annotation (Line(points={{10,0},{20,0}}, color={0,127,255}));
  connect(coo.port_b, port_b)
    annotation (Line(points={{40,0},{80,0},{80,-300}}, color={0,127,255}));
  connect(const.y, P_gas_heat_input) annotation (Line(points={{201,98},{242,98},
          {242,120},{290,120}}, color={0,0,127}));
  connect(const.y, P_gas_cool_input) annotation (Line(points={{201,98},{242,98},
          {242,80},{290,80}}, color={0,0,127}));
  connect(coo.Q_flow, P_ele_cool_input) annotation (Line(points={{41,8},{160,8},
          {160,180},{290,180}}, color={0,0,127}));
  connect(hea.Q_flow, P_ele_heat_input) annotation (Line(points={{-41,8},{-80,8},
          {-80,60},{140,60},{140,220},{290,220}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(extent={{-280,-300},{280,300}})),
    Icon(coordinateSystem(extent={{-280,-300},{280,300}}), graphics={Text(
          extent={{-280,64},{276,-112}},
          lineColor={28,108,200},
          textStyle={TextStyle.Bold},
          textString="Ideal
")}),
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
