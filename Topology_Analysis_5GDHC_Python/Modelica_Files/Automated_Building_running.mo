within LinReg_District_Heating_Cooling;
package Automated_Building
  model Test1

  replaceable package Medium =
       Buildings.Media.Water "Medium model for water";


    Plant.Heater_Chiller plant(
      redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{0,0},{56,60}})));
    Substation.RFBuilding_unidirectional Building1(
      redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{136,0},{192,60}})));
    Substation.RFBuilding_unidirectional Building2(
      redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{272,0},{328,60}})));
    Substation.RFBuilding_unidirectional Building3(
      redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{408,0},{464,60}})));
    Substation.RFBuilding_unidirectional Building4(
      redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{544,0},{600,60}})));
    Substation.RFBuilding_unidirectional Building5(
      redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{680,0},{736,60}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=293)
      annotation (Placement(transformation(extent={{-32,80},{-12,100}})));
    Buildings.Fluid.Sources.Boundary_pT pSet1(
                                             redeclare package Medium = Medium,
        nPorts=1) "Model to set the reference pressure"
                                            annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          origin={-42,32})));
  equation
    connect(plant.port_b, Building1.port_a)
      annotation (Line(points={{55.6,32.3077},{76,32.3077},{76,70},{116,70},{
            116,30},{136,30}},                                                      color={0,127,255}));
    connect(Building1.port_b, plant.port_a)
      annotation (Line(points={{191.8,30},{212,30},{212,-10},{-20,-10},{-20,
            32.3077},{0.4,32.3077}},                                                   color={0,127,255}));
    connect(plant.port_b, Building2.port_a)
      annotation (Line(points={{55.6,32.3077},{76,32.3077},{76,70},{252,70},{
            252,30},{272,30}},                                                      color={0,127,255}));
    connect(Building2.port_b, plant.port_a)
      annotation (Line(points={{327.8,30},{348,30},{348,-10},{-20,-10},{-20,
            32.3077},{0.4,32.3077}},                                                   color={0,127,255}));
    connect(plant.port_b, Building3.port_a)
      annotation (Line(points={{55.6,32.3077},{76,32.3077},{76,70},{388,70},{
            388,30},{408,30}},                                                      color={0,127,255}));
    connect(Building3.port_b, plant.port_a)
      annotation (Line(points={{463.8,30},{484,30},{484,-10},{-20,-10},{-20,
            32.3077},{0.4,32.3077}},                                                   color={0,127,255}));
    connect(plant.port_b, Building4.port_a)
      annotation (Line(points={{55.6,32.3077},{76,32.3077},{76,70},{524,70},{
            524,30},{544,30}},                                                      color={0,127,255}));
    connect(Building4.port_b, plant.port_a)
      annotation (Line(points={{599.8,30},{620,30},{620,-10},{-20,-10},{-20,
            32.3077},{0.4,32.3077}},                                                   color={0,127,255}));
    connect(plant.port_b, Building5.port_a)
      annotation (Line(points={{55.6,32.3077},{76,32.3077},{76,70},{660,70},{
            660,30},{680,30}},                                                      color={0,127,255}));
    connect(Building5.port_b, plant.port_a)
      annotation (Line(points={{735.8,30},{756,30},{756,-10},{-20,-10},{-20,
            32.3077},{0.4,32.3077}},                                                   color={0,127,255}));
    connect(realExpression.y, plant.T_set) annotation (Line(points={{-11,90},{
            24.5,90},{24.5,64.6154},{24,64.6154}}, color={0,0,127}));
    connect(plant.port_a, pSet1.ports[1]) annotation (Line(points={{0.4,32.3077},
            {-30,32.3077},{-30,32},{-32,32}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Test1;
end Automated_Building;
