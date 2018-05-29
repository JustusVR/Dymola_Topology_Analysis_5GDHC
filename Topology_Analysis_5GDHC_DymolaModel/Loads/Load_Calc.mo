within Topology_Analysis_5GDHC_DymolaModel.Loads;
model Load_Calc

  parameter String DQ_FileName;
  parameter String IQ_FileName;
  parameter String HP_ele_FileName;

public
  Modelica.Blocks.Tables.CombiTable2D    LookUp_DQ_Load(
    tableOnFile=true,
    fileName=DQ_FileName,
    tableName="data")     annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,-60})));
public
  Modelica.Blocks.Logical.Switch switch_D_Load
    annotation (Placement(transformation(extent={{60,-90},{80,-70}})));
protected
  Modelica.Blocks.Sources.RealExpression Constant_D_Load(y=0) annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-50,-88})));
public
  Modelica.Blocks.Logical.Switch switch_I_Load
    annotation (Placement(transformation(extent={{60,70},{80,90}})));
  Modelica.Blocks.Interfaces.RealOutput I_Load
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Modelica.Blocks.Interfaces.RealOutput D_Load
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,-90},{120,-70}})));
  Modelica.Blocks.Interfaces.BooleanInput u
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
protected
  Modelica.Blocks.Sources.RealExpression Constant_I_Load(y=0) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,88})));
protected
  Modelica.Blocks.Tables.CombiTable2D    LookUp_HP_ele(
    tableOnFile=true,
    fileName=HP_ele_FileName,
    tableName="data")       annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,-20})));
public
  Modelica.Blocks.Interfaces.RealOutput HP_ele
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
public
  Modelica.Blocks.Logical.Switch switch_HP_ele
    annotation (Placement(transformation(extent={{60,10},{80,-10}})));
protected
  Modelica.Blocks.Sources.RealExpression Constant_HP_ele(y=0)
   annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-30,20})));
public
  Buildings.Utilities.Time.ModelTime modTim annotation (Placement(
        transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={-60,-40})));
  Modelica.Blocks.Interfaces.RealInput T_Inlet
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
public
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin annotation (
      Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={-88,-60})));
  Modelica.Blocks.Tables.CombiTable1D LookUp_IQ_Load(tableOnFile=true,
      tableName="data",
    fileName=IQ_FileName)
    annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
equation
  connect(switch_I_Load.y, I_Load)
    annotation (Line(points={{81,80},{110,80}}, color={0,0,127}));
  connect(switch_D_Load.y, D_Load)
    annotation (Line(points={{81,-80},{110,-80}}, color={0,0,127}));
  connect(u, switch_I_Load.u2) annotation (Line(points={{-120,0},{-80,0},{-80,
          80},{58,80}}, color={255,0,255}));
  connect(u, switch_D_Load.u2) annotation (Line(points={{-120,0},{-80,0},{-80,
          -80},{58,-80}},
                     color={255,0,255}));
  connect(Constant_D_Load.y, switch_D_Load.u3)
    annotation (Line(points={{-39,-88},{58,-88}}, color={0,0,127}));
  connect(Constant_I_Load.y, switch_I_Load.u1)
    annotation (Line(points={{-19,88},{58,88}}, color={0,0,127}));
  connect(u, switch_HP_ele.u2)
    annotation (Line(points={{-120,0},{58,0}}, color={255,0,255}));
  connect(switch_HP_ele.y, HP_ele)
    annotation (Line(points={{81,0},{110,0}}, color={0,0,127}));
  connect(Constant_HP_ele.y, switch_HP_ele.u3) annotation (Line(points={{-19,20},
          {20,20},{20,8},{58,8}},   color={0,0,127}));
  connect(D_Load, D_Load)
    annotation (Line(points={{110,-80},{110,-80}}, color={0,0,127}));
  connect(modTim.y, LookUp_HP_ele.u1) annotation (Line(points={{-54.5,-40},{-48,
          -40},{-48,-14},{-42,-14}},
                                color={0,0,127}));
  connect(modTim.y, LookUp_DQ_Load.u1) annotation (Line(points={{-54.5,-40},{-48,
          -40},{-48,-54},{-42,-54}},
                                color={0,0,127}));
  connect(LookUp_HP_ele.y, switch_HP_ele.u1) annotation (Line(points={{-19,-20},
          {0,-20},{0,-8},{58,-8}}, color={0,0,127}));
  connect(LookUp_DQ_Load.y, switch_D_Load.u1) annotation (Line(points={{-19,-60},
          {0,-60},{0,-72},{58,-72}}, color={0,0,127}));
  connect(T_Inlet, fromKelvin.Kelvin)
    annotation (Line(points={{-120,-60},{-94,-60}}, color={0,0,127}));
  connect(fromKelvin.Celsius, LookUp_HP_ele.u2) annotation (Line(points={{-82.5,
          -60},{-72,-60},{-72,-26},{-42,-26}}, color={0,0,127}));
  connect(fromKelvin.Celsius, LookUp_DQ_Load.u2) annotation (Line(points={{
          -82.5,-60},{-72,-60},{-72,-66},{-42,-66}}, color={0,0,127}));
  connect(modTim.y, LookUp_IQ_Load.u[1]) annotation (Line(points={{-54.5,-40},{-48,
          -40},{-48,60},{-42,60}}, color={0,0,127}));
  connect(LookUp_IQ_Load.y[1], switch_I_Load.u3) annotation (Line(points={{-19,60},
          {0,60},{0,72},{58,72}}, color={0,0,127}));
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
end Load_Calc;
