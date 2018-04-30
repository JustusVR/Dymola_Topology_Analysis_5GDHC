within LinReg_District_Heating_Cooling;
package Automated_Building
  model Test1

  replaceable package Medium =
       Buildings.Media.Water "Medium model for water";


    Plant.Heater_Chiller_automate plant(
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
    Substation.RFBuilding_unidirectional Building6(
      redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{816,0},{872,60}})));
    Substation.RFBuilding_unidirectional Building7(
      redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{952,0},{1008,60}})));
    Substation.RFBuilding_unidirectional Building8(
      redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{1088,0},{1144,60}})));
  equation
    connect(plant.port_b, Building1.port_a)
      annotation (Line(points={{56,30},{76,30},{76,70},{116,70},{116,30},{136,30}}, color={0,127,255}));
    connect(Building1.port_b, plant.port_a)
      annotation (Line(points={{192,30},{212,30},{212,-10},{-20,-10},{-20,30},{0,30}}, color={0,127,255}));
    connect(plant.port_b, Building2.port_a)
      annotation (Line(points={{56,30},{76,30},{76,70},{252,70},{252,30},{272,30}}, color={0,127,255}));
    connect(Building2.port_b, plant.port_a)
      annotation (Line(points={{328,30},{348,30},{348,-10},{-20,-10},{-20,30},{0,30}}, color={0,127,255}));
    connect(plant.port_b, Building3.port_a)
      annotation (Line(points={{56,30},{76,30},{76,70},{388,70},{388,30},{408,30}}, color={0,127,255}));
    connect(Building3.port_b, plant.port_a)
      annotation (Line(points={{464,30},{484,30},{484,-10},{-20,-10},{-20,30},{0,30}}, color={0,127,255}));
    connect(plant.port_b, Building4.port_a)
      annotation (Line(points={{56,30},{76,30},{76,70},{524,70},{524,30},{544,30}}, color={0,127,255}));
    connect(Building4.port_b, plant.port_a)
      annotation (Line(points={{600,30},{620,30},{620,-10},{-20,-10},{-20,30},{0,30}}, color={0,127,255}));
    connect(plant.port_b, Building5.port_a)
      annotation (Line(points={{56,30},{76,30},{76,70},{660,70},{660,30},{680,30}}, color={0,127,255}));
    connect(Building5.port_b, plant.port_a)
      annotation (Line(points={{736,30},{756,30},{756,-10},{-20,-10},{-20,30},{0,30}}, color={0,127,255}));
    connect(plant.port_b, Building6.port_a)
      annotation (Line(points={{56,30},{76,30},{76,70},{796,70},{796,30},{816,30}}, color={0,127,255}));
    connect(Building6.port_b, plant.port_a)
      annotation (Line(points={{872,30},{892,30},{892,-10},{-20,-10},{-20,30},{0,30}}, color={0,127,255}));
    connect(plant.port_b, Building7.port_a)
      annotation (Line(points={{56,30},{76,30},{76,70},{932,70},{932,30},{952,30}}, color={0,127,255}));
    connect(Building7.port_b, plant.port_a)
      annotation (Line(points={{1008,30},{1028,30},{1028,-10},{-20,-10},{-20,30},{0,30}}, color={0,127,255}));
    connect(plant.port_b, Building8.port_a)
      annotation (Line(points={{56,30},{76,30},{76,70},{1068,70},{1068,30},{1088,30}}, color={0,127,255}));
    connect(Building8.port_b, plant.port_a)
      annotation (Line(points={{1144,30},{1164,30},{1164,-10},{-20,-10},{-20,30},{0,30}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Test1;
end Automated_Building;
