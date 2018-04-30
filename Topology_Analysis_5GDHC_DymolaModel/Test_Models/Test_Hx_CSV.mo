within Topology_Analysis_5GDHC.Test_Models;
model Test_Hx_CSV

replaceable package Medium =
      Buildings.Media.Water "Medium model for water";

public
  Modelica.Blocks.Sources.CombiTimeTable LookUp_D_Load(
    tableOnFile=true,
    tableName="tab1",
    fileName=
        "/home/justus/Documents/Topology_Analysis_5GDHC/Resources/Loads/LookUp_Table/heating_ambient.mos")
                            annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={0,0})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=18,
    duration(displayUnit="d") = 8640000,
    offset=18)
    annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
  Buildings.Utilities.Time.ModelTime modTim
    annotation (Placement(transformation(extent={{-100,50},{-80,70}})));
  Modelica.Blocks.Tables.CombiTable2D combiTable2D(
    tableOnFile=true,
    fileName=
        "/home/justus/Documents/Topology_Analysis_5GDHC/Resources/Loads/LookUp_Table/tester.mos",

    tableName="tab1")
    annotation (Placement(transformation(extent={{-52,28},{-32,48}})));
equation

  connect(modTim.y, combiTable2D.u1) annotation (Line(points={{-79,60},{-68,60},
          {-68,44},{-54,44}}, color={0,0,127}));
  connect(ramp.y, combiTable2D.u2) annotation (Line(points={{-79,20},{-68,20},{
          -68,32},{-54,32}}, color={0,0,127}));
    annotation (choicesAllMatching = true,
    Diagram(coordinateSystem(extent={{-140,-100},{140,120}})),
    Icon(coordinateSystem(extent={{-140,-100},{140,120}})));
end Test_Hx_CSV;
