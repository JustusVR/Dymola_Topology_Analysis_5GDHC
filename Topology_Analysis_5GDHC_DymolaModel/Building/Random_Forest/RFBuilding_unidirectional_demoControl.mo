within Topology_Analysis_5GDHC_DymolaModel.Building.Random_Forest;
model RFBuilding_unidirectional_demoControl

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
protected
  Buildings.Fluid.Delays.DelayFirstOrder del(
    nPorts=4,
    redeclare package Medium = Medium,
    m_flow_nominal=1)
    annotation (Placement(transformation(extent={{-250,22},{-230,42}})));
public
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_hea(
    redeclare package Medium = Medium,
    addPowerToMedium=false,
    inputType=Buildings.Fluid.Types.InputType.Continuous,
    m_flow_nominal=3)
    annotation (Placement(transformation(extent={{-90,140},{-70,160}})));
public
  Modelica.Blocks.Interfaces.RealOutput eleHP_heat
    "Electrical power consumed for space heating"
    annotation (Placement(transformation(extent={{280,164},{300,184}})));
  Modelica.Blocks.Interfaces.RealOutput Qflow_heat "Space heating thermal load"
    annotation (Placement(transformation(extent={{280,146},{300,166}})));
protected
  Buildings.Fluid.Delays.DelayFirstOrder del1(
    nPorts=4,
    redeclare package Medium = Medium,
    m_flow_nominal=1)
    annotation (Placement(transformation(extent={{230,18},{250,38}})));
public
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_Cool(
    redeclare package Medium = Medium,
    addPowerToMedium=false,
    inputType=Buildings.Fluid.Types.InputType.Continuous,
    m_flow_nominal=3)
    annotation (Placement(transformation(extent={{-150,-200},{-130,-180}})));
public
  Modelica.Blocks.Interfaces.RealOutput eleHP_cool
    "Electrical power consumed for space heating"
    annotation (Placement(transformation(extent={{282,-248},{302,-228}})));
  Modelica.Blocks.Interfaces.RealOutput Qflow_cool "Space heating thermal load"
    annotation (Placement(transformation(extent={{280,-272},{300,-252}})));
protected
  Modelica.Blocks.Math.Gain FlowControl(k=-1/(4200*4))
    annotation (Placement(transformation(extent={{6,210},{-14,230}})));
  Modelica.Blocks.Math.Gain gain1(k=1/(4200*4))
    annotation (Placement(transformation(extent={{4,-150},{-16,-130}})));
public
  Modelica.Blocks.Interfaces.RealOutput elePumps
    annotation (Placement(transformation(extent={{280,230},{300,250}})));
  Modelica.Blocks.Math.Add3 add
    annotation (Placement(transformation(extent={{104,230},{124,250}})));
  Buildings.Fluid.HeatExchangers.HeaterCooler_u hea(
    m_flow_nominal=1,
    dp_nominal=10,
    Q_flow_nominal=1000,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-22,128},{26,174}})));
  Modelica.Blocks.Sources.CombiTimeTable heatLoad(
    tableOnFile=true,
    tableName="tab1",
    fileName=
        "/home/justus/Documents/LinReg_District_Heating_Cooling/loads/heating_ambient.mos")
    annotation (Placement(transformation(extent={{-52,160},{-40,172}})));
public
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_DHW(
    redeclare package Medium = Medium,
    addPowerToMedium=false,
    inputType=Buildings.Fluid.Types.InputType.Continuous,
    m_flow_nominal=3)
    annotation (Placement(transformation(extent={{-154,-10},{-134,10}})));
protected
  Modelica.Blocks.Math.Gain gain3(
                                 k=-1/(4200*4))
    annotation (Placement(transformation(extent={{-8,46},{-28,66}})));
public
  Buildings.Fluid.HeatExchangers.HeaterCooler_u hea1(
    m_flow_nominal=1,
    dp_nominal=10,
    Q_flow_nominal=1000,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-28,-24},{20,22}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_DHW(
    tableOnFile=true,
    tableName="tab1",
    fileName=
        "/home/justus/Documents/LinReg_District_Heating_Cooling/loads/heating_system.mos")
    annotation (Placement(transformation(extent={{-84,-30},{-64,-10}})));
  Modelica.Blocks.Math.Gain gain4(k=-1)
    annotation (Placement(transformation(extent={{-52,-26},{-40,-14}})));
  Buildings.Fluid.HeatExchangers.HeaterCooler_u hea2(
    m_flow_nominal=1,
    dp_nominal=10,
    Q_flow_nominal=1000,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-24,-212},{24,-166}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_Cool(
    tableOnFile=true,
    tableName="tab1",
    fileName=
        "/home/justus/Documents/LinReg_District_Heating_Cooling/loads/cooling_ambient.mos")
    annotation (Placement(transformation(extent={{-82,-230},{-62,-210}})));
  Modelica.Blocks.Math.Gain gain5(k=1)
    annotation (Placement(transformation(extent={{-50,-226},{-38,-214}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{138,-64},{158,-44}})));
equation

  connect(port_a, del.ports[1]) annotation (Line(points={{-280,0},{-243,0},{
          -243,22}},      color={0,127,255}));
  connect(del.ports[2], pump_hea.port_a) annotation (Line(points={{-241,22},{
          -241,0},{-220,0},{-220,150},{-90,150}},  color={0,127,255}));
  connect(port_a, port_a)
    annotation (Line(points={{-280,0},{-280,0}}, color={0,127,255}));
  connect(port_b, del1.ports[1])
    annotation (Line(points={{280,0},{237,0},{237,18}}, color={0,127,255}));
  connect(eleHP_heat, eleHP_heat)
    annotation (Line(points={{290,174},{290,174}}, color={0,0,127}));
  connect(FlowControl.y, pump_hea.m_flow_in) annotation (Line(points={{-15,
          220},{-80,220},{-80,162}}, color={0,0,127}));
  connect(gain1.y, pump_Cool.m_flow_in) annotation (Line(points={{-17,-140},{
          -140,-140},{-140,-178}}, color={0,0,127}));
  connect(add.y, elePumps)
    annotation (Line(points={{125,240},{290,240}}, color={0,0,127}));

  connect(pump_Cool.port_a, del.ports[3]) annotation (Line(points={{-150,-190},
          {-239,-190},{-239,22}}, color={0,127,255}));
  connect(pump_hea.port_b, hea.port_a) annotation (Line(points={{-70,150},{
          -22,150},{-22,151}},           color={0,127,255}));
  connect(hea.port_b, del1.ports[2]) annotation (Line(points={{26,151},{200,
          151},{200,0},{239,0},{239,18}}, color={0,127,255}));
  connect(hea.Q_flow, FlowControl.u) annotation (Line(points={{28.4,164.8},{
          40,164.8},{40,220},{8,220}}, color={0,0,127}));
  connect(gain3.y, pump_DHW.m_flow_in) annotation (Line(points={{-29,56},{
          -144,56},{-144,12}}, color={0,0,127}));
  connect(gain4.y, hea1.u) annotation (Line(points={{-39.4,-20},{-38,-20},{
          -38,12.8},{-32.8,12.8}}, color={0,0,127}));
  connect(pump_DHW.port_b, hea1.port_a) annotation (Line(points={{-134,0},{
          -94,0},{-94,-1},{-28,-1}}, color={0,127,255}));
  connect(hea1.Q_flow, gain3.u) annotation (Line(points={{22.4,12.8},{54,12.8},
          {54,56},{-6,56}}, color={0,0,127}));
  connect(hea1.port_b, del1.ports[3]) annotation (Line(points={{20,-1},{130,
          -1},{130,-2},{241,-2},{241,18}}, color={0,127,255}));
  connect(combiTimeTable_DHW.y[1], gain4.u)
    annotation (Line(points={{-63,-20},{-53.2,-20}}, color={0,0,127}));
  connect(pump_DHW.port_a, del.ports[4]) annotation (Line(points={{-154,0},{
          -237,0},{-237,22}}, color={0,127,255}));
  connect(pump_Cool.port_b, hea2.port_a) annotation (Line(points={{-130,-190},
          {-78,-190},{-78,-189},{-24,-189}}, color={0,127,255}));
  connect(hea2.port_b, del1.ports[4]) annotation (Line(points={{24,-189},{243,
          -189},{243,18}}, color={0,127,255}));
  connect(gain1.u, hea2.Q_flow) annotation (Line(points={{6,-140},{38,-140},{
          38,-175.2},{26.4,-175.2}}, color={0,0,127}));
  connect(combiTimeTable_Cool.y[1], gain5.u)
    annotation (Line(points={{-61,-220},{-51.2,-220}}, color={0,0,127}));
  connect(gain5.y, hea2.u) annotation (Line(points={{-37.4,-220},{-34,-220},{
          -34,-175.2},{-28.8,-175.2}}, color={0,0,127}));
  connect(hea2.Q_flow, Qflow_cool) annotation (Line(points={{26.4,-175.2},{
          218.2,-175.2},{218.2,-262},{290,-262}}, color={0,0,127}));
  connect(hea.Q_flow, Qflow_heat) annotation (Line(points={{28.4,164.8},{
          241.2,164.8},{241.2,156},{290,156}}, color={0,0,127}));
  connect(const.y, eleHP_heat) annotation (Line(points={{159,-54},{224,-54},{
          224,174},{290,174}}, color={0,0,127}));
  connect(eleHP_cool, const.y) annotation (Line(points={{292,-238},{226,-238},
          {226,-54},{159,-54}}, color={0,0,127}));
  connect(hea.u, heatLoad.y[1]) annotation (Line(points={{-26.8,164.8},{-28,
          164.8},{-28,166},{-39.4,166}}, color={0,0,127}));
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
end RFBuilding_unidirectional_demoControl;
