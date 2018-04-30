within Topology_Analysis_5GDHC_DymolaModel.Automated_5GDHC;
model Demo

  extends Modelica.Icons.Example;

  replaceable package Medium = Buildings.Media.Water;

  parameter Modelica.SIunits.MassFlowRate m_flow_nominal = 1;

  Dual_Pipe.Dual_Pipe dual_Pipe(
    redeclare package Medium = Medium,
    length=100,
    m_flow_nominal=1)
    annotation (Placement(transformation(extent={{-5,-5},{5,5}},
        rotation=0,
        origin={-30,132})));
  Dual_Pipe.Dual_Pipe dual_Pipe1(
    redeclare package Medium = Medium,
    length=100,
    m_flow_nominal=1)
    annotation (Placement(transformation(extent={{-5,-5},{5,5}},
        rotation=0,
        origin={-30,110})));

  Building.Automated_Model_Building.RFBuilding_individual building1(redeclare
      package Medium =                                                                         Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},rotation=0,origin={-100,100})));
  Buildings.Fluid.Delays.DelayFirstOrder del1_hot(
    nPorts=3,
    redeclare package Medium = Medium,
    m_flow_nominal=1) annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=0,
        origin={-105,63})));
  Buildings.Fluid.Delays.DelayFirstOrder del1_cold(
    nPorts=3,
    redeclare package Medium = Medium,
    m_flow_nominal=1)
                     annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=0,
        origin={-95,63})));

  DES.Ideal_Source.Heater_Chiller_automate heater_Chiller_automate(redeclare
      package Medium =                                                                        Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},rotation=0,origin={100,100})));
  Buildings.Fluid.Delays.DelayFirstOrder del_pla_hot(
    nPorts=2,
    redeclare package Medium = Medium,
    m_flow_nominal=1) annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=0,
        origin={95,63})));
  Buildings.Fluid.Delays.DelayFirstOrder del_pla_cold(
    nPorts=2,
    redeclare package Medium = Medium,
    m_flow_nominal=1)  annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=0,
        origin={105,63})));

  Building.Automated_Model_Building.RFBuilding_individual building2(redeclare
      package Medium =                                                                         Medium)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},rotation=0,origin={-100,-100})));
  Buildings.Fluid.Delays.DelayFirstOrder del2_hot(
    nPorts=2,
    redeclare package Medium = Medium,
    m_flow_nominal=1) annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=0,
        origin={-105,-137})));
  Buildings.Fluid.Delays.DelayFirstOrder del2_cold(
    nPorts=2,
    redeclare package Medium = Medium,
    m_flow_nominal=1) annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=0,
        origin={-95,-137})));

equation

  connect(del1_hot.ports[1], dual_Pipe.port_a_hot)
    annotation (Line(points={{-105.8,60},{-106,60},{-106,40},{-60,40},{-60,134.5},{-35.1,134.5}},
                                                                       color={0,127,255}));
  connect(del1_cold.ports[1], dual_Pipe.port_a_cold)
    annotation (Line(points={{-95.8,60},{-94,60},{-94,40},{-60,40},{-60,129},{-35,129}},
                                                                    color={0,127,255}));
  connect(building1.port_b, del1_cold.ports[2])
    annotation (Line(points={{-94.2857,80},{-94.2857,60},{-95,60}},   color={0,127,255}));
  connect(building1.port_a, del1_hot.ports[2]) annotation (Line(points={{
          -105.714,80},{-105.714,60},{-105,60}},                                                          color={0,127,255}));
  connect(heater_Chiller_automate.port_a, del_pla_hot.ports[1])
    annotation (Line(points={{97.1429,79.9333},{94,79.9333},{94,60},{94.4,60}},color={0,127,255}));
  connect(heater_Chiller_automate.port_b, del_pla_cold.ports[1])
    annotation (Line(points={{103.071,80},{104,80},{104,60},{104.4,60}},
                                                                       color={0,127,255}));
  connect(building2.port_a, del2_hot.ports[1])
    annotation (Line(points={{-105.714,-120},{-105.6,-120},{-105.6,-140}},
                                                                       color={0,127,255}));
  connect(building2.port_b, del2_cold.ports[1])
    annotation (Line(points={{-94.2857,-120},{-94.2857,-140},{-95.6,-140}},color={0,127,255}));
  connect(del1_hot.ports[3], dual_Pipe1.port_a_hot)
    annotation (Line(points={{-104.2,60},{-106,60},{-106,40},{-60,40},{-60,112.5},{-35.1,112.5}},
                                                                                    color={0,127,255}));
  connect(del1_cold.ports[3], dual_Pipe1.port_a_cold)
    annotation (Line(points={{-94.2,60},{-94,60},{-94,40},{-60,40},{-60,107},{-35,107}},
                                                                                color={0,127,255}));
  connect(dual_Pipe1.port_b_hot, del2_hot.ports[2])
    annotation (Line(points={{-25.1,112.5},{0,112.5},{0,-160},{-106,-160},{-106,-140},{-104.4,-140}},
                                                                        color={0,127,255}));
  connect(dual_Pipe1.port_b_cold, del2_cold.ports[2])
    annotation (Line(points={{-25.1,107},{0,107},{0,-160},{-96,-160},{-96,-140},{-94.4,-140}},
                                                                        color={0,127,255}));
  connect(dual_Pipe.port_b_cold, del_pla_cold.ports[2]) annotation (Line(points=
         {{-25.1,129},{-12,129},{-12,130},{0,130},{0,60},{105.6,60}}, color={0,
          127,255}));
  connect(dual_Pipe.port_b_hot, del_pla_hot.ports[2]) annotation (Line(points={
          {-25.1,134.5},{-12,134.5},{-12,134},{0,134},{0,60},{95.6,60}}, color=
          {0,127,255}));
  annotation (Diagram(coordinateSystem(extent={{-200,-200},{200,200}})), Icon(coordinateSystem(extent={{-100,-120},{160,100}})));
end Demo;
