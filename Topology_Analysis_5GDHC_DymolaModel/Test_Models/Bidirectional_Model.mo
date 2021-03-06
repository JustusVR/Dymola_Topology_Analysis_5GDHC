within Topology_Analysis_5GDHC_DymolaModel.Test_Models;
model Bidirectional_Model

replaceable package Medium =
      Buildings.Media.Water "Medium model for water";

parameter Modelica.SIunits.PressureDifference dp_nominal = 1;
parameter Modelica.SIunits.HeatFlowRate Q_nominal = 45000;
parameter Modelica.SIunits.TemperatureDifference dT_nominal= 4;
parameter Modelica.SIunits.MassFlowRate m_flow_nominal = 5*Q_nominal/(4200*dT_nominal);
parameter Real R_nominal(unit="Pa/m") = 100 "Pressure drop per meter at nominal flow rate";

  Building.Automated_Model_Building.Building_bidirectional linRegBuilding(
      redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-346,-28},{-290,32}})));
  Building.Automated_Model_Building.Building_bidirectional linRegBuilding1(
      redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-186,-30},{-130,30}})));
  Building.Automated_Model_Building.Building_bidirectional linRegBuilding2(
      redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-28,-30},{28,30}})));
  Building.Automated_Model_Building.Building_bidirectional linRegBuilding3(
      redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{132,-30},{188,30}})));
  Building.Automated_Model_Building.Building_bidirectional linRegBuilding4(
      redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{292,-30},{348,30}})));
  Buildings.Fluid.FixedResistances.Pipe pip(
    redeclare package Medium = Medium,
    nSeg=3,
    lambdaIns=0.04,
    m_flow_nominal=m_flow_nominal,
    length=100,
    thicknessIns=0.2)
    annotation (Placement(transformation(extent={{-430,70},{-410,90}})));
  Buildings.Fluid.FixedResistances.Pipe pip1(m_flow_nominal=m_flow_nominal,
    redeclare package Medium = Medium,
    nSeg=3,
    thicknessIns=0.2,
    lambdaIns=0.04,
    length=100)
    annotation (Placement(transformation(extent={{-270,70},{-250,90}})));
protected
  Buildings.Fluid.FixedResistances.Junction jun1(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal*{1,1,1},
    dp_nominal=40*R_nominal*{0,1,1})
    annotation (Placement(transformation(extent={{-228,70},{-208,90}})));
public
  Buildings.Fluid.FixedResistances.Pipe pip2(m_flow_nominal=m_flow_nominal,
    redeclare package Medium = Medium,
    nSeg=3,
    thicknessIns=0.2,
    lambdaIns=0.04,
    length=100)
    annotation (Placement(transformation(extent={{-110,70},{-90,90}})));
protected
  Buildings.Fluid.FixedResistances.Junction jun2(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal*{1,1,1},
    dp_nominal=40*R_nominal*{0,1,1})
    annotation (Placement(transformation(extent={{-68,70},{-48,90}})));
public
  Buildings.Fluid.FixedResistances.Pipe pip3(m_flow_nominal=m_flow_nominal,
    redeclare package Medium = Medium,
    nSeg=3,
    thicknessIns=0.2,
    lambdaIns=0.04,
    length=100)
    annotation (Placement(transformation(extent={{50,70},{70,90}})));
protected
  Buildings.Fluid.FixedResistances.Junction jun3(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal*{1,1,1},
    dp_nominal=40*R_nominal*{0,1,1})
    annotation (Placement(transformation(extent={{92,70},{112,90}})));
public
  Buildings.Fluid.FixedResistances.Pipe pip4(m_flow_nominal=m_flow_nominal,
    redeclare package Medium = Medium,
    nSeg=3,
    thicknessIns=0.2,
    lambdaIns=0.04,
    length=100)
    annotation (Placement(transformation(extent={{230,70},{250,90}})));
protected
  Buildings.Fluid.FixedResistances.Junction jun(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal*{1,1,1},
    dp_nominal=40*R_nominal*{0,1,1})
    annotation (Placement(transformation(extent={{-388,70},{-368,90}})));
public
  Buildings.Fluid.FixedResistances.Pipe pip9(m_flow_nominal=m_flow_nominal,
    redeclare package Medium = Medium,
    nSeg=3,
    thicknessIns=0.2,
    lambdaIns=0.04,
    length=100)
    annotation (Placement(transformation(extent={{-310,-70},{-290,-90}})));
  Buildings.Fluid.FixedResistances.Pipe pip8(m_flow_nominal=m_flow_nominal,
    redeclare package Medium = Medium,
    nSeg=3,
    thicknessIns=0.2,
    lambdaIns=0.04,
    length=100)
    annotation (Placement(transformation(extent={{-150,-70},{-130,-90}})));
protected
  Buildings.Fluid.FixedResistances.Junction jun8(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal*{1,1,1},
    dp_nominal=40*R_nominal*{0,1,1})
    annotation (Placement(transformation(extent={{-108,-70},{-88,-90}})));
public
  Buildings.Fluid.FixedResistances.Pipe pip7(m_flow_nominal=m_flow_nominal,
    redeclare package Medium = Medium,
    nSeg=3,
    thicknessIns=0.2,
    lambdaIns=0.04,
    length=100)
    annotation (Placement(transformation(extent={{10,-70},{30,-90}})));
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
    length=100)
    annotation (Placement(transformation(extent={{170,-70},{190,-90}})));
protected
  Buildings.Fluid.FixedResistances.Junction jun6(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal*{1,1,1},
    dp_nominal=40*R_nominal*{0,1,1})
    annotation (Placement(transformation(extent={{208,-70},{228,-90}})));
public
  Buildings.Fluid.FixedResistances.Pipe pip5(m_flow_nominal=m_flow_nominal,
    redeclare package Medium = Medium,
    nSeg=3,
    thicknessIns=0.2,
    lambdaIns=0.04,
    length=100)
    annotation (Placement(transformation(extent={{350,-70},{370,-90}})));
protected
  Buildings.Fluid.FixedResistances.Junction jun9(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal*{1,1,1},
    dp_nominal=40*R_nominal*{0,1,1})
    annotation (Placement(transformation(extent={{-268,-70},{-248,-90}})));
public
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
      computeWetBulbTemperature=false, filNam=
        "modelica://Buildings/Resources/weatherdata/USA_CO_Golden-NREL.724666_TMY3dy.mos")
                                       "File reader that reads weather data"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={30,282})));
  Buildings.Utilities.Time.CalendarTime calTim(
    zerTim=Buildings.Utilities.Time.Types.ZeroTime.NY2018,
    year(start=2018),
    month(start=1))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-30,280})));
  Buildings.BoundaryConditions.WeatherData.Bus
                                     weaBus "Weather data bus"
     annotation (Placement(
        transformation(extent={{22,230},{38,246}}),     iconTransformation(
          extent={{-328,64},{-308,84}})));
  DES.Old.Ideal_T_JVR des(redeclare package Medium = Medium, m_flow_nominal=1)
    "Model to set the reference pressure" annotation (Placement(transformation(
        extent={{-23,-21},{23,21}},
        origin={-567,79},
        rotation=0)));
  Buildings.HeatTransfer.Sources.FixedTemperature
                                        TEnv(T=285.15)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={-90,280})));
  Modelica.Blocks.Sources.Constant const(k=273.15 + 20)
    annotation (Placement(transformation(extent={{-648,172},{-618,202}})));
protected
  Modelica.Blocks.Math.MultiSum SumPumps(nu=5)
    "Electrical energy use for space heating and hot water"
    annotation (Placement(transformation(extent={{418,354},{430,366}})));
public
  Modelica.Blocks.Continuous.Integrator EPumps(y(unit="J"))
    "Electrical energy for space heating and hot water"
    annotation (Placement(transformation(extent={{454,350},{474,370}})));
  Buildings.Fluid.Sources.Boundary_pT pSet1(
                                           redeclare package Medium = Medium,
      nPorts=1) "Model to set the reference pressure"
                                          annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-592,-62})));
  Modelica.Blocks.Sources.Constant const1(k=273.15 + 16)
    annotation (Placement(transformation(extent={{-644,96},{-616,124}})));
equation
  connect(jun1.port_2, pip2.port_a)
    annotation (Line(points={{-208,80},{-110,80}}, color={0,127,255}));
  connect(pip2.port_b, jun2.port_1)
    annotation (Line(points={{-90,80},{-68,80}}, color={0,127,255}));
  connect(jun2.port_2, pip3.port_a)
    annotation (Line(points={{-48,80},{50,80}}, color={0,127,255}));
  connect(pip3.port_b, jun3.port_1)
    annotation (Line(points={{70,80},{92,80}}, color={0,127,255}));
  connect(jun3.port_2, pip4.port_a)
    annotation (Line(points={{112,80},{230,80}}, color={0,127,255}));
  connect(pip4.port_b, linRegBuilding4.port_a) annotation (Line(points={{250,80},
          {260,80},{260,-30},{312,-30}}, color={0,127,255}));
  connect(jun2.port_3, linRegBuilding2.port_a) annotation (Line(points={{-58,70},
          {-58,-30},{-8,-30}},  color={0,127,255}));
  connect(jun3.port_3, linRegBuilding3.port_a) annotation (Line(points={{102,70},
          {102,-30},{152,-30}}, color={0,127,255}));
  connect(pip1.port_b, jun1.port_1)
    annotation (Line(points={{-250,80},{-228,80}}, color={0,127,255}));
  connect(jun1.port_3, linRegBuilding1.port_a) annotation (Line(points={{-218,70},
          {-218,-30},{-166,-30}},        color={0,127,255}));
  connect(jun.port_3, linRegBuilding.port_a) annotation (Line(points={{-378,70},
          {-378,-28},{-326,-28}}, color={0,127,255}));
  connect(pip.port_b, jun.port_1)
    annotation (Line(points={{-410,80},{-388,80}}, color={0,127,255}));
  connect(jun.port_2, pip1.port_a)
    annotation (Line(points={{-368,80},{-270,80}}, color={0,127,255}));
  connect(jun8.port_2, pip7.port_a)
    annotation (Line(points={{-88,-80},{10,-80}}, color={0,127,255}));
  connect(pip7.port_b, jun7.port_1)
    annotation (Line(points={{30,-80},{50,-80}}, color={0,127,255}));
  connect(jun7.port_2, pip6.port_a)
    annotation (Line(points={{70,-80},{170,-80}}, color={0,127,255}));
  connect(pip6.port_b, jun6.port_1)
    annotation (Line(points={{190,-80},{208,-80}}, color={0,127,255}));
  connect(jun6.port_2, pip5.port_a)
    annotation (Line(points={{228,-80},{350,-80}}, color={0,127,255}));
  connect(pip8.port_b, jun8.port_1)
    annotation (Line(points={{-130,-80},{-108,-80}}, color={0,127,255}));
  connect(pip9.port_b, jun9.port_1)
    annotation (Line(points={{-290,-80},{-268,-80}}, color={0,127,255}));
  connect(jun9.port_2, pip8.port_a)
    annotation (Line(points={{-248,-80},{-150,-80}}, color={0,127,255}));
  connect(linRegBuilding4.port_b, pip5.port_b) annotation (Line(points={{328,-30},
          {380,-30},{380,-80},{370,-80}},
                                        color={0,127,255}));
  connect(linRegBuilding3.port_b, jun6.port_3)
    annotation (Line(points={{168,-30},{218,-30},{218,-70}},
                                                         color={0,127,255}));
  connect(linRegBuilding2.port_b, jun7.port_3)
    annotation (Line(points={{8,-30},{60,-30},{60,-70}},
                                                      color={0,127,255}));
  connect(linRegBuilding1.port_b, jun8.port_3) annotation (Line(points={{-150,
          -30},{-98,-30},{-98,-70}},
                                color={0,127,255}));
  connect(linRegBuilding.port_b, jun9.port_3) annotation (Line(points={{-310,
          -28},{-258,-28},{-258,-70}},
                                color={0,127,255}));
  connect(weaDat.weaBus,weaBus)  annotation (Line(
      points={{30,272},{30,238}},
      color={255,204,51},
      thickness=0.5));
  connect(TEnv.port, pip2.heatPort) annotation (Line(points={{-90,270},{-90,140},
          {-100,140},{-100,85}}, color={191,0,0}));
  connect(TEnv.port, pip1.heatPort) annotation (Line(points={{-90,270},{-90,140},
          {-260,140},{-260,85}}, color={191,0,0}));
  connect(TEnv.port, pip3.heatPort) annotation (Line(points={{-90,270},{-90,140},
          {60,140},{60,85}}, color={191,0,0}));
  connect(TEnv.port, pip4.heatPort) annotation (Line(points={{-90,270},{-90,140},
          {240,140},{240,85}}, color={191,0,0}));
  connect(TEnv.port, pip.heatPort) annotation (Line(points={{-90,270},{-90,140},
          {-420,140},{-420,85}}, color={191,0,0}));
  connect(TEnv.port, pip6.heatPort) annotation (Line(points={{-90,270},{-90,140},
          {440,140},{440,-140},{180,-140},{180,-85}}, color={191,0,0}));
  connect(TEnv.port, pip7.heatPort) annotation (Line(points={{-90,270},{-90,140},
          {440,140},{440,-140},{20,-140},{20,-85}}, color={191,0,0}));
  connect(TEnv.port, pip8.heatPort) annotation (Line(points={{-90,270},{-90,140},
          {440,140},{440,-140},{-140,-140},{-140,-85}},           color={191,0,
          0}));
  connect(TEnv.port, pip9.heatPort) annotation (Line(points={{-90,270},{-90,140},
          {440,140},{440,-140},{-300,-140},{-300,-85}}, color={191,0,0}));
  connect(TEnv.port, pip5.heatPort) annotation (Line(points={{-90,270},{-90,140},
          {440,140},{440,-140},{360,-140},{360,-85}}, color={191,0,0}));
  connect(SumPumps.y, EPumps.u)
    annotation (Line(points={{431.02,360},{452,360}}, color={0,0,127}));
  connect(SumPumps.u[1], linRegBuilding4.elePumps) annotation (Line(points={{418,
          363.36},{418,362},{360,362},{360,31},{300,31}},   color={0,0,127}));
  connect(SumPumps.u[2], linRegBuilding3.elePumps) annotation (Line(points={{418,
          361.68},{314,361.68},{314,362},{196,362},{196,42},{140,42},{140,31}},
        color={0,0,127}));
  connect(SumPumps.u[3], linRegBuilding2.elePumps) annotation (Line(points={{418,360},
          {40,360},{40,40},{-20,40},{-20,31}},        color={0,0,127}));
  connect(SumPumps.u[4], linRegBuilding1.elePumps) annotation (Line(points={{418,
          358.32},{418,362},{-120,362},{-120,31},{-178,31}},
        color={0,0,127}));
  connect(SumPumps.u[5], linRegBuilding.elePumps) annotation (Line(points={{418,
          356.64},{418,356},{422,356},{422,362},{-282,362},{-282,33},{-338,33}},
                        color={0,0,127}));

  connect(des.port_b, pip.port_a) annotation (Line(points={{-560.429,58},{
          -513.308,58},{-513.308,80},{-430,80}}, color={0,127,255}));
  connect(des.port_a, pSet1.ports[1]) annotation (Line(points={{-573.571,58},{
          -573.571,-42.8357},{-582,-42.8357},{-582,-62}}, color={0,127,255}));
  connect(pip9.port_a, des.port_a) annotation (Line(points={{-310,-80},{-620,
          -80},{-620,58},{-573.571,58}}, color={0,127,255}));
  connect(const.y, des.TSetHea) annotation (Line(points={{-616.5,187},{-591.643,
          187},{-591.643,84.46}}, color={0,0,127}));
  connect(const1.y, des.TSetCoo) annotation (Line(points={{-614.6,110},{-614.6,
          97},{-591.643,97},{-591.643,81.66}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-660,-320},{660,420}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-660,-320},{660,
            420}})));
end Bidirectional_Model;
