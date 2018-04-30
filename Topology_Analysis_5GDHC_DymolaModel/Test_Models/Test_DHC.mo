within Topology_Analysis_5GDHC_DymolaModel.Test_Models;
model Test_DHC

replaceable package Medium =
      Buildings.Media.Water "Medium model for water";

  Building.Automated_Model_Building.Building_bidirectional Office2(
      redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{-20,-20},{20,20}},rotation = 0, origin={-100,40})));
  Buildings.Fluid.Delays.DelayFirstOrder Office2_node_a(
      nPorts=3,
      redeclare package Medium = Medium,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-3,-3},{3,3}},rotation = 0, origin={-105,3})));
  Buildings.Fluid.Delays.DelayFirstOrder Office2_node_b(
      nPorts=3,
      redeclare package Medium = Medium,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-3,-3},{3,3}},rotation = 0, origin={-95,3})));
  Building.Automated_Model_Building.Building_bidirectional Office1(
      redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{-20,-20},{20,20}},rotation = 0, origin={0,40})));
  Buildings.Fluid.Delays.DelayFirstOrder Office2_node_a1(
      nPorts=3,
      redeclare package Medium = Medium,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-3,-3},{3,3}},rotation = 0, origin={-5,3})));
  Buildings.Fluid.Delays.DelayFirstOrder Office2_node_b1(
      nPorts=3,
      redeclare package Medium = Medium,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-3,-3},{3,3}},rotation = 0, origin={5,3})));
  Dual_Pipe.Dual_Pipe dual_Pipe(
    redeclare package Medium = Medium,
    length=100,
    m_flow_nominal=1,
    active=true,
    diameter=0.5)
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Dual_Pipe.Dual_Pipe dual_Pipe1(
    redeclare package Medium = Medium,
    length=100,
    m_flow_nominal=1,
    diameter=0.5)
    annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
  DES.Ideal_T_JVR                         NewDistrictSystem(
      redeclare package Medium = Medium, m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-20,-20},{20,20}},rotation = 0, origin={100,40})));
  Buildings.Fluid.Delays.DelayFirstOrder NewDistrictSystem_node_a(
      nPorts=3,
      redeclare package Medium = Medium,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-3,-3},{3,3}},rotation = 0, origin={95,3})));
  Buildings.Fluid.Delays.DelayFirstOrder NewDistrictSystem_node_b(
      nPorts=3,
      redeclare package Medium = Medium,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-3,-3},{3,3}},rotation = 0, origin={105,3})));
  Dual_Pipe.Dual_Pipe dual_Pipe2(
    redeclare package Medium = Medium,
    length=100,
    m_flow_nominal=1,
    diameter=0.5)
    annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
equation

  connect(Office2.port_a,Office2_node_a. ports[1])
    annotation(Line(points={{-105.714,20},{-105.714,14},{-105.8,14},{-105.8,0}},
                                                     color={0, 127, 255}));
  connect(Office2.port_b,Office2_node_b. ports[1])
    annotation(Line(points={{-94.2857,20},{-94.2857,14},{-94,14},{-94,10},{
          -95.8,10},{-95.8,0}},                      color={0, 127, 255}));
  connect(Office1.port_a, Office2_node_a1.ports[1]) annotation (Line(points={{
          -5.71429,20},{-5.71429,14},{-5.8,14},{-5.8,0}}, color={0,127,255}));
  connect(Office1.port_b, Office2_node_b1.ports[1]) annotation (Line(points={{
          5.71429,20},{5.71429,14},{6,14},{6,10},{4.2,10},{4.2,0}}, color={0,
          127,255}));
  connect(Office2_node_a.ports[2], dual_Pipe.port_a_hot) annotation (Line(
        points={{-105,0},{-106,0},{-106,-25},{-60.2,-25}}, color={0,127,255}));
  connect(Office2_node_b.ports[2], dual_Pipe.port_a_cold) annotation (Line(
        points={{-95,0},{-96,0},{-96,-34},{-60,-34},{-60,-36}}, color={0,127,
          255}));
  connect(Office2_node_a.ports[3], dual_Pipe1.port_a_hot) annotation (Line(
        points={{-104.2,0},{-104.2,-65},{-60.2,-65}}, color={0,127,255}));
  connect(Office2_node_b.ports[3], dual_Pipe1.port_a_cold) annotation (Line(
        points={{-94.2,0},{-94,0},{-94,-76},{-60,-76}}, color={0,127,255}));
  connect(dual_Pipe.port_b_hot, Office2_node_a1.ports[2]) annotation (Line(
        points={{-40.2,-25},{-5,-25},{-5,2.22045e-16}}, color={0,127,255}));
  connect(dual_Pipe.port_b_cold, Office2_node_b1.ports[2])
    annotation (Line(points={{-40.2,-36},{5,-36},{5,0}}, color={0,127,255}));
  connect(NewDistrictSystem.port_a,NewDistrictSystem_node_a. ports[1])
    annotation(Line(points={{94.2857,20},{94.2857,16},{94.2,16},{94.2,0}},
                                                  color={0, 127, 255}));
  connect(NewDistrictSystem.port_b,NewDistrictSystem_node_b. ports[1])
    annotation(Line(points={{105.714,20},{105.714,16},{106,16},{106,10},{104.2,
          10},{104.2,0}},                         color={0, 127, 255}));
  connect(dual_Pipe1.port_b_hot, NewDistrictSystem_node_a.ports[2])
    annotation (Line(points={{-40.2,-65},{95,-65},{95,0}}, color={0,127,255}));
  connect(dual_Pipe1.port_b_cold, NewDistrictSystem_node_b.ports[2])
    annotation (Line(points={{-40.2,-76},{105,-76},{105,0}}, color={0,127,255}));
  connect(Office2_node_a1.ports[3], dual_Pipe2.port_a_hot) annotation (Line(
        points={{-4.2,0},{-6,0},{-6,-25},{39.8,-25}}, color={0,127,255}));
  connect(Office2_node_b1.ports[3], dual_Pipe2.port_a_cold) annotation (Line(
        points={{5.8,0},{6,0},{6,-36},{40,-36}}, color={0,127,255}));
  connect(dual_Pipe2.port_b_hot, NewDistrictSystem_node_a.ports[3]) annotation (
     Line(points={{59.8,-25},{95.8,-25},{95.8,0}}, color={0,127,255}));
  connect(dual_Pipe2.port_b_cold, NewDistrictSystem_node_b.ports[3])
    annotation (Line(points={{59.8,-36},{105.8,-36},{105.8,0}}, color={0,127,
          255}));
    annotation (choicesAllMatching = true,
    Diagram(coordinateSystem(extent={{-140,-100},{140,120}})),
    Icon(coordinateSystem(extent={{-140,-100},{140,120}})));
end Test_DHC;
