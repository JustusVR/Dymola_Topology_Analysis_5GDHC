within Topology_Analysis_5GDHC.Compare_OpenStudio.Test;
model Test_Calc

replaceable package Medium =
      Buildings.Media.Water "Medium model for water";

  Modelica.Blocks.Sources.Constant const(k=0.07)
    annotation (Placement(transformation(extent={{-96,-6},{-76,14}})));
  Modelica.Blocks.Sources.Constant const1(k=293.15)
    annotation (Placement(transformation(extent={{-98,-36},{-78,-16}})));
  Modelica.Blocks.Math.Gain gain(k=-1/(4200*6))
    annotation (Placement(transformation(extent={{84,6},{104,26}})));
equation

public
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
      computeWetBulbTemperature=false, filNam=
        "modelica://Buildings/Resources/weatherdata/USA_CO_Golden-NREL.724666_TMY3dy.mos")
                                       "File reader that reads weather data"
    annotation (Placement(transformation(extent={{-74,92},{-54,112}})));
  Buildings.Utilities.Time.CalendarTime calTim(
    zerTim=Buildings.Utilities.Time.Types.ZeroTime.NY2018,
    year(start=2018),
    month(start=1))
    annotation (Placement(transformation(extent={{-86,52},{-66,72}})));
  Buildings.BoundaryConditions.WeatherData.Bus
                                     weaBus "Weather data bus"
     annotation (Placement(
        transformation(extent={{-40,60},{-24,76}}),     iconTransformation(
          extent={{-328,64},{-308,84}})));
  Heat_Exchanger.Loads.Linear_Regression.Calc_LinRegHeat Calc
    annotation (Placement(transformation(extent={{-18,-10},{38,42}})));
equation
  connect(weaDat.weaBus,weaBus)  annotation (Line(
      points={{-54,102},{-32,102},{-32,68}},
      color={255,204,51},
      thickness=0.5));
  connect(calTim.month, Calc.month) annotation (Line(points={{-65,62.6},{
          -54,62.6},{-54,9.5},{-22.6667,9.5}},
                                           color={255,127,0}));
  connect(calTim.hour, Calc.hour) annotation (Line(points={{-65,68.2},{-52,
          68.2},{-52,16},{-22.6667,16}}, color={255,127,0}));
  connect(calTim.weekDay, Calc.day) annotation (Line(points={{-65,57},{-48,
          57},{-48,22.5},{-22.6667,22.5}},
                                       color={255,127,0}));
  connect(weaBus.TDryBul, Calc.tOutside) annotation (Line(
      points={{-32,68},{-28,68},{-28,35.5},{-22.6667,35.5}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(weaBus.relHum, Calc.humOut) annotation (Line(
      points={{-32,68},{-32,29},{-22.6667,29}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(const.y, Calc.mFlow) annotation (Line(points={{-75,4},{-56,4},{
          -56,3},{-22.6667,3}},
                            color={0,0,127}));
  connect(const1.y, Calc.tInlet) annotation (Line(points={{-77,-26},{-46,
          -26},{-46,-3.5},{-22.6667,-3.5}},
                                       color={0,0,127}));
  connect(Calc.heatDemand, gain.u) annotation (Line(points={{42.9,28.8375},{
          65.45,28.8375},{65.45,16},{82,16}}, color={0,0,127}));
    annotation (choicesAllMatching = true,
    Diagram(coordinateSystem(extent={{-140,-100},{140,120}})),
    Icon(coordinateSystem(extent={{-140,-100},{140,120}})));
end Test_Calc;
