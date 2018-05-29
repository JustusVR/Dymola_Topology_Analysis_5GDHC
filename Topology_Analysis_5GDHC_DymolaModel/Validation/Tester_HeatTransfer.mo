within Topology_Analysis_5GDHC_DymolaModel.Validation;
model Tester_HeatTransfer

  extends Modelica.Icons.Example;

replaceable package Medium =
      Buildings.Media.Water "Medium model for water";

  Modelica.Thermal.HeatTransfer.Components.ThermalConductor conPipWal(each G=
        15.885)
    "Thermal conductance through pipe wall"
    annotation (Placement(transformation(extent={{-18,-10},{-38,10}})));
  Modelica.Thermal.HeatTransfer.Components.Convection
                                             con
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={30,0})));
  Modelica.Blocks.Sources.Constant alphaPipe(k=700)
    "Outdoor coefficient of heat transfer for walls"
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},rotation=0,
    origin={-4,48})));
  Modelica.Thermal.HeatTransfer.Celsius.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{-76,-10},{-56,10}})));
protected
  Modelica.Blocks.Sources.RealExpression T_amb(y=60) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-100,0})));
public
  Modelica.Thermal.HeatTransfer.Celsius.PrescribedTemperature
    prescribedTemperature1
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));
protected
  Modelica.Blocks.Sources.RealExpression T_amb1(y=20) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,0})));
equation

  connect(alphaPipe.y, con.Gc)
    annotation (Line(points={{0.4,48},{30,48},{30,10}}, color={0,0,127}));
  connect(T_amb.y, prescribedTemperature.T)
    annotation (Line(points={{-89,0},{-78,0}}, color={0,0,127}));
  connect(T_amb1.y, prescribedTemperature1.T)
    annotation (Line(points={{99,0},{82,0}}, color={0,0,127}));
  connect(prescribedTemperature1.port, con.fluid)
    annotation (Line(points={{60,0},{40,0}}, color={191,0,0}));
  connect(conPipWal.port_a, con.solid)
    annotation (Line(points={{-18,0},{2,0},{2,0},{20,0}}, color={191,0,0}));
  connect(conPipWal.port_b, prescribedTemperature.port)
    annotation (Line(points={{-38,0},{-56,0}}, color={191,0,0}));
    annotation (choicesAllMatching = true,
    Diagram(coordinateSystem(extent={{-140,-100},{140,120}})),
    Icon(coordinateSystem(extent={{-140,-100},{140,120}})));
end Tester_HeatTransfer;
