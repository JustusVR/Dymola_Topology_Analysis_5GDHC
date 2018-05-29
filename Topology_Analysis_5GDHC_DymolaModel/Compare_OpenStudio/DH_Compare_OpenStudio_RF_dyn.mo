within Topology_Analysis_5GDHC_DymolaModel.Compare_OpenStudio;
model DH_Compare_OpenStudio_RF_dyn

replaceable package Medium =
      Buildings.Media.Water "Medium model for water";

parameter Modelica.SIunits.PressureDifference dp_nominal = 1;
parameter Modelica.SIunits.HeatFlowRate Q_nominal_heat = 12239.79892;
parameter Modelica.SIunits.HeatFlowRate Q_nominal_cool = 19489.31688;
parameter Modelica.SIunits.TemperatureDifference dT_nominal= 6;
parameter Modelica.SIunits.MassFlowRate m_flow_nominal = 5*Q_nominal_cool/(cp_nominal*dT_nominal);
parameter Modelica.SIunits.HeatCapacity cp_nominal = 4187;
parameter Real R_nominal(unit="Pa/m") = 100 "Pressure drop per meter at nominal flow rate";

  Building.Random_Forest.RFBuilding_unidirectional_dyn linRegBuilding(
      redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-348,-28},{-292,32}})));
  Building.Random_Forest.RFBuilding_unidirectional_dyn linRegBuilding1(
      redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-188,-30},{-132,30}})));
  Building.Random_Forest.RFBuilding_unidirectional_dyn linRegBuilding2(
      redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-28,-30},{28,30}})));
  Building.Random_Forest.RFBuilding_unidirectional_dyn linRegBuilding3(
      redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{132,-30},{188,30}})));
  Building.Random_Forest.RFBuilding_unidirectional_dyn linRegBuilding4(
      redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{292,-30},{348,30}})));
  Buildings.Fluid.FixedResistances.Pipe pip(
    redeclare package Medium = Medium,
    nSeg=3,
    lambdaIns=0.04,
    m_flow_nominal=m_flow_nominal,
    thicknessIns=0.2,
    length=25)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-380,36})));
  Buildings.Fluid.FixedResistances.Pipe pip1(m_flow_nominal=m_flow_nominal,
    redeclare package Medium = Medium,
    nSeg=3,
    thicknessIns=0.2,
    lambdaIns=0.04,
    length=25)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-220,40})));
protected
  Buildings.Fluid.FixedResistances.Junction jun1(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal*{1,1,1},
    dp_nominal=40*R_nominal*{0,1,1})
    annotation (Placement(transformation(extent={{-230,70},{-210,90}})));
public
  Buildings.Fluid.FixedResistances.Pipe pip2(m_flow_nominal=m_flow_nominal,
    redeclare package Medium = Medium,
    nSeg=3,
    thicknessIns=0.2,
    lambdaIns=0.04,
    length=25)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-60,40})));
protected
  Buildings.Fluid.FixedResistances.Junction jun2(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal*{1,1,1},
    dp_nominal=40*R_nominal*{0,1,1})
    annotation (Placement(transformation(extent={{-70,70},{-50,90}})));
public
  Buildings.Fluid.FixedResistances.Pipe pip3(m_flow_nominal=m_flow_nominal,
    redeclare package Medium = Medium,
    nSeg=3,
    thicknessIns=0.2,
    lambdaIns=0.04,
    length=25)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={100,40})));
protected
  Buildings.Fluid.FixedResistances.Junction jun3(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal*{1,1,1},
    dp_nominal=40*R_nominal*{0,1,1})
    annotation (Placement(transformation(extent={{90,70},{110,90}})));
public
  Buildings.Fluid.FixedResistances.Pipe pip4(m_flow_nominal=m_flow_nominal,
    redeclare package Medium = Medium,
    nSeg=3,
    thicknessIns=0.2,
    lambdaIns=0.04,
    length=25)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={260,40})));
protected
  Buildings.Fluid.FixedResistances.Junction jun(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal*{1,1,1},
    dp_nominal=40*R_nominal*{0,1,1})
    annotation (Placement(transformation(extent={{-390,70},{-370,90}})));
public
  Buildings.Fluid.FixedResistances.Pipe pip9(m_flow_nominal=m_flow_nominal,
    redeclare package Medium = Medium,
    nSeg=3,
    thicknessIns=0.2,
    lambdaIns=0.04,
    length=25)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={-260,-42})));
  Buildings.Fluid.FixedResistances.Pipe pip8(m_flow_nominal=m_flow_nominal,
    redeclare package Medium = Medium,
    nSeg=3,
    thicknessIns=0.2,
    lambdaIns=0.04,
    length=25)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-100,-40})));
protected
  Buildings.Fluid.FixedResistances.Junction jun8(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal*{1,1,1},
    dp_nominal=40*R_nominal*{0,1,1})
    annotation (Placement(transformation(extent={{-110,-70},{-90,-90}})));
public
  Buildings.Fluid.FixedResistances.Pipe pip7(m_flow_nominal=m_flow_nominal,
    redeclare package Medium = Medium,
    nSeg=3,
    thicknessIns=0.2,
    lambdaIns=0.04,
    length=25)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={60,-40})));
protected
  Buildings.Fluid.FixedResistances.Junction jun7(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal*{1,1,1},
    dp_nominal=40*R_nominal*{0,1,1})
    annotation (Placement(transformation(extent={{50,-70},{70,-90}})));
public
  Buildings.Fluid.FixedResistances.Pipe pip6(m_flow_nominal=m_flow_nominal,
    redeclare package Medium = Medium,
    nSeg=3,
    thicknessIns=0.2,
    lambdaIns=0.04,
    length=25)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={220,-40})));
protected
  Buildings.Fluid.FixedResistances.Junction jun6(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal*{1,1,1},
    dp_nominal=40*R_nominal*{0,1,1})
    annotation (Placement(transformation(extent={{210,-70},{230,-90}})));
public
  Buildings.Fluid.FixedResistances.Pipe pip5(m_flow_nominal=m_flow_nominal,
    redeclare package Medium = Medium,
    nSeg=3,
    thicknessIns=0.2,
    lambdaIns=0.04,
    length=25)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={380,-40})));
protected
  Buildings.Fluid.FixedResistances.Junction jun9(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal*{1,1,1},
    dp_nominal=40*R_nominal*{0,1,1})
    annotation (Placement(transformation(extent={{-270,-70},{-250,-90}})));
public
  DES.Ideal_Source.Heater_Chiller_noDyn HeaterChiller(redeclare package Medium =
        Medium) "Model to set the reference pressure" annotation (Placement(
        transformation(
        extent={{-23,-21},{23,21}},
        origin={-533,3},
        rotation=90)));
  Buildings.HeatTransfer.Sources.FixedTemperature
                                        TEnv(T=285.15)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={-90,280})));
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
  Buildings.Fluid.FixedResistances.Pipe pip0(
    redeclare package Medium = Medium,
    nSeg=3,
    lambdaIns=0.04,
    m_flow_nominal=m_flow_nominal,
    thicknessIns=0.2,
    length=25) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-450,80})));
  Buildings.Fluid.FixedResistances.Pipe pip10(
    redeclare package Medium = Medium,
    nSeg=3,
    lambdaIns=0.04,
    m_flow_nominal=m_flow_nominal,
    thicknessIns=0.2,
    length=25)
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
  Modelica.Blocks.Sources.RealExpression heatLoss_pip(y=pip.heatPort.Q_flow)
    annotation (Placement(transformation(extent={{460,110},{480,130}})));
  Modelica.Blocks.Sources.RealExpression heatLoss_pip1(y=pip1.heatPort.Q_flow)
    annotation (Placement(transformation(extent={{460,90},{480,110}})));
  Modelica.Blocks.Sources.RealExpression heatLoss_pip2(y=pip2.heatPort.Q_flow)
    annotation (Placement(transformation(extent={{460,70},{480,90}})));
  Modelica.Blocks.Sources.RealExpression heatLoss_pip3(y=pip3.heatPort.Q_flow)
    annotation (Placement(transformation(extent={{460,50},{480,70}})));
  Modelica.Blocks.Sources.RealExpression heatLoss_pip4(y=pip4.heatPort.Q_flow)
    annotation (Placement(transformation(extent={{460,30},{480,50}})));
  Modelica.Blocks.Sources.RealExpression heatLoss_pip5(y=pip5.heatPort.Q_flow)
    annotation (Placement(transformation(extent={{460,10},{480,30}})));
  Modelica.Blocks.Sources.RealExpression heatLoss_pip6(y=pip6.heatPort.Q_flow)
    annotation (Placement(transformation(extent={{460,-10},{480,10}})));
  Modelica.Blocks.Sources.RealExpression heatLoss_pip7(y=pip7.heatPort.Q_flow)
    annotation (Placement(transformation(extent={{460,-30},{480,-10}})));
  Modelica.Blocks.Sources.RealExpression heatLoss_pip8(y=pip8.heatPort.Q_flow)
    annotation (Placement(transformation(extent={{460,-50},{480,-30}})));
  Modelica.Blocks.Sources.RealExpression heatLoss_pip9(y=pip9.heatPort.Q_flow)
    annotation (Placement(transformation(extent={{460,-70},{480,-50}})));
  Modelica.Blocks.Sources.RealExpression heatLoss_pip10(y=pip10.heatPort.Q_flow)
    annotation (Placement(transformation(extent={{460,-90},{480,-70}})));
  Modelica.Blocks.Sources.RealExpression heatLoss_pip0(y=pip0.heatPort.Q_flow)
    annotation (Placement(transformation(extent={{460,130},{480,150}})));
  Modelica.Blocks.Math.MultiSum Sum_HeatLoss(nu=12)
    annotation (Placement(transformation(extent={{540,34},{552,46}})));
public
  Modelica.Blocks.Continuous.Integrator Pip_HeatLoss(y(unit="J"))
    "Electrical energy for space heating and hot water"
    annotation (Placement(transformation(extent={{580,30},{600,50}})));
equation
  connect(TEnv.port, pip2.heatPort) annotation (Line(points={{-90,270},{-90,140},
          {-44,140},{-44,40},{-55,40}},
                                 color={191,0,0}));
  connect(TEnv.port, pip1.heatPort) annotation (Line(points={{-90,270},{-90,140},
          {-204,140},{-204,40},{-215,40}},
                                 color={191,0,0}));
  connect(TEnv.port, pip3.heatPort) annotation (Line(points={{-90,270},{-90,140},
          {116,140},{116,40},{105,40},{105,40}},
                             color={191,0,0}));
  connect(TEnv.port, pip4.heatPort) annotation (Line(points={{-90,270},{-90,140},
          {272,140},{272,40},{266,40},{266,40},{265,40}},
                               color={191,0,0}));
  connect(TEnv.port, pip.heatPort) annotation (Line(points={{-90,270},{-90,140},
          {-368,140},{-368,36},{-375,36}},
                                 color={191,0,0}));
  connect(TEnv.port, pip6.heatPort) annotation (Line(points={{-90,270},{-90,140},
          {416,140},{416,-140},{176,-140},{176,-40},{215,-40}},
                                                      color={191,0,0}));
  connect(TEnv.port, pip7.heatPort) annotation (Line(points={{-90,270},{-90,140},
          {418,140},{418,-140},{18,-140},{18,-40},{55,-40}},
                                                    color={191,0,0}));
  connect(TEnv.port, pip8.heatPort) annotation (Line(points={{-90,270},{-90,140},
          {418,140},{418,-140},{-142,-140},{-142,-40},{-105,-40}},color={191,0,
          0}));
  connect(TEnv.port, pip9.heatPort) annotation (Line(points={{-90,270},{-90,140},
          {418,140},{418,-140},{-302,-140},{-302,-42},{-265,-42}},
                                                        color={191,0,0}));
  connect(TEnv.port, pip5.heatPort) annotation (Line(points={{-90,270},{-90,140},
          {418,140},{418,-140},{338,-140},{338,-40},{375,-40}},
                                                      color={191,0,0}));
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
          358.32},{460,362},{-120,362},{-120,24},{-131,24}},
        color={0,0,127}));
  connect(SumPumps.u[5], linRegBuilding.elePumps) annotation (Line(points={{460,
          356.64},{460,364},{-280,364},{-280,26},{-291,26}},
                        color={0,0,127}));

  connect(HeaterChiller.port_a, pSet1.ports[1]) annotation (Line(points={{
          -534.615,-19.6714},{-534.615,-62.8357},{-582,-62.8357},{-582,-62}},
        color={0,127,255}));
  connect(const.y, HeaterChiller.T_set) annotation (Line(points={{-631,0},{-600,
          0},{-600,-0.285714},{-557.231,-0.285714}},       color={0,0,127}));
  connect(jun.port_3, pip.port_a)
    annotation (Line(points={{-380,70},{-380,46}}, color={0,127,255}));
  connect(pip.port_b, linRegBuilding.port_a)
    annotation (Line(points={{-380,26},{-380,2},{-348,2}}, color={0,127,255}));
  connect(linRegBuilding.port_b, pip9.port_a) annotation (Line(points={{-292.2,
          2},{-260,2},{-260,-32}}, color={0,127,255}));
  connect(pip9.port_b, jun9.port_3)
    annotation (Line(points={{-260,-52},{-260,-70}}, color={0,127,255}));
  connect(jun.port_2, jun1.port_1)
    annotation (Line(points={{-370,80},{-230,80}}, color={0,127,255}));
  connect(jun1.port_3, pip1.port_a)
    annotation (Line(points={{-220,70},{-220,50}}, color={0,127,255}));
  connect(pip1.port_b, linRegBuilding1.port_a)
    annotation (Line(points={{-220,30},{-220,0},{-188,0}}, color={0,127,255}));
  connect(jun2.port_3, pip2.port_a)
    annotation (Line(points={{-60,70},{-60,50}}, color={0,127,255}));
  connect(pip2.port_b, linRegBuilding2.port_a)
    annotation (Line(points={{-60,30},{-60,0},{-28,0}}, color={0,127,255}));
  connect(jun1.port_2, jun2.port_1)
    annotation (Line(points={{-210,80},{-70,80}}, color={0,127,255}));
  connect(linRegBuilding1.port_b, pip8.port_b) annotation (Line(points={{-132.2,
          0},{-100,0},{-100,-30}}, color={0,127,255}));
  connect(pip8.port_a, jun8.port_3) annotation (Line(points={{-100,-50},{-100,
          -70},{-100,-70}}, color={0,127,255}));
  connect(jun9.port_2, jun8.port_1)
    annotation (Line(points={{-250,-80},{-110,-80}}, color={0,127,255}));
  connect(jun2.port_2, jun3.port_1)
    annotation (Line(points={{-50,80},{90,80}}, color={0,127,255}));
  connect(jun3.port_3, pip3.port_a)
    annotation (Line(points={{100,70},{100,50}}, color={0,127,255}));
  connect(pip3.port_b, linRegBuilding3.port_a)
    annotation (Line(points={{100,30},{100,0},{132,0}}, color={0,127,255}));
  connect(linRegBuilding2.port_b, pip7.port_a)
    annotation (Line(points={{27.8,0},{60,0},{60,-30}}, color={0,127,255}));
  connect(pip7.port_b, jun7.port_3)
    annotation (Line(points={{60,-50},{60,-70}}, color={0,127,255}));
  connect(jun8.port_2, jun7.port_1)
    annotation (Line(points={{-90,-80},{50,-80}}, color={0,127,255}));
  connect(linRegBuilding3.port_b, pip6.port_a)
    annotation (Line(points={{187.8,0},{220,0},{220,-30}}, color={0,127,255}));
  connect(pip6.port_b, jun6.port_3)
    annotation (Line(points={{220,-50},{220,-70}}, color={0,127,255}));
  connect(jun6.port_1, jun7.port_2)
    annotation (Line(points={{210,-80},{70,-80}}, color={0,127,255}));
  connect(jun6.port_2, pip5.port_b) annotation (Line(points={{230,-80},{380,-80},
          {380,-50}}, color={0,127,255}));
  connect(linRegBuilding4.port_b, pip5.port_a)
    annotation (Line(points={{347.8,0},{380,0},{380,-30}}, color={0,127,255}));
  connect(jun3.port_2, pip4.port_a)
    annotation (Line(points={{110,80},{260,80},{260,50}}, color={0,127,255}));
  connect(pip4.port_b, linRegBuilding4.port_a)
    annotation (Line(points={{260,30},{260,0},{292,0}}, color={0,127,255}));
  connect(HeaterChiller.port_b, pip0.port_a) annotation (Line(points={{-534.615,
          25.6714},{-536.308,25.6714},{-536.308,80},{-460,80}}, color={0,127,
          255}));
  connect(pip0.port_b, jun.port_1)
    annotation (Line(points={{-440,80},{-390,80}}, color={0,127,255}));
  connect(jun9.port_1, pip10.port_b)
    annotation (Line(points={{-270,-80},{-440,-80}}, color={0,127,255}));
  connect(pip10.port_a, HeaterChiller.port_a) annotation (Line(points={{-460,
          -80},{-536,-80},{-536,-19.6714},{-534.615,-19.6714}}, color={0,127,
          255}));
  connect(TEnv.port, pip0.heatPort) annotation (Line(points={{-90,270},{-90,140},
          {-450,140},{-450,85}}, color={191,0,0}));
  connect(TEnv.port, pip10.heatPort) annotation (Line(points={{-90,270},{-90,
          140},{418,140},{418,-140},{-450,-140},{-450,-85}}, color={191,0,0}));
  connect(Building_QHeat.u, linRegBuilding.Qflow_heat) annotation (Line(points=
          {{498,240},{468,240},{468,320},{-280,320},{-280,17.6},{-291,17.6}},
        color={0,0,127}));
  connect(linRegBuilding.eleHP_cool, Building_ElHPCool.u) annotation (Line(
        points={{-290.8,-21.8},{-280,-21.8},{-280,320},{464,320},{464,180},{498,
          180}}, color={0,0,127}));
  connect(linRegBuilding.eleHP_heat, Buidling_ElHPHeat.u) annotation (Line(
        points={{-291,19.4},{-280,19.4},{-280,320},{466,320},{466,210},{498,210}},
        color={0,0,127}));
  connect(Building_QCool.u, linRegBuilding.Qflow_cool) annotation (Line(points=
          {{498,272},{470,272},{470,320},{-280,320},{-280,-24.2},{-291,-24.2}},
        color={0,0,127}));
  connect(HeaterChiller.Q_flowCool, Chiller_QCool.u) annotation (Line(points={{
          -524.923,27.6429},{-524.923,350},{478,350},{478,330},{498,330}},
        color={0,0,127}));
  connect(HeaterChiller.Q_flowHeat, Heater_QHeat.u) annotation (Line(points={{
          -544.308,27.6429},{-544.308,350},{474,350},{474,300},{498,300}},
        color={0,0,127}));
  connect(heatLoss_pip0.y, Sum_HeatLoss.u[1]) annotation (Line(points={{481,140},
          {520,140},{520,42},{540,42},{540,43.85}}, color={0,0,127}));
  connect(heatLoss_pip.y, Sum_HeatLoss.u[2]) annotation (Line(points={{481,120},
          {481,120},{520,120},{520,42},{540,42},{540,43.15}}, color={0,0,127}));
  connect(heatLoss_pip1.y, Sum_HeatLoss.u[3]) annotation (Line(points={{481,100},
          {520,100},{520,42.45},{540,42.45}}, color={0,0,127}));
  connect(heatLoss_pip2.y, Sum_HeatLoss.u[4]) annotation (Line(points={{481,80},
          {520,80},{520,41.75},{540,41.75}}, color={0,0,127}));
  connect(heatLoss_pip3.y, Sum_HeatLoss.u[5]) annotation (Line(points={{481,60},
          {520,60},{520,41.05},{540,41.05}}, color={0,0,127}));
  connect(heatLoss_pip4.y, Sum_HeatLoss.u[6]) annotation (Line(points={{481,40},
          {520,40},{520,40},{530,40},{530,40.35},{540,40.35}}, color={0,0,127}));
  connect(heatLoss_pip5.y, Sum_HeatLoss.u[7]) annotation (Line(points={{481,20},
          {520,20},{520,39.65},{540,39.65}}, color={0,0,127}));
  connect(heatLoss_pip6.y, Sum_HeatLoss.u[8]) annotation (Line(points={{481,0},
          {520,0},{520,38.95},{540,38.95}}, color={0,0,127}));
  connect(heatLoss_pip7.y, Sum_HeatLoss.u[9]) annotation (Line(points={{481,-20},
          {520,-20},{520,40},{540,40},{540,38.25}}, color={0,0,127}));
  connect(heatLoss_pip8.y, Sum_HeatLoss.u[10]) annotation (Line(points={{481,
          -40},{520,-40},{520,37.55},{540,37.55}}, color={0,0,127}));
  connect(heatLoss_pip9.y, Sum_HeatLoss.u[11]) annotation (Line(points={{481,
          -60},{520,-60},{520,36.85},{540,36.85}}, color={0,0,127}));
  connect(heatLoss_pip10.y, Sum_HeatLoss.u[12]) annotation (Line(points={{481,
          -80},{520,-80},{520,36.15},{540,36.15}}, color={0,0,127}));
  connect(Sum_HeatLoss.y, Pip_HeatLoss.u)
    annotation (Line(points={{553.02,40},{578,40}}, color={0,0,127}));
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
end DH_Compare_OpenStudio_RF_dyn;
