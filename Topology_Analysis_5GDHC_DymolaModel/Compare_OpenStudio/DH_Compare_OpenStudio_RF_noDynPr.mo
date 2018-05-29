within Topology_Analysis_5GDHC_DymolaModel.Compare_OpenStudio;
model DH_Compare_OpenStudio_RF_noDynPr

replaceable package Medium =
      Buildings.Media.Water "Medium model for water";

parameter Modelica.SIunits.PressureDifference dp_nominal = 1;
parameter Modelica.SIunits.HeatFlowRate Q_nominal_heat = 12239.79892;
parameter Modelica.SIunits.HeatFlowRate Q_nominal_cool = 19489.31688;
parameter Modelica.SIunits.TemperatureDifference dT_nominal= 6;
parameter Modelica.SIunits.MassFlowRate m_flow_nominal = 5*Q_nominal_cool/(cp_nominal*dT_nominal);
parameter Modelica.SIunits.HeatCapacity cp_nominal = 4187;
parameter Real R_nominal(unit="Pa/m") = 100 "Pressure drop per meter at nominal flow rate";
  Building.Random_Forest.RFBuilding_unidirectional_noDynPr linRegBuilding(
      redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-346,-28},{-290,32}})));
  Building.Random_Forest.RFBuilding_unidirectional_noDynPr linRegBuilding1(
      redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-186,-30},{-130,30}})));
  Building.Random_Forest.RFBuilding_unidirectional_noDynPr linRegBuilding2(
      redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-28,-30},{28,30}})));
  Building.Random_Forest.RFBuilding_unidirectional_noDynPr linRegBuilding3(
      redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{132,-30},{188,30}})));
  Building.Random_Forest.RFBuilding_unidirectional_noDynPr linRegBuilding4(
      redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{292,-30},{348,30}})));
  Buildings.Fluid.FixedResistances.LosslessPipe
                                        pip(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-380,36})));
  Buildings.Fluid.FixedResistances.LosslessPipe
                                        pip1(m_flow_nominal=m_flow_nominal,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-220,40})));
public
  Buildings.Fluid.FixedResistances.LosslessPipe
                                        pip2(m_flow_nominal=m_flow_nominal,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-60,40})));
public
  Buildings.Fluid.FixedResistances.LosslessPipe
                                        pip3(m_flow_nominal=m_flow_nominal,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={100,40})));
public
  Buildings.Fluid.FixedResistances.LosslessPipe
                                        pip4(m_flow_nominal=m_flow_nominal,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={260,40})));
public
  Buildings.Fluid.FixedResistances.LosslessPipe
                                        pip9(m_flow_nominal=m_flow_nominal,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={-260,-42})));
  Buildings.Fluid.FixedResistances.LosslessPipe
                                        pip8(m_flow_nominal=m_flow_nominal,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-100,-40})));
public
  Buildings.Fluid.FixedResistances.LosslessPipe
                                        pip7(m_flow_nominal=m_flow_nominal,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={60,-40})));
public
  Buildings.Fluid.FixedResistances.LosslessPipe
                                        pip6(m_flow_nominal=m_flow_nominal,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={220,-40})));
public
  Buildings.Fluid.FixedResistances.LosslessPipe
                                        pip5(m_flow_nominal=m_flow_nominal,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={380,-40})));
public
  DES.Ideal_Source.Heater_Chiller_noDyn HeaterChiller(redeclare package Medium =
        Medium) "Model to set the reference pressure" annotation (Placement(
        transformation(
        extent={{-23,-21},{23,21}},
        origin={-533,3},
        rotation=90)));
  Modelica.Blocks.Sources.Constant const(k=293.15)
    annotation (Placement(transformation(extent={{-652,-10},{-632,10}})));
protected
  Modelica.Blocks.Math.MultiSum SumPumps(nu=5)
    "Electrical energy use for space heating and hot water"
    annotation (Placement(transformation(extent={{460,354},{472,366}})));
public
  Modelica.Blocks.Continuous.Integrator EPumps(y(unit="J"))
    "Electrical energy for space heating and hot water"
    annotation (Placement(transformation(extent={{500,350},{520,370}})));
  Buildings.Fluid.Sources.Boundary_pT pSet1(
                                           redeclare package Medium = Medium,
      nPorts=1) "Model to set the reference pressure"
                                          annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-592,-62})));
  Buildings.Fluid.FixedResistances.LosslessPipe
                                        pip0(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal)
               annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-450,80})));
  Buildings.Fluid.FixedResistances.LosslessPipe
                                        pip10(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-450,-80})));
public
  Modelica.Blocks.Continuous.Integrator Chiller_QCool(y(unit="J"))
    "Electrical energy for space heating and hot water"
    annotation (Placement(transformation(extent={{500,320},{520,340}})));
public
  Modelica.Blocks.Continuous.Integrator Heater_QHeat(y(unit="J"))
    "Electrical energy for space heating and hot water"
    annotation (Placement(transformation(extent={{500,290},{520,310}})));
public
  Modelica.Blocks.Continuous.Integrator Building_QCool(y(unit="J"))
    "Electrical energy for space heating and hot water"
    annotation (Placement(transformation(extent={{500,262},{520,282}})));
public
  Modelica.Blocks.Continuous.Integrator Building_QHeat(y(unit="J"))
    "Electrical energy for space heating and hot water"
    annotation (Placement(transformation(extent={{500,230},{520,250}})));
public
  Modelica.Blocks.Continuous.Integrator Buidling_ElHPHeat(y(unit="J"))
    annotation (Placement(transformation(extent={{500,200},{520,220}})));
public
  Modelica.Blocks.Continuous.Integrator Building_ElHPCool(y(unit="J"))
    "Electrical energy for space heating and hot water"
    annotation (Placement(transformation(extent={{500,170},{520,190}})));
equation
  connect(SumPumps.y, EPumps.u)
    annotation (Line(points={{473.02,360},{498,360}}, color={0,0,127}));
  connect(SumPumps.u[1], linRegBuilding4.elePumps) annotation (Line(points={{460,
          363.36},{460,362},{360,362},{360,24},{349,24}},   color={0,0,127}));
  connect(SumPumps.u[2], linRegBuilding3.elePumps) annotation (Line(points={{460,
          361.68},{312,361.68},{312,362},{200,362},{200,24},{189,24}},
        color={0,0,127}));
  connect(SumPumps.u[3], linRegBuilding2.elePumps) annotation (Line(points={{460,360},
          {38,360},{38,24},{29,24}},                  color={0,0,127}));
  connect(SumPumps.u[4], linRegBuilding1.elePumps) annotation (Line(points={{460,
          358.32},{460,362},{-120,362},{-120,24},{-129,24}},
        color={0,0,127}));
  connect(SumPumps.u[5], linRegBuilding.elePumps) annotation (Line(points={{460,
          356.64},{460,362},{-280,362},{-280,26},{-289,26}},
                        color={0,0,127}));

  connect(HeaterChiller.port_a, pSet1.ports[1]) annotation (Line(points={{
          -534.615,-19.6714},{-534.615,-62.8357},{-582,-62.8357},{-582,-62}},
        color={0,127,255}));
  connect(const.y, HeaterChiller.T_set) annotation (Line(points={{-631,0},{-600,
          0},{-600,-0.285714},{-557.231,-0.285714}},       color={0,0,127}));
  connect(pip.port_b, linRegBuilding.port_a)
    annotation (Line(points={{-380,26},{-380,2},{-346,2}}, color={0,127,255}));
  connect(linRegBuilding.port_b, pip9.port_a) annotation (Line(points={{-290.2,
          2},{-260,2},{-260,-32}}, color={0,127,255}));
  connect(pip1.port_b, linRegBuilding1.port_a)
    annotation (Line(points={{-220,30},{-220,0},{-186,0}}, color={0,127,255}));
  connect(pip2.port_b, linRegBuilding2.port_a)
    annotation (Line(points={{-60,30},{-60,0},{-28,0}}, color={0,127,255}));
  connect(linRegBuilding1.port_b, pip8.port_b) annotation (Line(points={{-130.2,
          0},{-100,0},{-100,-30}}, color={0,127,255}));
  connect(pip3.port_b, linRegBuilding3.port_a)
    annotation (Line(points={{100,30},{100,0},{132,0}}, color={0,127,255}));
  connect(linRegBuilding2.port_b, pip7.port_a)
    annotation (Line(points={{27.8,0},{60,0},{60,-30}}, color={0,127,255}));
  connect(linRegBuilding3.port_b, pip6.port_a)
    annotation (Line(points={{187.8,0},{220,0},{220,-30}}, color={0,127,255}));
  connect(linRegBuilding4.port_b, pip5.port_a)
    annotation (Line(points={{347.8,0},{380,0},{380,-30}}, color={0,127,255}));
  connect(pip4.port_b, linRegBuilding4.port_a)
    annotation (Line(points={{260,30},{260,0},{292,0}}, color={0,127,255}));
  connect(HeaterChiller.port_b, pip0.port_a) annotation (Line(points={{-534.615,
          25.6714},{-536.308,25.6714},{-536.308,80},{-460,80}}, color={0,127,
          255}));
  connect(pip10.port_a, HeaterChiller.port_a) annotation (Line(points={{-460,
          -80},{-536,-80},{-536,-19.6714},{-534.615,-19.6714}}, color={0,127,
          255}));
  connect(Building_QHeat.u, linRegBuilding.Qflow_heat) annotation (Line(points={{498,240},
          {468,240},{468,320},{-280,320},{-280,17.6},{-289,17.6}},
        color={0,0,127}));
  connect(linRegBuilding.eleHP_cool, Building_ElHPCool.u) annotation (Line(
        points={{-288.8,-21.8},{-280,-21.8},{-280,320},{464,320},{464,180},{
          498,180}},
                 color={0,0,127}));
  connect(linRegBuilding.eleHP_heat, Buidling_ElHPHeat.u) annotation (Line(
        points={{-289,19.4},{-280,19.4},{-280,320},{466,320},{466,210},{498,
          210}},
        color={0,0,127}));
  connect(Building_QCool.u, linRegBuilding.Qflow_cool) annotation (Line(points={{498,272},
          {470,272},{470,320},{-280,320},{-280,-24.2},{-289,-24.2}},
        color={0,0,127}));
  connect(HeaterChiller.Q_flowCool, Chiller_QCool.u) annotation (Line(points={{
          -524.923,27.6429},{-524.923,350},{478,350},{478,330},{498,330}},
        color={0,0,127}));
  connect(HeaterChiller.Q_flowHeat, Heater_QHeat.u) annotation (Line(points={{
          -544.308,27.6429},{-544.308,350},{478,350},{478,300},{498,300}},
        color={0,0,127}));
  connect(pip0.port_b, pip.port_a) annotation (Line(points={{-440,80},{-380,80},
          {-380,46}}, color={0,127,255}));
  connect(pip0.port_b, pip1.port_a) annotation (Line(points={{-440,80},{-220,80},
          {-220,50}}, color={0,127,255}));
  connect(pip0.port_b, pip2.port_a)
    annotation (Line(points={{-440,80},{-60,80},{-60,50}}, color={0,127,255}));
  connect(pip0.port_b, pip3.port_a)
    annotation (Line(points={{-440,80},{100,80},{100,50}}, color={0,127,255}));
  connect(pip0.port_b, pip4.port_a)
    annotation (Line(points={{-440,80},{260,80},{260,50}}, color={0,127,255}));
  connect(pip5.port_b, pip6.port_b) annotation (Line(points={{380,-50},{380,-80},
          {220,-80},{220,-50}}, color={0,127,255}));
  connect(pip5.port_b, pip7.port_b) annotation (Line(points={{380,-50},{380,-80},
          {60,-80},{60,-50}}, color={0,127,255}));
  connect(pip5.port_b, pip8.port_a) annotation (Line(points={{380,-50},{380,-80},
          {-100,-80},{-100,-50}}, color={0,127,255}));
  connect(pip5.port_b, pip9.port_b) annotation (Line(points={{380,-50},{380,-80},
          {-260,-80},{-260,-52}}, color={0,127,255}));
  connect(pip5.port_b, pip10.port_b) annotation (Line(points={{380,-50},{380,
          -82},{-440,-82},{-440,-80}}, color={0,127,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-660,-320},{660,420}}),
        graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent={{-380,-316},{356,416}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points={{-128,304},{230,48},{-130,-226},{-128,304}})}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-660,-320},{660,
            420}})));
end DH_Compare_OpenStudio_RF_noDynPr;
