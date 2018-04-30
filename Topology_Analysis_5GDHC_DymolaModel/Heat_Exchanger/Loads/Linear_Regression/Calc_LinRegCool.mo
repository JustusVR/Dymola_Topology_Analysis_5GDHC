within Topology_Analysis_5GDHC.Heat_Exchanger.Loads.Linear_Regression;
model Calc_LinRegCool

  Modelica.Blocks.Math.IntegerToReal dayInt
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  Modelica.Blocks.Math.IntegerToReal hourInt
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Math.IntegerToReal monthInt
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  Modelica.Blocks.Interfaces.IntegerInput day
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
  Modelica.Blocks.Interfaces.IntegerInput hour
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput tOutside
    annotation (Placement(transformation(extent={{-140,100},{-100,140}})));
  Modelica.Blocks.Interfaces.RealInput humOut
    "Set temperature for ambient loop"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.IntegerInput month
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
  Modelica.Blocks.Interfaces.RealInput mFlow
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
  Modelica.Blocks.Interfaces.RealInput tInlet
    annotation (Placement(transformation(extent={{-140,-140},{-100,-100}})));
  Modelica.Blocks.Interfaces.RealOutput coolDemand
    annotation (Placement(transformation(extent={{140,58},{182,100}})));
  Modelica.Blocks.Math.Gain power(k=-1)
    annotation (Placement(transformation(extent={{84,70},{104,90}})));
  Modelica.Blocks.Math.UnitConversions.To_degC tOutsideC
    annotation (Placement(transformation(extent={{-80,110},{-60,130}})));
  Modelica.Blocks.Math.UnitConversions.To_degC tInletC
    annotation (Placement(transformation(extent={{-80,-130},{-60,-110}})));
  Modelica.Blocks.Interfaces.RealOutput coolEleHP
    annotation (Placement(transformation(extent={{140,-100},{182,-58}})));
  Modelica.Blocks.Interfaces.RealOutput coolTOutlet
    annotation (Placement(transformation(extent={{140,-20},{182,22}})));
  Modelica.Blocks.Math.Feedback dayIntCorrected
    annotation (Placement(transformation(extent={{-50,50},{-30,30}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-54,54},{-44,64}})));
equation

  power.u =
    Topology_Analysis_5GDHC.Heat_Exchanger.Loads.Linear_Regression.ext_func_cool_Q(
    {1,dayIntCorrected.y,hourInt.y,monthInt.y,mFlow,tInletC.y,humOut,tOutsideC.y});
  coolEleHP =
    Topology_Analysis_5GDHC.Heat_Exchanger.Loads.Linear_Regression.ext_func_cool_P(
    {1,dayIntCorrected.y,hourInt.y,monthInt.y,mFlow,tInletC.y,humOut,tOutsideC.y});
  coolTOutlet =
    Topology_Analysis_5GDHC.Heat_Exchanger.Loads.Linear_Regression.ext_func_cool_T(
    {1,dayIntCorrected.y,hourInt.y,monthInt.y,mFlow,tInletC.y,humOut,tOutsideC.y});

  connect(hour, hourInt.u)
    annotation (Line(points={{-120,0},{-82,0}}, color={255,127,0}));
  connect(day, dayInt.u)
    annotation (Line(points={{-120,40},{-82,40}}, color={255,127,0}));
  connect(month, monthInt.u)
    annotation (Line(points={{-120,-40},{-82,-40}}, color={255,127,0}));
  connect(power.y, coolDemand) annotation (Line(points={{105,80},{132,80},{132,
          79},{161,79}}, color={0,0,127}));
  connect(tOutside, tOutsideC.u)
    annotation (Line(points={{-120,120},{-82,120}}, color={0,0,127}));
  connect(tInlet, tInletC.u)
    annotation (Line(points={{-120,-120},{-82,-120}}, color={0,0,127}));
  connect(dayInt.y,dayIntCorrected. u1)
    annotation (Line(points={{-59,40},{-48,40}}, color={0,0,127}));
  connect(const.y,dayIntCorrected. u2) annotation (Line(points={{-43.5,59},{-43.5,
          59.5},{-40,59.5},{-40,48}}, color={0,0,127}));
  annotation (experiment(StopTime=6),
              Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-160},
            {140,160}}), graphics={Rectangle(
          extent={{-100,160},{140,-160}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-160},{140,160}})));
end Calc_LinRegCool;
