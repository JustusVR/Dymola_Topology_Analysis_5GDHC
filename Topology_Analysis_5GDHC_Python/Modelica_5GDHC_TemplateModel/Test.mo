within Topology_Analysis_5GDHC.Automated_5GDHC;
model Test

  extends Modelica.Icons.Example;

  replaceable package Medium = Buildings.Media.Water;

  parameter Modelica.SIunits.MassFlowRate m_flow_nominal = 1;

public
  Building.Automated_Model_Building.Building_TA_LookUp Office2(
      redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{-20,-20},{20,20}},rotation = 0, origin = {-210,-70})));
protected
  Buildings.Fluid.Delays.DelayFirstOrder Office2_node_a(
      nPorts=6,
      redeclare package Medium = Medium,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-3,-3},{3,3}},rotation = 0, origin = {-215,-107})));
  Buildings.Fluid.Delays.DelayFirstOrder Office2_node_b(
      nPorts=6,
      redeclare package Medium = Medium,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-3,-3},{3,3}},rotation = 0, origin = {-205,-107})));

public
  Building.Automated_Model_Building.Building_TA_LookUp Office1(
      redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{-20,-20},{20,20}},rotation = 0, origin = {-210,350})));
protected
  Buildings.Fluid.Delays.DelayFirstOrder Office1_node_a(
      nPorts=6,
      redeclare package Medium = Medium,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-3,-3},{3,3}},rotation = 0, origin = {-215,313})));
  Buildings.Fluid.Delays.DelayFirstOrder Office1_node_b(
      nPorts=6,
      redeclare package Medium = Medium,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-3,-3},{3,3}},rotation = 0, origin = {-205,313})));

public
  Building.Automated_Model_Building.Building_TA_LookUp Office5(
      redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{-20,-20},{20,20}},rotation = 0, origin = {210,210})));
protected
  Buildings.Fluid.Delays.DelayFirstOrder Office5_node_a(
      nPorts=6,
      redeclare package Medium = Medium,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-3,-3},{3,3}},rotation = 0, origin = {205,173})));
  Buildings.Fluid.Delays.DelayFirstOrder Office5_node_b(
      nPorts=6,
      redeclare package Medium = Medium,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-3,-3},{3,3}},rotation = 0, origin = {215,173})));

public
  Building.Automated_Model_Building.Building_TA_LookUp Office3(
      redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{-20,-20},{20,20}},rotation = 0, origin = {-70,-350})));
protected
  Buildings.Fluid.Delays.DelayFirstOrder Office3_node_a(
      nPorts=6,
      redeclare package Medium = Medium,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-3,-3},{3,3}},rotation = 0, origin = {-75,-387})));
  Buildings.Fluid.Delays.DelayFirstOrder Office3_node_b(
      nPorts=6,
      redeclare package Medium = Medium,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-3,-3},{3,3}},rotation = 0, origin = {-65,-387})));

public
  Building.Automated_Model_Building.Building_TA_LookUp Office4(
      redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{-20,-20},{20,20}},rotation = 0, origin = {210,-210})));
protected
  Buildings.Fluid.Delays.DelayFirstOrder Office4_node_a(
      nPorts=6,
      redeclare package Medium = Medium,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-3,-3},{3,3}},rotation = 0, origin = {205,-247})));
  Buildings.Fluid.Delays.DelayFirstOrder Office4_node_b(
      nPorts=6,
      redeclare package Medium = Medium,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-3,-3},{3,3}},rotation = 0, origin = {215,-247})));

public
  Topology_Analysis_5GDHC.DES.Ideal_T_JVR NewDistrictSystem(
      redeclare package Medium = Medium,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-20,-20},{20,20}},rotation = 0, origin = {350,490})));
protected
  Buildings.Fluid.Delays.DelayFirstOrder NewDistrictSystem_node_a(
      nPorts=6,
      redeclare package Medium = Medium,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-3,-3},{3,3}},rotation = 0, origin = {345,453})));
  Buildings.Fluid.Delays.DelayFirstOrder NewDistrictSystem_node_b(
      nPorts=6,
      redeclare package Medium = Medium,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-3,-3},{3,3}},rotation = 0, origin = {355,453})));


public
  Topology_Analysis_5GDHC.Dual_Pipe.Dual_Pipe_HeatLoss Pipe_Office2_Office1(
      redeclare package Medium = Medium,
      length=34,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-5,-5},{5,5}},rotation = 0, origin = {-160,-120})));

  Topology_Analysis_5GDHC.Dual_Pipe.Dual_Pipe_HeatLoss Pipe_Office2_Office5(
      redeclare package Medium = Medium,
      length=57,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-5,-5},{5,5}},rotation = 0, origin = {-160,-95})));

  Topology_Analysis_5GDHC.Dual_Pipe.Dual_Pipe_HeatLoss Pipe_Office2_Office3(
      redeclare package Medium = Medium,
      length=52,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-5,-5},{5,5}},rotation = 0, origin = {-160,-70})));

  Topology_Analysis_5GDHC.Dual_Pipe.Dual_Pipe_HeatLoss Pipe_Office2_Office4(
      redeclare package Medium = Medium,
      length=110,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-5,-5},{5,5}},rotation = 0, origin = {-160,-45})));

  Topology_Analysis_5GDHC.Dual_Pipe.Dual_Pipe_HeatLoss Pipe_Office2_NewDistrictSystem(
      redeclare package Medium = Medium,
      length=202,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-5,-5},{5,5}},rotation = 0, origin = {-160,-20})));

  Topology_Analysis_5GDHC.Dual_Pipe.Dual_Pipe_HeatLoss Pipe_Office1_Office5(
      redeclare package Medium = Medium,
      length=88,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-5,-5},{5,5}},rotation = 0, origin = {-160,300})));

  Topology_Analysis_5GDHC.Dual_Pipe.Dual_Pipe_HeatLoss Pipe_Office1_Office3(
      redeclare package Medium = Medium,
      length=86,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-5,-5},{5,5}},rotation = 0, origin = {-160,325})));

  Topology_Analysis_5GDHC.Dual_Pipe.Dual_Pipe_HeatLoss Pipe_Office1_Office4(
      redeclare package Medium = Medium,
      length=143,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-5,-5},{5,5}},rotation = 0, origin = {-160,375})));

  Topology_Analysis_5GDHC.Dual_Pipe.Dual_Pipe_HeatLoss Pipe_Office1_NewDistrictSystem(
      redeclare package Medium = Medium,
      length=233,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-5,-5},{5,5}},rotation = 0, origin = {-160,400})));

  Topology_Analysis_5GDHC.Dual_Pipe.Dual_Pipe_HeatLoss Pipe_Office5_Office3(
      redeclare package Medium = Medium,
      length=23,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-5,-5},{5,5}},rotation = 0, origin = {260,160})));

  Topology_Analysis_5GDHC.Dual_Pipe.Dual_Pipe_HeatLoss Pipe_Office5_Office4(
      redeclare package Medium = Medium,
      length=56,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-5,-5},{5,5}},rotation = 0, origin = {260,210})));

  Topology_Analysis_5GDHC.Dual_Pipe.Dual_Pipe_HeatLoss Pipe_Office5_NewDistrictSystem(
      redeclare package Medium = Medium,
      length=146,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-5,-5},{5,5}},rotation = 0, origin = {260,260})));

  Topology_Analysis_5GDHC.Dual_Pipe.Dual_Pipe_HeatLoss Pipe_Office3_Office4(
      redeclare package Medium = Medium,
      length=60,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-5,-5},{5,5}},rotation = 0, origin = {-20,-400})));

  Topology_Analysis_5GDHC.Dual_Pipe.Dual_Pipe_HeatLoss Pipe_Office3_NewDistrictSystem(
      redeclare package Medium = Medium,
      length=156,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-5,-5},{5,5}},rotation = 0, origin = {-20,-300})));

  Topology_Analysis_5GDHC.Dual_Pipe.Dual_Pipe_HeatLoss Pipe_Office4_NewDistrictSystem(
      redeclare package Medium = Medium,
      length=97,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-5,-5},{5,5}},rotation = 0, origin = {260,-210})));


public
  Modelica.Blocks.Continuous.Integrator Buildings_PumpingElectricity_Energy(
      k = 1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {750,600})));
protected
  Modelica.Blocks.Math.MultiSum Sum_Buildings_PumpingElectricity(
      nu = 5)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {710,600})));
  Modelica.Blocks.Sources.RealExpression Buildings_PumpingElectricity_Office2(
      y = Office2.elePumps)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,650})));
  Modelica.Blocks.Sources.RealExpression Buildings_PumpingElectricity_Office1(
      y = Office1.elePumps)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,630})));
  Modelica.Blocks.Sources.RealExpression Buildings_PumpingElectricity_Office5(
      y = Office5.elePumps)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,610})));
  Modelica.Blocks.Sources.RealExpression Buildings_PumpingElectricity_Office3(
      y = Office3.elePumps)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,590})));
  Modelica.Blocks.Sources.RealExpression Buildings_PumpingElectricity_Office4(
      y = Office4.elePumps)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,570})));

public
  Modelica.Blocks.Continuous.Integrator Buildings_DH_Energy(
      k = 1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {750,460})));
protected
  Modelica.Blocks.Math.MultiSum Sum_Buildings_DH(
      nu = 5)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {710,460})));
  Modelica.Blocks.Sources.RealExpression Buildings_DH_Office2(
      y = Office2.Q_DH)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,510})));
  Modelica.Blocks.Sources.RealExpression Buildings_DH_Office1(
      y = Office1.Q_DH)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,490})));
  Modelica.Blocks.Sources.RealExpression Buildings_DH_Office5(
      y = Office5.Q_DH)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,470})));
  Modelica.Blocks.Sources.RealExpression Buildings_DH_Office3(
      y = Office3.Q_DH)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,450})));
  Modelica.Blocks.Sources.RealExpression Buildings_DH_Office4(
      y = Office4.Q_DH)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,430})));

public
  Modelica.Blocks.Continuous.Integrator Buildings_DC_Energy(
      k = 1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {750,320})));
protected
  Modelica.Blocks.Math.MultiSum Sum_Buildings_DC(
      nu = 5)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {710,320})));
  Modelica.Blocks.Sources.RealExpression Buildings_DC_Office2(
      y = Office2.Q_DC)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,370})));
  Modelica.Blocks.Sources.RealExpression Buildings_DC_Office1(
      y = Office1.Q_DC)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,350})));
  Modelica.Blocks.Sources.RealExpression Buildings_DC_Office5(
      y = Office5.Q_DC)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,330})));
  Modelica.Blocks.Sources.RealExpression Buildings_DC_Office3(
      y = Office3.Q_DC)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,310})));
  Modelica.Blocks.Sources.RealExpression Buildings_DC_Office4(
      y = Office4.Q_DC)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,290})));

public
  Modelica.Blocks.Continuous.Integrator Buildings_IH_Energy(
      k = 1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {750,180})));
protected
  Modelica.Blocks.Math.MultiSum Sum_Buildings_IH(
      nu = 5)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {710,180})));
  Modelica.Blocks.Sources.RealExpression Buildings_IH_Office2(
      y = Office2.Q_IH)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,230})));
  Modelica.Blocks.Sources.RealExpression Buildings_IH_Office1(
      y = Office1.Q_IH)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,210})));
  Modelica.Blocks.Sources.RealExpression Buildings_IH_Office5(
      y = Office5.Q_IH)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,190})));
  Modelica.Blocks.Sources.RealExpression Buildings_IH_Office3(
      y = Office3.Q_IH)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,170})));
  Modelica.Blocks.Sources.RealExpression Buildings_IH_Office4(
      y = Office4.Q_IH)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,150})));

public
  Modelica.Blocks.Continuous.Integrator Buildings_IC_Energy(
      k = 1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {750,40})));
protected
  Modelica.Blocks.Math.MultiSum Sum_Buildings_IC(
      nu = 5)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {710,40})));
  Modelica.Blocks.Sources.RealExpression Buildings_IC_Office2(
      y = Office2.Q_IC)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,90})));
  Modelica.Blocks.Sources.RealExpression Buildings_IC_Office1(
      y = Office1.Q_IC)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,70})));
  Modelica.Blocks.Sources.RealExpression Buildings_IC_Office5(
      y = Office5.Q_IC)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,50})));
  Modelica.Blocks.Sources.RealExpression Buildings_IC_Office3(
      y = Office3.Q_IC)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,30})));
  Modelica.Blocks.Sources.RealExpression Buildings_IC_Office4(
      y = Office4.Q_IC)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,10})));

public
  Modelica.Blocks.Continuous.Integrator Buildings_eleHP_heat_Energy(
      k = 1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {750,-100})));
protected
  Modelica.Blocks.Math.MultiSum Sum_Buildings_eleHP_heat(
      nu = 5)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {710,-100})));
  Modelica.Blocks.Sources.RealExpression Buildings_eleHP_heat_Office2(
      y = Office2.eleHP_heat)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,-50})));
  Modelica.Blocks.Sources.RealExpression Buildings_eleHP_heat_Office1(
      y = Office1.eleHP_heat)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,-70})));
  Modelica.Blocks.Sources.RealExpression Buildings_eleHP_heat_Office5(
      y = Office5.eleHP_heat)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,-90})));
  Modelica.Blocks.Sources.RealExpression Buildings_eleHP_heat_Office3(
      y = Office3.eleHP_heat)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,-110})));
  Modelica.Blocks.Sources.RealExpression Buildings_eleHP_heat_Office4(
      y = Office4.eleHP_heat)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,-130})));

public
  Modelica.Blocks.Continuous.Integrator Buildings_eleHP_cool_Energy(
      k = 1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {750,-240})));
protected
  Modelica.Blocks.Math.MultiSum Sum_Buildings_eleHP_cool(
      nu = 5)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {710,-240})));
  Modelica.Blocks.Sources.RealExpression Buildings_eleHP_cool_Office2(
      y = Office2.eleHP_cool)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,-190})));
  Modelica.Blocks.Sources.RealExpression Buildings_eleHP_cool_Office1(
      y = Office1.eleHP_cool)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,-210})));
  Modelica.Blocks.Sources.RealExpression Buildings_eleHP_cool_Office5(
      y = Office5.eleHP_cool)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,-230})));
  Modelica.Blocks.Sources.RealExpression Buildings_eleHP_cool_Office3(
      y = Office3.eleHP_cool)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,-250})));
  Modelica.Blocks.Sources.RealExpression Buildings_eleHP_cool_Office4(
      y = Office4.eleHP_cool)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,-270})));

public
  Modelica.Blocks.Continuous.Integrator DES_heat_Energy(
      k = 1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {750,-340})));
protected
  Modelica.Blocks.Math.MultiSum Sum_DES_heat(
      nu = 1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {710,-340})));
  Modelica.Blocks.Sources.RealExpression DES_heat_NewDistrictSystem(
      y = NewDistrictSystem.Q_H_flow)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,-330})));

public
  Modelica.Blocks.Continuous.Integrator DES_cool_Energy(
      k = 1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {750,-400})));
protected
  Modelica.Blocks.Math.MultiSum Sum_DES_cool(
      nu = 1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {710,-400})));
  Modelica.Blocks.Sources.RealExpression DES_cool_NewDistrictSystem(
      y = NewDistrictSystem.Q_C_flow)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,-390})));

public
  Modelica.Blocks.Continuous.Integrator HeatLoss_Energy(
      k = 1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {750,-590})));
protected
  Modelica.Blocks.Math.MultiSum Sum_HeatLoss(
      nu = 15)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {710,-590})));
  Modelica.Blocks.Sources.RealExpression HeatLoss_Pipe_Office2_Office1(
      y = Pipe_Office2_Office1.heatLoss)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,-440})));
  Modelica.Blocks.Sources.RealExpression HeatLoss_Pipe_Office2_Office5(
      y = Pipe_Office2_Office5.heatLoss)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,-460})));
  Modelica.Blocks.Sources.RealExpression HeatLoss_Pipe_Office2_Office3(
      y = Pipe_Office2_Office3.heatLoss)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,-480})));
  Modelica.Blocks.Sources.RealExpression HeatLoss_Pipe_Office2_Office4(
      y = Pipe_Office2_Office4.heatLoss)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,-500})));
  Modelica.Blocks.Sources.RealExpression HeatLoss_Pipe_Office2_NewDistrictSystem(
      y = Pipe_Office2_NewDistrictSystem.heatLoss)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,-520})));
  Modelica.Blocks.Sources.RealExpression HeatLoss_Pipe_Office1_Office5(
      y = Pipe_Office1_Office5.heatLoss)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,-540})));
  Modelica.Blocks.Sources.RealExpression HeatLoss_Pipe_Office1_Office3(
      y = Pipe_Office1_Office3.heatLoss)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,-560})));
  Modelica.Blocks.Sources.RealExpression HeatLoss_Pipe_Office1_Office4(
      y = Pipe_Office1_Office4.heatLoss)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,-580})));
  Modelica.Blocks.Sources.RealExpression HeatLoss_Pipe_Office1_NewDistrictSystem(
      y = Pipe_Office1_NewDistrictSystem.heatLoss)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,-600})));
  Modelica.Blocks.Sources.RealExpression HeatLoss_Pipe_Office5_Office3(
      y = Pipe_Office5_Office3.heatLoss)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,-620})));
  Modelica.Blocks.Sources.RealExpression HeatLoss_Pipe_Office5_Office4(
      y = Pipe_Office5_Office4.heatLoss)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,-640})));
  Modelica.Blocks.Sources.RealExpression HeatLoss_Pipe_Office5_NewDistrictSystem(
      y = Pipe_Office5_NewDistrictSystem.heatLoss)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,-660})));
  Modelica.Blocks.Sources.RealExpression HeatLoss_Pipe_Office3_Office4(
      y = Pipe_Office3_Office4.heatLoss)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,-680})));
  Modelica.Blocks.Sources.RealExpression HeatLoss_Pipe_Office3_NewDistrictSystem(
      y = Pipe_Office3_NewDistrictSystem.heatLoss)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,-700})));
  Modelica.Blocks.Sources.RealExpression HeatLoss_Pipe_Office4_NewDistrictSystem(
      y = Pipe_Office4_NewDistrictSystem.heatLoss)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {670,-720})));


  equation;
  connect(Office2.port_a, Office2_node_a.ports[1])
    annotation(Line(points={{-215,-90},{-215,-110}}, color={0, 127, 255}));
  connect(Office2.port_b, Office2_node_b.ports[1])
    annotation(Line(points={{-205,-90},{-205,-110}}, color={0, 127, 255}));
  connect(Office1.port_a, Office1_node_a.ports[1])
    annotation(Line(points={{-215,330},{-215,310}}, color={0, 127, 255}));
  connect(Office1.port_b, Office1_node_b.ports[1])
    annotation(Line(points={{-205,330},{-205,310}}, color={0, 127, 255}));
  connect(Office5.port_a, Office5_node_a.ports[1])
    annotation(Line(points={{205,190},{205,170}}, color={0, 127, 255}));
  connect(Office5.port_b, Office5_node_b.ports[1])
    annotation(Line(points={{215,190},{215,170}}, color={0, 127, 255}));
  connect(Office3.port_a, Office3_node_a.ports[1])
    annotation(Line(points={{-75,-370},{-75,-390}}, color={0, 127, 255}));
  connect(Office3.port_b, Office3_node_b.ports[1])
    annotation(Line(points={{-65,-370},{-65,-390}}, color={0, 127, 255}));
  connect(Office4.port_a, Office4_node_a.ports[1])
    annotation(Line(points={{205,-230},{205,-250}}, color={0, 127, 255}));
  connect(Office4.port_b, Office4_node_b.ports[1])
    annotation(Line(points={{215,-230},{215,-250}}, color={0, 127, 255}));
  connect(NewDistrictSystem.port_a, NewDistrictSystem_node_a.ports[1])
    annotation(Line(points={{345,470},{345,450}}, color={0, 127, 255}));
  connect(NewDistrictSystem.port_b, NewDistrictSystem_node_b.ports[1])
    annotation(Line(points={{355,470},{355,450}}, color={0, 127, 255}));
  connect(Office2_node_a.ports[2], Pipe_Office2_Office1.port_a_hot)
    annotation(Line(points={{-215,-110},{-215,-130},{-170,-130},{-170,-117},{-165,-117}}, color={0, 127, 255}));
  connect(Office2_node_b.ports[2], Pipe_Office2_Office1.port_a_cold)
    annotation(Line(points={{-205,-110},{-205,-130},{-170,-130},{-170,-122},{-165,-122}}, color={0, 127, 255}));
  connect(Pipe_Office2_Office1.port_b_hot, Office1_node_a.ports[2])
    annotation(Line(points={{-155,-118},{-140,-118},{-140,280},{-215,280},{-215,310}}, color={0, 127, 255}));
  connect(Pipe_Office2_Office1.port_b_cold, Office1_node_b.ports[2])
    annotation(Line(points={{-155,-122},{-140,-122},{-140,280},{-205,280},{-205,310}}, color={0, 127, 255}));
  connect(Office2_node_a.ports[3], Pipe_Office2_Office5.port_a_hot)
    annotation(Line(points={{-215,-110},{-215,-130},{-170,-130},{-170,-92},{-165,-92}}, color={0, 127, 255}));
  connect(Office2_node_b.ports[3], Pipe_Office2_Office5.port_a_cold)
    annotation(Line(points={{-205,-110},{-205,-130},{-170,-130},{-170,-97},{-165,-97}}, color={0, 127, 255}));
  connect(Pipe_Office2_Office5.port_b_hot, Office5_node_a.ports[2])
    annotation(Line(points={{-155,-93},{-140,-93},{-140,140},{205,140},{205,170}}, color={0, 127, 255}));
  connect(Pipe_Office2_Office5.port_b_cold, Office5_node_b.ports[2])
    annotation(Line(points={{-155,-97},{-140,-97},{-140,140},{215,140},{215,170}}, color={0, 127, 255}));
  connect(Office2_node_a.ports[4], Pipe_Office2_Office3.port_a_hot)
    annotation(Line(points={{-215,-110},{-215,-130},{-170,-130},{-170,-67},{-165,-67}}, color={0, 127, 255}));
  connect(Office2_node_b.ports[4], Pipe_Office2_Office3.port_a_cold)
    annotation(Line(points={{-205,-110},{-205,-130},{-170,-130},{-170,-72},{-165,-72}}, color={0, 127, 255}));
  connect(Pipe_Office2_Office3.port_b_hot, Office3_node_a.ports[2])
    annotation(Line(points={{-155,-68},{-140,-68},{-140,-420},{-75,-420},{-75,-390}}, color={0, 127, 255}));
  connect(Pipe_Office2_Office3.port_b_cold, Office3_node_b.ports[2])
    annotation(Line(points={{-155,-72},{-140,-72},{-140,-420},{-65,-420},{-65,-390}}, color={0, 127, 255}));
  connect(Office2_node_a.ports[5], Pipe_Office2_Office4.port_a_hot)
    annotation(Line(points={{-215,-110},{-215,-130},{-170,-130},{-170,-42},{-165,-42}}, color={0, 127, 255}));
  connect(Office2_node_b.ports[5], Pipe_Office2_Office4.port_a_cold)
    annotation(Line(points={{-205,-110},{-205,-130},{-170,-130},{-170,-47},{-165,-47}}, color={0, 127, 255}));
  connect(Pipe_Office2_Office4.port_b_hot, Office4_node_a.ports[2])
    annotation(Line(points={{-155,-43},{-140,-43},{-140,-280},{205,-280},{205,-250}}, color={0, 127, 255}));
  connect(Pipe_Office2_Office4.port_b_cold, Office4_node_b.ports[2])
    annotation(Line(points={{-155,-47},{-140,-47},{-140,-280},{215,-280},{215,-250}}, color={0, 127, 255}));
  connect(Office2_node_a.ports[6], Pipe_Office2_NewDistrictSystem.port_a_hot)
    annotation(Line(points={{-215,-110},{-215,-130},{-170,-130},{-170,-17},{-165,-17}}, color={0, 127, 255}));
  connect(Office2_node_b.ports[6], Pipe_Office2_NewDistrictSystem.port_a_cold)
    annotation(Line(points={{-205,-110},{-205,-130},{-170,-130},{-170,-22},{-165,-22}}, color={0, 127, 255}));
  connect(Pipe_Office2_NewDistrictSystem.port_b_hot, NewDistrictSystem_node_a.ports[2])
    annotation(Line(points={{-155,-18},{-140,-18},{-140,420},{345,420},{345,450}}, color={0, 127, 255}));
  connect(Pipe_Office2_NewDistrictSystem.port_b_cold, NewDistrictSystem_node_b.ports[2])
    annotation(Line(points={{-155,-22},{-140,-22},{-140,420},{355,420},{355,450}}, color={0, 127, 255}));
  connect(Office1_node_a.ports[3], Pipe_Office1_Office5.port_a_hot)
    annotation(Line(points={{-215,310},{-215,290},{-170,290},{-170,302},{-165,302}}, color={0, 127, 255}));
  connect(Office1_node_b.ports[3], Pipe_Office1_Office5.port_a_cold)
    annotation(Line(points={{-205,310},{-205,290},{-170,290},{-170,297},{-165,297}}, color={0, 127, 255}));
  connect(Pipe_Office1_Office5.port_b_hot, Office5_node_a.ports[3])
    annotation(Line(points={{-155,302},{-140,302},{-140,140},{205,140},{205,170}}, color={0, 127, 255}));
  connect(Pipe_Office1_Office5.port_b_cold, Office5_node_b.ports[3])
    annotation(Line(points={{-155,298},{-140,298},{-140,140},{215,140},{215,170}}, color={0, 127, 255}));
  connect(Office1_node_a.ports[4], Pipe_Office1_Office3.port_a_hot)
    annotation(Line(points={{-215,310},{-215,290},{-170,290},{-170,327},{-165,327}}, color={0, 127, 255}));
  connect(Office1_node_b.ports[4], Pipe_Office1_Office3.port_a_cold)
    annotation(Line(points={{-205,310},{-205,290},{-170,290},{-170,322},{-165,322}}, color={0, 127, 255}));
  connect(Pipe_Office1_Office3.port_b_hot, Office3_node_a.ports[3])
    annotation(Line(points={{-155,327},{-140,327},{-140,-420},{-75,-420},{-75,-390}}, color={0, 127, 255}));
  connect(Pipe_Office1_Office3.port_b_cold, Office3_node_b.ports[3])
    annotation(Line(points={{-155,323},{-140,323},{-140,-420},{-65,-420},{-65,-390}}, color={0, 127, 255}));
  connect(Office1_node_a.ports[5], Pipe_Office1_Office4.port_a_hot)
    annotation(Line(points={{-215,310},{-215,290},{-170,290},{-170,377},{-165,377}}, color={0, 127, 255}));
  connect(Office1_node_b.ports[5], Pipe_Office1_Office4.port_a_cold)
    annotation(Line(points={{-205,310},{-205,290},{-170,290},{-170,372},{-165,372}}, color={0, 127, 255}));
  connect(Pipe_Office1_Office4.port_b_hot, Office4_node_a.ports[3])
    annotation(Line(points={{-155,377},{-140,377},{-140,-280},{205,-280},{205,-250}}, color={0, 127, 255}));
  connect(Pipe_Office1_Office4.port_b_cold, Office4_node_b.ports[3])
    annotation(Line(points={{-155,373},{-140,373},{-140,-280},{215,-280},{215,-250}}, color={0, 127, 255}));
  connect(Office1_node_a.ports[6], Pipe_Office1_NewDistrictSystem.port_a_hot)
    annotation(Line(points={{-215,310},{-215,290},{-170,290},{-170,402},{-165,402}}, color={0, 127, 255}));
  connect(Office1_node_b.ports[6], Pipe_Office1_NewDistrictSystem.port_a_cold)
    annotation(Line(points={{-205,310},{-205,290},{-170,290},{-170,397},{-165,397}}, color={0, 127, 255}));
  connect(Pipe_Office1_NewDistrictSystem.port_b_hot, NewDistrictSystem_node_a.ports[3])
    annotation(Line(points={{-155,402},{-140,402},{-140,420},{345,420},{345,450}}, color={0, 127, 255}));
  connect(Pipe_Office1_NewDistrictSystem.port_b_cold, NewDistrictSystem_node_b.ports[3])
    annotation(Line(points={{-155,398},{-140,398},{-140,420},{355,420},{355,450}}, color={0, 127, 255}));
  connect(Office5_node_a.ports[4], Pipe_Office5_Office3.port_a_hot)
    annotation(Line(points={{205,170},{205,150},{250,150},{250,162},{255,162}}, color={0, 127, 255}));
  connect(Office5_node_b.ports[4], Pipe_Office5_Office3.port_a_cold)
    annotation(Line(points={{215,170},{215,150},{250,150},{250,157},{255,157}}, color={0, 127, 255}));
  connect(Pipe_Office5_Office3.port_b_hot, Office3_node_a.ports[4])
    annotation(Line(points={{265,162},{280,162},{280,-420},{-75,-420},{-75,-390}}, color={0, 127, 255}));
  connect(Pipe_Office5_Office3.port_b_cold, Office3_node_b.ports[4])
    annotation(Line(points={{265,158},{280,158},{280,-420},{-65,-420},{-65,-390}}, color={0, 127, 255}));
  connect(Office5_node_a.ports[5], Pipe_Office5_Office4.port_a_hot)
    annotation(Line(points={{205,170},{205,150},{250,150},{250,212},{255,212}}, color={0, 127, 255}));
  connect(Office5_node_b.ports[5], Pipe_Office5_Office4.port_a_cold)
    annotation(Line(points={{215,170},{215,150},{250,150},{250,207},{255,207}}, color={0, 127, 255}));
  connect(Pipe_Office5_Office4.port_b_hot, Office4_node_a.ports[4])
    annotation(Line(points={{265,212},{280,212},{280,-280},{205,-280},{205,-250}}, color={0, 127, 255}));
  connect(Pipe_Office5_Office4.port_b_cold, Office4_node_b.ports[4])
    annotation(Line(points={{265,208},{280,208},{280,-280},{215,-280},{215,-250}}, color={0, 127, 255}));
  connect(Office5_node_a.ports[6], Pipe_Office5_NewDistrictSystem.port_a_hot)
    annotation(Line(points={{205,170},{205,150},{250,150},{250,262},{255,262}}, color={0, 127, 255}));
  connect(Office5_node_b.ports[6], Pipe_Office5_NewDistrictSystem.port_a_cold)
    annotation(Line(points={{215,170},{215,150},{250,150},{250,257},{255,257}}, color={0, 127, 255}));
  connect(Pipe_Office5_NewDistrictSystem.port_b_hot, NewDistrictSystem_node_a.ports[4])
    annotation(Line(points={{265,262},{280,262},{280,420},{345,420},{345,450}}, color={0, 127, 255}));
  connect(Pipe_Office5_NewDistrictSystem.port_b_cold, NewDistrictSystem_node_b.ports[4])
    annotation(Line(points={{265,258},{280,258},{280,420},{355,420},{355,450}}, color={0, 127, 255}));
  connect(Office3_node_a.ports[5], Pipe_Office3_Office4.port_a_hot)
    annotation(Line(points={{-75,-390},{-75,-410},{-30,-410},{-30,-397},{-25,-397}}, color={0, 127, 255}));
  connect(Office3_node_b.ports[5], Pipe_Office3_Office4.port_a_cold)
    annotation(Line(points={{-65,-390},{-65,-410},{-30,-410},{-30,-402},{-25,-402}}, color={0, 127, 255}));
  connect(Pipe_Office3_Office4.port_b_hot, Office4_node_a.ports[5])
    annotation(Line(points={{-15,-398},{0,-398},{0,-280},{205,-280},{205,-250}}, color={0, 127, 255}));
  connect(Pipe_Office3_Office4.port_b_cold, Office4_node_b.ports[5])
    annotation(Line(points={{-15,-402},{0,-402},{0,-280},{215,-280},{215,-250}}, color={0, 127, 255}));
  connect(Office3_node_a.ports[6], Pipe_Office3_NewDistrictSystem.port_a_hot)
    annotation(Line(points={{-75,-390},{-75,-410},{-30,-410},{-30,-297},{-25,-297}}, color={0, 127, 255}));
  connect(Office3_node_b.ports[6], Pipe_Office3_NewDistrictSystem.port_a_cold)
    annotation(Line(points={{-65,-390},{-65,-410},{-30,-410},{-30,-302},{-25,-302}}, color={0, 127, 255}));
  connect(Pipe_Office3_NewDistrictSystem.port_b_hot, NewDistrictSystem_node_a.ports[5])
    annotation(Line(points={{-15,-298},{0,-298},{0,420},{345,420},{345,450}}, color={0, 127, 255}));
  connect(Pipe_Office3_NewDistrictSystem.port_b_cold, NewDistrictSystem_node_b.ports[5])
    annotation(Line(points={{-15,-302},{0,-302},{0,420},{355,420},{355,450}}, color={0, 127, 255}));
  connect(Office4_node_a.ports[6], Pipe_Office4_NewDistrictSystem.port_a_hot)
    annotation(Line(points={{205,-250},{205,-270},{250,-270},{250,-207},{255,-207}}, color={0, 127, 255}));
  connect(Office4_node_b.ports[6], Pipe_Office4_NewDistrictSystem.port_a_cold)
    annotation(Line(points={{215,-250},{215,-270},{250,-270},{250,-212},{255,-212}}, color={0, 127, 255}));
  connect(Pipe_Office4_NewDistrictSystem.port_b_hot, NewDistrictSystem_node_a.ports[6])
    annotation(Line(points={{265,-208},{280,-208},{280,420},{345,420},{345,450}}, color={0, 127, 255}));
  connect(Pipe_Office4_NewDistrictSystem.port_b_cold, NewDistrictSystem_node_b.ports[6])
    annotation(Line(points={{265,-212},{280,-212},{280,420},{355,420},{355,450}}, color={0, 127, 255}));
  connect(Sum_Buildings_PumpingElectricity.y, Buildings_PumpingElectricity_Energy.u)
    annotation(Line(points={{720,600},{740,600}}, color={0, 127, 255}));
  connect(Buildings_PumpingElectricity_Office2.y, Sum_Buildings_PumpingElectricity.u[1])
    annotation(Line(points={{680,650},{690,650},{690,600},{700,600}}, color={0, 127, 255}));
  connect(Buildings_PumpingElectricity_Office1.y, Sum_Buildings_PumpingElectricity.u[2])
    annotation(Line(points={{680,630},{690,630},{690,600},{700,600}}, color={0, 127, 255}));
  connect(Buildings_PumpingElectricity_Office5.y, Sum_Buildings_PumpingElectricity.u[3])
    annotation(Line(points={{680,610},{690,610},{690,600},{700,600}}, color={0, 127, 255}));
  connect(Buildings_PumpingElectricity_Office3.y, Sum_Buildings_PumpingElectricity.u[4])
    annotation(Line(points={{680,590},{690,590},{690,600},{700,600}}, color={0, 127, 255}));
  connect(Buildings_PumpingElectricity_Office4.y, Sum_Buildings_PumpingElectricity.u[5])
    annotation(Line(points={{680,570},{690,570},{690,600},{700,600}}, color={0, 127, 255}));
  connect(Sum_Buildings_DH.y, Buildings_DH_Energy.u)
    annotation(Line(points={{720,460},{740,460}}, color={0, 127, 255}));
  connect(Buildings_DH_Office2.y, Sum_Buildings_DH.u[1])
    annotation(Line(points={{680,510},{690,510},{690,460},{700,460}}, color={0, 127, 255}));
  connect(Buildings_DH_Office1.y, Sum_Buildings_DH.u[2])
    annotation(Line(points={{680,490},{690,490},{690,460},{700,460}}, color={0, 127, 255}));
  connect(Buildings_DH_Office5.y, Sum_Buildings_DH.u[3])
    annotation(Line(points={{680,470},{690,470},{690,460},{700,460}}, color={0, 127, 255}));
  connect(Buildings_DH_Office3.y, Sum_Buildings_DH.u[4])
    annotation(Line(points={{680,450},{690,450},{690,460},{700,460}}, color={0, 127, 255}));
  connect(Buildings_DH_Office4.y, Sum_Buildings_DH.u[5])
    annotation(Line(points={{680,430},{690,430},{690,460},{700,460}}, color={0, 127, 255}));
  connect(Sum_Buildings_DC.y, Buildings_DC_Energy.u)
    annotation(Line(points={{720,320},{740,320}}, color={0, 127, 255}));
  connect(Buildings_DC_Office2.y, Sum_Buildings_DC.u[1])
    annotation(Line(points={{680,370},{690,370},{690,320},{700,320}}, color={0, 127, 255}));
  connect(Buildings_DC_Office1.y, Sum_Buildings_DC.u[2])
    annotation(Line(points={{680,350},{690,350},{690,320},{700,320}}, color={0, 127, 255}));
  connect(Buildings_DC_Office5.y, Sum_Buildings_DC.u[3])
    annotation(Line(points={{680,330},{690,330},{690,320},{700,320}}, color={0, 127, 255}));
  connect(Buildings_DC_Office3.y, Sum_Buildings_DC.u[4])
    annotation(Line(points={{680,310},{690,310},{690,320},{700,320}}, color={0, 127, 255}));
  connect(Buildings_DC_Office4.y, Sum_Buildings_DC.u[5])
    annotation(Line(points={{680,290},{690,290},{690,320},{700,320}}, color={0, 127, 255}));
  connect(Sum_Buildings_IH.y, Buildings_IH_Energy.u)
    annotation(Line(points={{720,180},{740,180}}, color={0, 127, 255}));
  connect(Buildings_IH_Office2.y, Sum_Buildings_IH.u[1])
    annotation(Line(points={{680,230},{690,230},{690,180},{700,180}}, color={0, 127, 255}));
  connect(Buildings_IH_Office1.y, Sum_Buildings_IH.u[2])
    annotation(Line(points={{680,210},{690,210},{690,180},{700,180}}, color={0, 127, 255}));
  connect(Buildings_IH_Office5.y, Sum_Buildings_IH.u[3])
    annotation(Line(points={{680,190},{690,190},{690,180},{700,180}}, color={0, 127, 255}));
  connect(Buildings_IH_Office3.y, Sum_Buildings_IH.u[4])
    annotation(Line(points={{680,170},{690,170},{690,180},{700,180}}, color={0, 127, 255}));
  connect(Buildings_IH_Office4.y, Sum_Buildings_IH.u[5])
    annotation(Line(points={{680,150},{690,150},{690,180},{700,180}}, color={0, 127, 255}));
  connect(Sum_Buildings_IC.y, Buildings_IC_Energy.u)
    annotation(Line(points={{720,40},{740,40}}, color={0, 127, 255}));
  connect(Buildings_IC_Office2.y, Sum_Buildings_IC.u[1])
    annotation(Line(points={{680,90},{690,90},{690,40},{700,40}}, color={0, 127, 255}));
  connect(Buildings_IC_Office1.y, Sum_Buildings_IC.u[2])
    annotation(Line(points={{680,70},{690,70},{690,40},{700,40}}, color={0, 127, 255}));
  connect(Buildings_IC_Office5.y, Sum_Buildings_IC.u[3])
    annotation(Line(points={{680,50},{690,50},{690,40},{700,40}}, color={0, 127, 255}));
  connect(Buildings_IC_Office3.y, Sum_Buildings_IC.u[4])
    annotation(Line(points={{680,30},{690,30},{690,40},{700,40}}, color={0, 127, 255}));
  connect(Buildings_IC_Office4.y, Sum_Buildings_IC.u[5])
    annotation(Line(points={{680,10},{690,10},{690,40},{700,40}}, color={0, 127, 255}));
  connect(Sum_Buildings_eleHP_heat.y, Buildings_eleHP_heat_Energy.u)
    annotation(Line(points={{720,-100},{740,-100}}, color={0, 127, 255}));
  connect(Buildings_eleHP_heat_Office2.y, Sum_Buildings_eleHP_heat.u[1])
    annotation(Line(points={{680,-50},{690,-50},{690,-100},{700,-100}}, color={0, 127, 255}));
  connect(Buildings_eleHP_heat_Office1.y, Sum_Buildings_eleHP_heat.u[2])
    annotation(Line(points={{680,-70},{690,-70},{690,-100},{700,-100}}, color={0, 127, 255}));
  connect(Buildings_eleHP_heat_Office5.y, Sum_Buildings_eleHP_heat.u[3])
    annotation(Line(points={{680,-90},{690,-90},{690,-100},{700,-100}}, color={0, 127, 255}));
  connect(Buildings_eleHP_heat_Office3.y, Sum_Buildings_eleHP_heat.u[4])
    annotation(Line(points={{680,-110},{690,-110},{690,-100},{700,-100}}, color={0, 127, 255}));
  connect(Buildings_eleHP_heat_Office4.y, Sum_Buildings_eleHP_heat.u[5])
    annotation(Line(points={{680,-130},{690,-130},{690,-100},{700,-100}}, color={0, 127, 255}));
  connect(Sum_Buildings_eleHP_cool.y, Buildings_eleHP_cool_Energy.u)
    annotation(Line(points={{720,-240},{740,-240}}, color={0, 127, 255}));
  connect(Buildings_eleHP_cool_Office2.y, Sum_Buildings_eleHP_cool.u[1])
    annotation(Line(points={{680,-190},{690,-190},{690,-240},{700,-240}}, color={0, 127, 255}));
  connect(Buildings_eleHP_cool_Office1.y, Sum_Buildings_eleHP_cool.u[2])
    annotation(Line(points={{680,-210},{690,-210},{690,-240},{700,-240}}, color={0, 127, 255}));
  connect(Buildings_eleHP_cool_Office5.y, Sum_Buildings_eleHP_cool.u[3])
    annotation(Line(points={{680,-230},{690,-230},{690,-240},{700,-240}}, color={0, 127, 255}));
  connect(Buildings_eleHP_cool_Office3.y, Sum_Buildings_eleHP_cool.u[4])
    annotation(Line(points={{680,-250},{690,-250},{690,-240},{700,-240}}, color={0, 127, 255}));
  connect(Buildings_eleHP_cool_Office4.y, Sum_Buildings_eleHP_cool.u[5])
    annotation(Line(points={{680,-270},{690,-270},{690,-240},{700,-240}}, color={0, 127, 255}));
  connect(Sum_DES_heat.y, DES_heat_Energy.u)
    annotation(Line(points={{720,-340},{740,-340}}, color={0, 127, 255}));
  connect(DES_heat_NewDistrictSystem.y, Sum_DES_heat.u[1])
    annotation(Line(points={{680,-330},{690,-330},{690,-340},{700,-340}}, color={0, 127, 255}));
  connect(Sum_DES_cool.y, DES_cool_Energy.u)
    annotation(Line(points={{720,-400},{740,-400}}, color={0, 127, 255}));
  connect(DES_cool_NewDistrictSystem.y, Sum_DES_cool.u[1])
    annotation(Line(points={{680,-390},{690,-390},{690,-400},{700,-400}}, color={0, 127, 255}));
  connect(Sum_HeatLoss.y, HeatLoss_Energy.u)
    annotation(Line(points={{720,-590},{740,-590}}, color={0, 127, 255}));
  connect(HeatLoss_Pipe_Office2_Office1.y, Sum_HeatLoss.u[1])
    annotation(Line(points={{680,-440},{690,-440},{690,-590},{700,-590}}, color={0, 127, 255}));
  connect(HeatLoss_Pipe_Office2_Office5.y, Sum_HeatLoss.u[2])
    annotation(Line(points={{680,-460},{690,-460},{690,-590},{700,-590}}, color={0, 127, 255}));
  connect(HeatLoss_Pipe_Office2_Office3.y, Sum_HeatLoss.u[3])
    annotation(Line(points={{680,-480},{690,-480},{690,-590},{700,-590}}, color={0, 127, 255}));
  connect(HeatLoss_Pipe_Office2_Office4.y, Sum_HeatLoss.u[4])
    annotation(Line(points={{680,-500},{690,-500},{690,-590},{700,-590}}, color={0, 127, 255}));
  connect(HeatLoss_Pipe_Office2_NewDistrictSystem.y, Sum_HeatLoss.u[5])
    annotation(Line(points={{680,-520},{690,-520},{690,-590},{700,-590}}, color={0, 127, 255}));
  connect(HeatLoss_Pipe_Office1_Office5.y, Sum_HeatLoss.u[6])
    annotation(Line(points={{680,-540},{690,-540},{690,-590},{700,-590}}, color={0, 127, 255}));
  connect(HeatLoss_Pipe_Office1_Office3.y, Sum_HeatLoss.u[7])
    annotation(Line(points={{680,-560},{690,-560},{690,-590},{700,-590}}, color={0, 127, 255}));
  connect(HeatLoss_Pipe_Office1_Office4.y, Sum_HeatLoss.u[8])
    annotation(Line(points={{680,-580},{690,-580},{690,-590},{700,-590}}, color={0, 127, 255}));
  connect(HeatLoss_Pipe_Office1_NewDistrictSystem.y, Sum_HeatLoss.u[9])
    annotation(Line(points={{680,-600},{690,-600},{690,-590},{700,-590}}, color={0, 127, 255}));
  connect(HeatLoss_Pipe_Office5_Office3.y, Sum_HeatLoss.u[10])
    annotation(Line(points={{680,-620},{690,-620},{690,-590},{700,-590}}, color={0, 127, 255}));
  connect(HeatLoss_Pipe_Office5_Office4.y, Sum_HeatLoss.u[11])
    annotation(Line(points={{680,-640},{690,-640},{690,-590},{700,-590}}, color={0, 127, 255}));
  connect(HeatLoss_Pipe_Office5_NewDistrictSystem.y, Sum_HeatLoss.u[12])
    annotation(Line(points={{680,-660},{690,-660},{690,-590},{700,-590}}, color={0, 127, 255}));
  connect(HeatLoss_Pipe_Office3_Office4.y, Sum_HeatLoss.u[13])
    annotation(Line(points={{680,-680},{690,-680},{690,-590},{700,-590}}, color={0, 127, 255}));
  connect(HeatLoss_Pipe_Office3_NewDistrictSystem.y, Sum_HeatLoss.u[14])
    annotation(Line(points={{680,-700},{690,-700},{690,-590},{700,-590}}, color={0, 127, 255}));
  connect(HeatLoss_Pipe_Office4_NewDistrictSystem.y, Sum_HeatLoss.u[15])
    annotation(Line(points={{680,-720},{690,-720},{690,-590},{700,-590}}, color={0, 127, 255}));

  annotation (Diagram(coordinateSystem(extent={{-660,-660},{660,660}})), 
    Icon(coordinateSystem(extent={{-100,-120},{160,100}}))); 
end Test;
