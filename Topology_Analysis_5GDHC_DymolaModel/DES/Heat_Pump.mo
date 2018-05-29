within Topology_Analysis_5GDHC_DymolaModel.DES;
model Heat_Pump
  extends Topology_Analysis_5GDHC_DymolaModel.DES.Base_Classes.DES_TA_Interface;

  Units.HeatingCoolingCarnot_T_TA                                             heatingCoolingCarnot_T(
      redeclare package Medium = Medium,
      m_flow_nominal=m_flow_nominal)
      annotation (
        Placement(transformation(
        extent={{60,-60},{-60,60}},
        rotation=0,
        origin={0,0})));
      //energyDynamics=energyDyn,

  Buildings.BoundaryConditions.WeatherData.Bus weaBus "Weather data bus"
     annotation (Placement(transformation(extent={{114,-46},{130,-30}}),iconTransformation(extent={{-328,64},{-308,84}})));

protected
  Modelica.Blocks.Sources.RealExpression const(y=0)
    annotation (Placement(transformation(extent={{178,88},{198,108}})));
  Modelica.Blocks.Sources.RealExpression T_set_heat(y=273.15 + Tset_hotPipe)
    annotation (Placement(transformation(extent={{140,38},{120,58}})));
  Modelica.Blocks.Sources.RealExpression T_Set_Cool(y=273.15 + Tset_hotPipe -
        dT_set)
    annotation (Placement(transformation(extent={{140,14},{120,34}})));
public
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
      computeWetBulbTemperature=false, filNam=weatherFile)
                                       "File reader that reads weather data"
    annotation (Placement(transformation(extent={{20,-20},{-20,20}},
        rotation=0,
        origin={180,-38})));

protected
  Modelica.Blocks.Math.Gain abs_CoolingEnergy(k=-1) annotation (Placement(
        transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={232,-200})));
equation
  connect(heatingCoolingCarnot_T.PComHea, P_ele_heat_input) annotation (Line(
        points={{-66,54},{-120,54},{-120,220},{290,220}},
                                                       color={0,0,127}));
  connect(heatingCoolingCarnot_T.PComCoo, P_ele_cool_input) annotation (Line(
        points={{-66,42},{-100,42},{-100,180},{290,180}},
                                                       color={0,0,127}));
  connect(const.y, P_gas_heat_input) annotation (Line(points={{199,98},{238,98},
          {238,120},{290,120}}, color={0,0,127}));
  connect(const.y, P_gas_cool_input) annotation (Line(points={{199,98},{239.5,98},
          {239.5,80},{290,80}}, color={0,0,127}));
  connect(heatingCoolingCarnot_T.QHea_flow, Q_H_flow) annotation (Line(points={{-66,30},
          {-120,30},{-120,-120},{290,-120}},      color={0,0,127}));
  connect(T_set_heat.y, heatingCoolingCarnot_T.TSetHea)
    annotation (Line(points={{119,48},{72,48}},   color={0,0,127}));
  connect(T_Set_Cool.y, heatingCoolingCarnot_T.TSetCoo)
    annotation (Line(points={{119,24},{72,24}},   color={0,0,127}));
  connect(weaDat.weaBus, weaBus) annotation (Line(
      points={{160,-38},{122,-38}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(weaBus.TDryBul, heatingCoolingCarnot_T.TSink) annotation (Line(
      points={{122,-38},{72,-38},{72,-36}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(heatingCoolingCarnot_T.port_a, port_b) annotation (Line(points={{60,0},
          {100,0},{100,-300},{80,-300}}, color={0,127,255}));
  connect(heatingCoolingCarnot_T.port_b, port_a) annotation (Line(points={{-60,
          0},{-100,0},{-100,-300},{-82,-300},{-82,-300},{-80,-300},{-80,-300}},
        color={0,127,255}));
  connect(heatingCoolingCarnot_T.QCoo_flow, abs_CoolingEnergy.u) annotation (
      Line(points={{-66,18},{-120,18},{-120,-200},{226,-200}}, color={0,0,127}));
  connect(abs_CoolingEnergy.y, Q_C_flow)
    annotation (Line(points={{237.5,-200},{290,-200}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-278,162},{278,-14}},
          lineColor={28,108,200},
          textStyle={TextStyle.Bold},
          textString="Air-Water 
HP")}),                                                          Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Heat_Pump;
