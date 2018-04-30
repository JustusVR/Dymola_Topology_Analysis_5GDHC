within Topology_Analysis_5GDHC_DymolaModel.Test_Models;
model Test_Building

replaceable package Medium =
      Buildings.Media.Water "Medium model for water";

public
  Buildings.Fluid.Sources.FixedBoundary sin(redeclare package Medium = Medium,
      nPorts=1) annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          origin={70,0})));
public
  Buildings.Fluid.Sources.FixedBoundary sin1(
                                            redeclare package Medium = Medium,
    use_T=false,
    nPorts=1)   annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          origin={-70,0})));
  Modelica.Blocks.Sources.Constant TSetHeat(k=273.15 + 20)
    annotation (Placement(transformation(extent={{280,492},{300,512}})));
  Modelica.Blocks.Sources.Constant TSetCool(k=273.15 + 16)
    annotation (Placement(transformation(extent={{280,460},{300,480}})));
  Dual_Pipe.Dual_Pipe dual_Pipe(
    length=100,
    m_flow_nominal=1,
    redeclare package Medium = Medium) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-2,16})));
  Building.Automated_Model_Building.Building_TA_LookUp Office2(redeclare
      package Medium = Medium, connected=false) annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-2,74})));
  Buildings.Fluid.Delays.DelayFirstOrder Office2_node_a(
      nPorts=2,
      redeclare package Medium = Medium,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-3,-3},{3,3}},rotation = 0, origin={-7,37})));
  Buildings.Fluid.Delays.DelayFirstOrder Office2_node_b(
      nPorts=2,
      redeclare package Medium = Medium,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-3,-3},{3,3}},rotation = 0, origin={3,37})));
equation

  connect(sin1.ports[1], dual_Pipe.port_a_hot)
    annotation (Line(points={{-60,0},{-7,0},{-7,5.8}}, color={0,127,255}));
  connect(sin.ports[1], dual_Pipe.port_a_cold)
    annotation (Line(points={{60,0},{4,0},{4,6}}, color={0,127,255}));
  connect(Office2.port_a,Office2_node_a. ports[1])
    annotation(Line(points={{-7.71429,54},{-7.71429,48},{-7.6,48},{-7.6,34}},
                                                     color={0, 127, 255}));
  connect(Office2.port_b,Office2_node_b. ports[1])
    annotation(Line(points={{3.71429,54},{3.71429,48},{4,48},{4,44},{2.4,44},{
          2.4,34}},                                  color={0, 127, 255}));
  connect(dual_Pipe.port_b_hot, Office2_node_a.ports[2]) annotation (Line(
        points={{-7,25.8},{-7,29.9},{-6.4,29.9},{-6.4,34}}, color={0,127,255}));
  connect(dual_Pipe.port_b_cold, Office2_node_b.ports[2]) annotation (Line(
        points={{4,25.8},{4,30},{4,34},{3.6,34}}, color={0,127,255}));
    annotation (choicesAllMatching = true,
    Diagram(coordinateSystem(extent={{-140,-100},{140,120}})),
    Icon(coordinateSystem(extent={{-140,-100},{140,120}})));
end Test_Building;
