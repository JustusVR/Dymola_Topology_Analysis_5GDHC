within Topology_Analysis_5GDHC.Loads.Random_Forest;
model Calc_py

  Modelica.Blocks.Math.IntegerToReal dayInt
    annotation (Placement(transformation(extent={{-82,-50},{-62,-30}})));
  Modelica.Blocks.Math.IntegerToReal hourInt
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Math.IntegerToReal monthInt
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  Modelica.Blocks.Interfaces.IntegerInput weekday
    annotation (Placement(transformation(extent={{-142,-60},{-102,-20}})));
  Modelica.Blocks.Interfaces.IntegerInput hour
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput tOutside
    annotation (Placement(transformation(extent={{-140,100},{-100,140}})));
  Modelica.Blocks.Interfaces.RealInput humOut
    "Set temperature for ambient loop"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.IntegerInput month
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
  Modelica.Blocks.Interfaces.RealInput tInlet
    annotation (Placement(transformation(extent={{-140,-120},{-100,-80}})));
  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{140,-20},{182,22}})));
  Modelica.Blocks.Math.UnitConversions.To_degC tOutsideC
    annotation (Placement(transformation(extent={{-80,110},{-60,130}})));
  Modelica.Blocks.Math.UnitConversions.To_degC tInletC
    annotation (Placement(transformation(extent={{-80,-110},{-60,-90}})));
  Modelica.Blocks.Math.Feedback dayIntCorrected
    annotation (Placement(transformation(extent={{-52,-30},{-32,-50}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-56,-26},{-46,-16}})));
  Buildings.Utilities.IO.Python27.Real_Real pyt(
    nDblRea=1,
    nDblWri=8,
    samplePeriod(displayUnit="h") = 3600,
    functionName="run_model",
    moduleName="modelica_rf_models")
    annotation (Placement(transformation(extent={{58,-10},{78,10}})));
  Modelica.Blocks.Interfaces.RealInput season annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,180})));
  Modelica.Blocks.Interfaces.RealInput modelType annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={40,180})));
equation

  connect(hour, hourInt.u)
    annotation (Line(points={{-120,0},{-82,0}}, color={255,127,0}));
  connect(weekday, dayInt.u)
    annotation (Line(points={{-122,-40},{-84,-40}}, color={255,127,0}));
  connect(tOutside, tOutsideC.u)
    annotation (Line(points={{-120,120},{-82,120}}, color={0,0,127}));
  connect(tInlet, tInletC.u)
    annotation (Line(points={{-120,-100},{-82,-100}}, color={0,0,127}));
  connect(dayInt.y, dayIntCorrected.u1)
    annotation (Line(points={{-61,-40},{-50,-40}},
                                                 color={0,0,127}));
  connect(const.y, dayIntCorrected.u2) annotation (Line(points={{-45.5,-21},{
          -45.5,-22},{-42,-22},{-42,-32},{-42,-32},{-42,-32}},
                                      color={0,0,127}));
  connect(y, y) annotation (Line(points={{161,1},{161,1}}, color={0,0,127}));
  connect(monthInt.y, pyt.uR[3]) annotation (Line(points={{-59,40},{-20,40},{
          -20,-0.75},{56,-0.75}},    color={0,0,127}));
  connect(hourInt.y, pyt.uR[4]) annotation (Line(points={{-59,0},{-6,0},{-6,
          -0.25},{56,-0.25}},
                       color={0,0,127}));
  connect(dayIntCorrected.y, pyt.uR[5]) annotation (Line(points={{-33,-40},{-20,
          -40},{-20,0},{56,0},{56,0.25}},
                               color={0,0,127}));
  connect(tOutsideC.y, pyt.uR[6]) annotation (Line(points={{-59,120},{-20,120},
          {-20,0.75},{56,0.75}},
                       color={0,0,127}));
  connect(humOut, pyt.uR[7]) annotation (Line(points={{-120,80},{-20,80},{-20,0},
          {36,0},{36,1.25},{56,1.25}},
                       color={0,0,127}));
  connect(tInletC.y, pyt.uR[8]) annotation (Line(points={{-59,-100},{-20,-100},
          {-20,0},{56,0},{56,1.75}},
                                  color={0,0,127}));
  connect(modelType, pyt.uR[1]) annotation (Line(points={{40,180},{40,0},{54,0},
          {54,0},{56,0},{56,-2},{56,-1.75}}, color={0,0,127}));
  connect(season, pyt.uR[2]) annotation (Line(points={{0,180},{0,0},{56,0},{56,
          0},{56,-2},{56,-2},{56,-1.25}}, color={0,0,127}));
  connect(pyt.yR[1], y) annotation (Line(points={{79,0},{120,0},{120,1},{161,1}},
        color={0,0,127}));
  connect(month, monthInt.u)
    annotation (Line(points={{-120,40},{-82,40}}, color={255,127,0}));
  annotation (experiment(StopTime=6),
              Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-160},
            {140,160}}), graphics={Rectangle(
          extent={{-100,160},{140,-160}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-56,50},{102,-46}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textStyle={TextStyle.Bold},
          textString="ROM")}),                                   Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-160},{140,160}})));
end Calc_py;
