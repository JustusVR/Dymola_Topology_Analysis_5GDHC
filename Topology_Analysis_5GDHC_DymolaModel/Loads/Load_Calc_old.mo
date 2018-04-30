within Topology_Analysis_5GDHC.Loads;
model Load_Calc_old

  parameter String Load_FileName;

protected
  Modelica.Blocks.Sources.CombiTimeTable LookUp_D_Load(
    tableOnFile=true,
    tableName="tab1",
    fileName=Load_FileName) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-50,-20})));
public
  Modelica.Blocks.Logical.Switch switch_D_Load
    annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
protected
  Modelica.Blocks.Sources.RealExpression Constant(y=0) annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-50,-48})));
protected
  Modelica.Blocks.Sources.RealExpression LookUp_I_Load(y=50) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-50,20})));
public
  Modelica.Blocks.Logical.Switch switch_I_Load
    annotation (Placement(transformation(extent={{40,30},{60,50}})));
  Modelica.Blocks.Interfaces.RealOutput I_Load
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Interfaces.RealOutput D_Load
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
  Modelica.Blocks.Interfaces.BooleanInput u
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
protected
  Modelica.Blocks.Sources.RealExpression Constant1(
                                                  y=0) annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-50,60})));
equation
  connect(LookUp_I_Load.y, switch_I_Load.u3) annotation (Line(points={{-39,20},
          {0,20},{0,32},{38,32}}, color={0,0,127}));
  connect(switch_I_Load.y, I_Load)
    annotation (Line(points={{61,40},{110,40}}, color={0,0,127}));
  connect(switch_D_Load.y, D_Load)
    annotation (Line(points={{61,-40},{110,-40}}, color={0,0,127}));
  connect(u, switch_I_Load.u2) annotation (Line(points={{-120,0},{-80,0},{-80,
          40},{38,40}}, color={255,0,255}));
  connect(u, switch_D_Load.u2) annotation (Line(points={{-120,0},{-80,0},{-80,-40},
          {38,-40}}, color={255,0,255}));
  connect(LookUp_D_Load.y[1], switch_D_Load.u1) annotation (Line(points={{-39,
          -20},{-20,-20},{-20,-32},{38,-32}}, color={0,0,127}));
  connect(Constant.y, switch_D_Load.u3)
    annotation (Line(points={{-39,-48},{38,-48}}, color={0,0,127}));
  connect(Constant1.y, switch_I_Load.u1) annotation (Line(points={{-39,60},{0,
          60},{0,48},{38,48}}, color={0,0,127}));
  annotation (Icon(graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
                             Text(
          extent={{-74,46},{78,-54}},
          lineColor={28,108,200},
          textString="Load",
          textStyle={TextStyle.Bold})}));
end Load_Calc_old;
