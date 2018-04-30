within Topology_Analysis_5GDHC.Compare_OpenStudio.Test;
model Test_Hx_CSV

replaceable package Medium =
      Buildings.Media.Water "Medium model for water";

public
  Buildings.Fluid.Sources.FixedBoundary sin(redeclare package Medium = Medium,
      nPorts=1) annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          origin={110,0})));
public
  Buildings.Fluid.Sources.MassFlowSource_T sou(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1)      "Mass flow source"
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Modelica.Blocks.Sources.Constant const1(k=293.15)
    annotation (Placement(transformation(extent={{-136,-30},{-116,-10}})));
  Modelica.Blocks.Math.Gain gain(k=1/(4187*6))
    annotation (Placement(transformation(extent={{-38,-44},{-58,-24}})));
  Buildings.Fluid.HeatExchangers.HeaterCooler_u hea(
    m_flow_nominal=1,
    dp_nominal=10,
    Q_flow_nominal=1000,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-6,-10},{14,10}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
    tableOnFile=true,
    tableName="tab1",
    fileName=
        "/home/justus/Desktop/LinReg_District_Heating_Cooling/loads/heating_ambient.mos")
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Modelica.Blocks.Math.Gain gain1(k=1)
    annotation (Placement(transformation(extent={{-30,24},{-18,36}})));
equation

  connect(gain.y, sou.m_flow_in) annotation (Line(points={{-59,-34},{-72,-34},{
          -72,32},{-108,32},{-108,8},{-100,8}}, color={0,0,127}));
  connect(const1.y, sou.T_in) annotation (Line(points={{-115,-20},{-110,-20},{
          -110,4},{-102,4}}, color={0,0,127}));
  connect(sou.ports[1], hea.port_a)
    annotation (Line(points={{-80,0},{-6,0}}, color={0,127,255}));
  connect(hea.port_b, sin.ports[1])
    annotation (Line(points={{14,0},{100,0}}, color={0,127,255}));
  connect(hea.Q_flow, gain.u) annotation (Line(points={{15,6},{36,6},{36,-34},
          {-36,-34}}, color={0,0,127}));
  connect(combiTimeTable.y[1], gain1.u)
    annotation (Line(points={{-39,30},{-31.2,30}}, color={0,0,127}));
  connect(gain1.y, hea.u) annotation (Line(points={{-17.4,30},{-10,30},{-10,6},
          {-8,6}}, color={0,0,127}));
    annotation (choicesAllMatching = true,
    Diagram(coordinateSystem(extent={{-140,-100},{140,120}})),
    Icon(coordinateSystem(extent={{-140,-100},{140,120}})));
end Test_Hx_CSV;
