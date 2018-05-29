within Topology_Analysis_5GDHC_DymolaModel.Validation;
model Temperature_Degradation

  extends Modelica.Icons.Example;

  replaceable package Medium = Buildings.Media.Water;
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal_district = 0.7252 " nominal mass flow rate of the whole district ";
  parameter Boolean dynamics = true;
  final parameter Modelica.Fluid.Types.Dynamics energyDyn = if dynamics then Modelica.Fluid.Types.Dynamics.DynamicFreeInitial else Modelica.Fluid.Types.Dynamics.SteadyState;
  final parameter Boolean useFilter = dynamics;


public
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_heat(
    redeclare package Medium = Medium,
    inputType=Buildings.Fluid.Types.InputType.Continuous,
    energyDynamics=energyDyn,
    use_inputFilter=false,
    show_T=true,
    redeclare
      Buildings.Fluid.Movers.Data.Pumps.Wilo.CronolineIL80slash220dash4slash4
      per,
    addPowerToMedium=false,
    m_flow_nominal=m_flow_nominal_district)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},rotation=0,origin={-60,40})));
  Buildings.Fluid.HeatExchangers.Heater_T hea(dp_nominal(displayUnit="MPa") = 50000,
      m_flow_nominal=m_flow_nominal_district,
    redeclare package Medium = Medium,
    show_T=true)                              annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-120,0})));



  Modelica.Blocks.Sources.CombiTimeTable Data_TM20(
    tableOnFile=true,
    tableName="data",
    fileName=
        "/home/justus/Documents/Topology_Analysis_5GDHC_DymolaModel/Resources/Validation/Temperature_Degradation_Test1/TEST1_TM20.mos",
    timeScale(displayUnit="s") = 1)
    annotation (Placement(transformation(extent={{-180,-40},{-160,-20}})));
  Modelica.Blocks.Sources.CombiTimeTable Data_FM01(
    tableOnFile=true,
    tableName="data",
    fileName=
        "/home/justus/Documents/Topology_Analysis_5GDHC_DymolaModel/Resources/Validation/Temperature_Degradation_Test1/TEST1_FM01.mos",
    timeScale(displayUnit="s") = 1)
    annotation (Placement(transformation(extent={{-120,80},{-100,100}})));
  Modelica.Blocks.Sources.CombiTimeTable Data_TM02(
    tableOnFile=true,
    tableName="data",
    timeScale(displayUnit="s") = 1,
    fileName="/home/justus/Documents/Topology_Analysis_5GDHC_DymolaModel/Resources/Validation/Temperature_Degradation_Test1/TEST1_TM02.mos")
    annotation (Placement(transformation(extent={{180,-20},{160,0}})));
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin
    annotation (Placement(
        transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={-148,-30})));
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin1
      annotation (Placement(
        transformation(
        extent={{5,-5},{-5,5}},
        rotation=0,
        origin={150,-10})));
protected
  Buildings.Fluid.Sources.FixedBoundary ref(
    redeclare package Medium = Medium,
    use_T=false,
    nPorts=1) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          origin={-170,-60})));
public
  Modelica.Blocks.Sources.CombiTimeTable Data_TM01(
    tableOnFile=true,
    tableName="data",
    fileName=
        "/home/justus/Documents/Topology_Analysis_5GDHC_DymolaModel/Resources/Validation/Temperature_Degradation_Test1/TEST1_TM01.mos",
    timeScale(displayUnit="s") = 1)
    annotation (Placement(transformation(extent={{-120,120},{-100,140}})));
  Modelica.Thermal.HeatTransfer.Celsius.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{-80,120},{-60,140}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort TM20(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-100,30},{-80,50}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort TM12(redeclare package Medium =
        Medium) annotation (Placement(transformation(extent={{62,30},{82,50}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort TM02(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{60,-50},{80,-30}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort TM10(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-100,-50},{-80,-30}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort temperature4(redeclare package
      Medium = Medium) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,40})));
  Dual_Pipe_HeatLoss_validation_v2
                                dual_Pipe_HeatLoss(
    redeclare package Medium = Medium,
    diameter(displayUnit="m") = 0.0889,
    length=54,
    lambdaIns=0.04,
    thicknessIns=0.06,
    m_flow_nominal=m_flow_nominal_district,
    active=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Buildings.Fluid.HeatExchangers.SensibleCooler_T coo(
    m_flow_nominal=m_flow_nominal_district,
    redeclare package Medium = Medium,
    dp_nominal(displayUnit="MPa") = 50000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={120,-2})));
equation

  connect(Data_TM20.y[1], toKelvin.Celsius)
    annotation (Line(points={{-159,-30},{-154,-30}}, color={0,0,127}));
  connect(Data_TM02.y[1], toKelvin1.Celsius) annotation (Line(points={{159,-10},
          {156,-10}},                  color={0,0,127}));
  connect(toKelvin.Kelvin, hea.TSet) annotation (Line(points={{-142.5,-30},{
          -128,-30},{-128,-12}}, color={0,0,127}));
  connect(hea.port_b, TM20.port_a) annotation (Line(points={{-120,10},{-120,40},
          {-100,40}}, color={0,127,255}));
  connect(TM20.port_b, pump_heat.port_a)
    annotation (Line(points={{-80,40},{-70,40}}, color={0,127,255}));
  connect(hea.port_a, TM10.port_a) annotation (Line(points={{-120,-10},{-120,
          -40},{-100,-40}}, color={0,127,255}));
  connect(pump_heat.port_b, temperature4.port_a)
    annotation (Line(points={{-50,40},{-40,40}},          color={0,127,255}));
  connect(hea.port_a, ref.ports[1]) annotation (Line(points={{-120,-10},{-120,
          -60},{-160,-60}},
                       color={0,127,255}));
  connect(TM12.port_a, dual_Pipe_HeatLoss.port_b_hot) annotation (Line(points={
          {62,40},{20,40},{20,5},{9.8,5}}, color={0,127,255}));
  connect(dual_Pipe_HeatLoss.port_a_cold, TM10.port_b) annotation (Line(points=
          {{-10,-6},{-20,-6},{-20,-40},{-80,-40}}, color={0,127,255}));
  connect(dual_Pipe_HeatLoss.port_b_cold, TM02.port_a) annotation (Line(points=
          {{9.8,-6},{20,-6},{20,-40},{60,-40}}, color={0,127,255}));
  connect(temperature4.port_b, dual_Pipe_HeatLoss.port_a_hot)
    annotation (Line(points={{-20,40},{-20,5},{-10.2,5}}, color={0,127,255}));
  connect(TM12.port_b, coo.port_a)
    annotation (Line(points={{82,40},{120,40},{120,8}}, color={0,127,255}));
  connect(coo.port_b, TM02.port_b) annotation (Line(points={{120,-12},{120,-40},
          {80,-40}}, color={0,127,255}));
  connect(Data_TM01.y[1], prescribedTemperature.T)
    annotation (Line(points={{-99,130},{-82,130}}, color={0,0,127}));
  connect(toKelvin1.Kelvin, coo.TSet) annotation (Line(points={{144.5,-10},{140,
          -10},{140,20},{128,20},{128,10},{128,10}}, color={0,0,127}));
  connect(Data_FM01.y[1], pump_heat.m_flow_in)
    annotation (Line(points={{-99,90},{-60,90},{-60,52}}, color={0,0,127}));
  connect(prescribedTemperature.port, dual_Pipe_HeatLoss.port_a)
    annotation (Line(points={{-60,130},{0,130},{0,10}}, color={191,0,0}));
  annotation (Diagram(coordinateSystem(extent={{-200,-200},{200,200}})),
    Icon(coordinateSystem(extent={{-100,-120},{160,100}})),
    experiment(StopTime=108000));
end Temperature_Degradation;
