within Topology_Analysis_5GDHC.Heat_Exchanger.Loads.Random_Forest;
model Calc_RFHeat_py

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
  Modelica.Blocks.Interfaces.RealOutput heatDemand
    annotation (Placement(transformation(extent={{140,-22},{182,20}})));
  Modelica.Blocks.Math.Gain power(k=-1)
    annotation (Placement(transformation(extent={{88,-10},{108,10}})));
  Modelica.Blocks.Math.UnitConversions.To_degC tOutsideC
    annotation (Placement(transformation(extent={{-80,110},{-60,130}})));
  Modelica.Blocks.Math.UnitConversions.To_degC tInletC
    annotation (Placement(transformation(extent={{-80,-130},{-60,-110}})));
  Modelica.Blocks.Math.Feedback dayIntCorrected
    annotation (Placement(transformation(extent={{-50,50},{-30,30}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-54,54},{-44,64}})));
  Buildings.Utilities.IO.Python27.Real_Real pyt(
    nDblRea=1,
    nDblWri=8,
    moduleName="modelica_rf_models",
    functionName="run_model",
    samplePeriod(displayUnit="h") = 3600)
    annotation (Placement(transformation(extent={{38,-10},{58,10}})));
  Modelica.Blocks.Sources.Constant modelType(k=1)
    annotation (Placement(transformation(extent={{-10,136},{0,146}})));
  Modelica.Blocks.Sources.Constant season(k=1)
    annotation (Placement(transformation(extent={{-10,116},{0,126}})));
equation

  connect(hour, hourInt.u)
    annotation (Line(points={{-120,0},{-82,0}}, color={255,127,0}));
  connect(day, dayInt.u)
    annotation (Line(points={{-120,40},{-82,40}}, color={255,127,0}));
  connect(month, monthInt.u)
    annotation (Line(points={{-120,-40},{-82,-40}}, color={255,127,0}));
  connect(power.y, heatDemand) annotation (Line(points={{109,0},{132,0},{132,-1},
          {161,-1}},     color={0,0,127}));
  connect(tOutside, tOutsideC.u)
    annotation (Line(points={{-120,120},{-82,120}}, color={0,0,127}));
  connect(tInlet, tInletC.u)
    annotation (Line(points={{-120,-120},{-82,-120}}, color={0,0,127}));
  connect(dayInt.y, dayIntCorrected.u1)
    annotation (Line(points={{-59,40},{-48,40}}, color={0,0,127}));
  connect(const.y, dayIntCorrected.u2) annotation (Line(points={{-43.5,59},{-43.5,
          59.5},{-40,59.5},{-40,48}}, color={0,0,127}));
  connect(heatDemand, heatDemand) annotation (Line(points={{161,-1},{153.5,-1},{
          153.5,-1},{161,-1}}, color={0,0,127}));
  connect(modelType.y, pyt.uR[1]) annotation (Line(points={{0.5,141},{0.5,140},
          {20,140},{20,0},{36,0},{36,-1.75}},
                                 color={0,0,127}));
  connect(season.y, pyt.uR[2]) annotation (Line(points={{0.5,121},{0.5,120},{
          20,120},{20,0},{36,0},{36,-1.25}},
                                 color={0,0,127}));
  connect(monthInt.y, pyt.uR[3]) annotation (Line(points={{-59,-40},{-20.5,
          -40},{-20.5,-0.75},{36,-0.75}},
                                     color={0,0,127}));
  connect(hourInt.y, pyt.uR[4]) annotation (Line(points={{-59,0},{-6,0},{-6,
          -0.25},{36,-0.25}},
                       color={0,0,127}));
  connect(dayIntCorrected.y, pyt.uR[5]) annotation (Line(points={{-31,40},{
          -20,40},{-20,0},{36,0},{36,0.25}},
                               color={0,0,127}));
  connect(tOutsideC.y, pyt.uR[6]) annotation (Line(points={{-59,120},{-20,120},
          {-20,0.75},{36,0.75}},
                       color={0,0,127}));
  connect(humOut, pyt.uR[7]) annotation (Line(points={{-120,80},{-20,80},{-20,
          0},{36,0},{36,2},{36,2},{36,2},{36,1.25}},
                       color={0,0,127}));
  connect(tInletC.y, pyt.uR[8]) annotation (Line(points={{-59,-120},{-20,-120},
          {-20,-14},{-20,-14},{-20,0},{36,0},{36,1.75}},
                                  color={0,0,127}));
  connect(pyt.yR[1], power.u)
    annotation (Line(points={{59,0},{86,0}},                 color={0,0,127}));
  annotation (experiment(StopTime=6),
              Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-160},
            {140,160}}), graphics={Rectangle(
          extent={{-100,160},{140,-160}},
          lineColor={28,108,200},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-160},{140,160}})));
end Calc_RFHeat_py;
