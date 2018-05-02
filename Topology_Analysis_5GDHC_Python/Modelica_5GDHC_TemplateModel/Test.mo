within Topology_Analysis_5GDHC_DymolaModel.Automated_5GDHC;
model Test

  extends Modelica.Icons.Example;

  replaceable package Medium = Buildings.Media.Water;

  parameter Modelica.SIunits.MassFlowRate m_flow_nominal = 1;

public
  Building.Automated_Model_Building.Building_TA_LookUp MediumOffice(
      redeclare package Medium = Medium,
      Cooling_DQ_File = "/Users/justusvonrhein/Documents/Colorado/Ambient_Loops/Automated_Model_Building_v3/loads/TA/MediumOffice_mos_loads/cooling_DistrictCoolingChilledWaterEnergy_mass_flow_0.75.mos",
      Cooling_HP_ele_File ="/Users/justusvonrhein/Documents/Colorado/Ambient_Loops/Automated_Model_Building_v3/loads/TA/MediumOffice_mos_loads/cooling_CoolingElectricity_mass_flow_0.75.mos",
      Heating_DQ_File ="/Users/justusvonrhein/Documents/Colorado/Ambient_Loops/Automated_Model_Building_v3/loads/TA/MediumOffice_mos_loads/heating_DistrictHeatingHotWaterEnergy_mass_flow_0.25.mos",
      Heating_HP_ele_File = "/Users/justusvonrhein/Documents/Colorado/Ambient_Loops/Automated_Model_Building_v3/loads/TA/MediumOffice_mos_loads/heating_HeatingElectricity_mass_flow_0.25.mos",
      Q_nominal_heat = 9154.55,
      Q_nominal_cool = 19917.23)
      annotation (Placement(transformation(extent={{-20,-20},{20,20}},rotation = 0, origin = {70,350})));
protected
  Buildings.Fluid.Delays.DelayFirstOrder MediumOffice_node_a(
      nPorts=4,
      redeclare package Medium = Medium,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-3,-3},{3,3}},rotation = 0, origin = {65,313})));
  Buildings.Fluid.Delays.DelayFirstOrder MediumOffice_node_b(
      nPorts=4,
      redeclare package Medium = Medium,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-3,-3},{3,3}},rotation = 0, origin = {75,313})));

public
  Building.Automated_Model_Building.Building_TA_LookUp Retail(
      redeclare package Medium = Medium,
      Cooling_DQ_File = "/Users/justusvonrhein/Documents/Colorado/Ambient_Loops/Automated_Model_Building_v3/loads/TA/Retail_mos_loads/cooling_DistrictCoolingChilledWaterEnergy_mass_flow_0.75.mos",
      Cooling_HP_ele_File ="/Users/justusvonrhein/Documents/Colorado/Ambient_Loops/Automated_Model_Building_v3/loads/TA/Retail_mos_loads/cooling_CoolingElectricity_mass_flow_0.75.mos",
      Heating_DQ_File ="/Users/justusvonrhein/Documents/Colorado/Ambient_Loops/Automated_Model_Building_v3/loads/TA/Retail_mos_loads/heating_DistrictHeatingHotWaterEnergy_mass_flow_0.25.mos",
      Heating_HP_ele_File = "/Users/justusvonrhein/Documents/Colorado/Ambient_Loops/Automated_Model_Building_v3/loads/TA/Retail_mos_loads/heating_HeatingElectricity_mass_flow_0.25.mos",
      Q_nominal_heat = 9154.55,
      Q_nominal_cool = 19917.23)
      annotation (Placement(transformation(extent={{-20,-20},{20,20}},rotation = 0, origin = {70,210})));
protected
  Buildings.Fluid.Delays.DelayFirstOrder Retail_node_a(
      nPorts=4,
      redeclare package Medium = Medium,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-3,-3},{3,3}},rotation = 0, origin = {65,173})));
  Buildings.Fluid.Delays.DelayFirstOrder Retail_node_b(
      nPorts=4,
      redeclare package Medium = Medium,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-3,-3},{3,3}},rotation = 0, origin = {75,173})));

public
  Building.Automated_Model_Building.Building_TA_LookUp MultiFamily(
      redeclare package Medium = Medium,
      Cooling_DQ_File = "/Users/justusvonrhein/Documents/Colorado/Ambient_Loops/Automated_Model_Building_v3/loads/TA/MultiFamily_mos_loads/cooling_DistrictCoolingChilledWaterEnergy_mass_flow_0.75.mos",
      Cooling_HP_ele_File ="/Users/justusvonrhein/Documents/Colorado/Ambient_Loops/Automated_Model_Building_v3/loads/TA/MultiFamily_mos_loads/cooling_CoolingElectricity_mass_flow_0.75.mos",
      Heating_DQ_File ="/Users/justusvonrhein/Documents/Colorado/Ambient_Loops/Automated_Model_Building_v3/loads/TA/MultiFamily_mos_loads/heating_DistrictHeatingHotWaterEnergy_mass_flow_0.25.mos",
      Heating_HP_ele_File = "/Users/justusvonrhein/Documents/Colorado/Ambient_Loops/Automated_Model_Building_v3/loads/TA/MultiFamily_mos_loads/heating_HeatingElectricity_mass_flow_0.25.mos",
      Q_nominal_heat = 9154.55,
      Q_nominal_cool = 19917.23)
      annotation (Placement(transformation(extent={{-20,-20},{20,20}},rotation = 0, origin = {70,-70})));
protected
  Buildings.Fluid.Delays.DelayFirstOrder MultiFamily_node_a(
      nPorts=4,
      redeclare package Medium = Medium,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-3,-3},{3,3}},rotation = 0, origin = {65,-107})));
  Buildings.Fluid.Delays.DelayFirstOrder MultiFamily_node_b(
      nPorts=4,
      redeclare package Medium = Medium,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-3,-3},{3,3}},rotation = 0, origin = {75,-107})));

public
  Topology_Analysis_5GDHC.DES.Ideal_T_JVR NewDistrictSystem(
      redeclare package Medium = Medium,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-20,-20},{20,20}},rotation = 0, origin = {70,-210})));
protected
  Buildings.Fluid.Delays.DelayFirstOrder NewDistrictSystem_node_a(
      nPorts=4,
      redeclare package Medium = Medium,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-3,-3},{3,3}},rotation = 0, origin = {65,-247})));
  Buildings.Fluid.Delays.DelayFirstOrder NewDistrictSystem_node_b(
      nPorts=4,
      redeclare package Medium = Medium,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-3,-3},{3,3}},rotation = 0, origin = {75,-247})));


public
  Topology_Analysis_5GDHC.Dual_Pipe.Dual_Pipe_HeatLoss Pipe_MediumOffice_Retail(
      redeclare package Medium = Medium,
      length=99,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-5,-5},{5,5}},rotation = 0, origin = {120,300})));

  Topology_Analysis_5GDHC.Dual_Pipe.Dual_Pipe_HeatLoss Pipe_MediumOffice_MultiFamily(
      redeclare package Medium = Medium,
      length=59,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-5,-5},{5,5}},rotation = 0, origin = {120,350})));

  Topology_Analysis_5GDHC.Dual_Pipe.Dual_Pipe_HeatLoss Pipe_MediumOffice_NewDistrictSystem(
      redeclare package Medium = Medium,
      length=143,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-5,-5},{5,5}},rotation = 0, origin = {120,400})));

  Topology_Analysis_5GDHC.Dual_Pipe.Dual_Pipe_HeatLoss Pipe_Retail_MultiFamily(
      redeclare package Medium = Medium,
      length=45,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-5,-5},{5,5}},rotation = 0, origin = {120,160})));

  Topology_Analysis_5GDHC.Dual_Pipe.Dual_Pipe_HeatLoss Pipe_Retail_NewDistrictSystem(
      redeclare package Medium = Medium,
      length=46,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-5,-5},{5,5}},rotation = 0, origin = {120,260})));

  Topology_Analysis_5GDHC.Dual_Pipe.Dual_Pipe_HeatLoss Pipe_MultiFamily_NewDistrictSystem(
      redeclare package Medium = Medium,
      length=85,
      m_flow_nominal=1)
      annotation (Placement(transformation(extent={{-5,-5},{5,5}},rotation = 0, origin = {120,-70})));


public
  Modelica.Blocks.Continuous.Integrator Buildings_PumpingElectricity_Energy(
      k = 1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {610,480})));
protected
  Modelica.Blocks.Math.MultiSum Sum_Buildings_PumpingElectricity(
      nu = 3)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {570,480})));
  Modelica.Blocks.Sources.RealExpression Buildings_PumpingElectricity_MediumOffice(
      y = MediumOffice.elePumps)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {530,510})));
  Modelica.Blocks.Sources.RealExpression Buildings_PumpingElectricity_Retail(
      y = Retail.elePumps)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {530,490})));
  Modelica.Blocks.Sources.RealExpression Buildings_PumpingElectricity_MultiFamily(
      y = MultiFamily.elePumps)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {530,470})));

public
  Modelica.Blocks.Continuous.Integrator Buildings_DH_Energy(
      k = 1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {610,380})));
protected
  Modelica.Blocks.Math.MultiSum Sum_Buildings_DH(
      nu = 3)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {570,380})));
  Modelica.Blocks.Sources.RealExpression Buildings_DH_MediumOffice(
      y = MediumOffice.Q_DH)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {530,410})));
  Modelica.Blocks.Sources.RealExpression Buildings_DH_Retail(
      y = Retail.Q_DH)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {530,390})));
  Modelica.Blocks.Sources.RealExpression Buildings_DH_MultiFamily(
      y = MultiFamily.Q_DH)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {530,370})));

public
  Modelica.Blocks.Continuous.Integrator Buildings_DC_Energy(
      k = 1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {610,280})));
protected
  Modelica.Blocks.Math.MultiSum Sum_Buildings_DC(
      nu = 3)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {570,280})));
  Modelica.Blocks.Sources.RealExpression Buildings_DC_MediumOffice(
      y = MediumOffice.Q_DC)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {530,310})));
  Modelica.Blocks.Sources.RealExpression Buildings_DC_Retail(
      y = Retail.Q_DC)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {530,290})));
  Modelica.Blocks.Sources.RealExpression Buildings_DC_MultiFamily(
      y = MultiFamily.Q_DC)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {530,270})));

public
  Modelica.Blocks.Continuous.Integrator Buildings_IH_Energy(
      k = 1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {610,180})));
protected
  Modelica.Blocks.Math.MultiSum Sum_Buildings_IH(
      nu = 3)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {570,180})));
  Modelica.Blocks.Sources.RealExpression Buildings_IH_MediumOffice(
      y = MediumOffice.Q_IH)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {530,210})));
  Modelica.Blocks.Sources.RealExpression Buildings_IH_Retail(
      y = Retail.Q_IH)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {530,190})));
  Modelica.Blocks.Sources.RealExpression Buildings_IH_MultiFamily(
      y = MultiFamily.Q_IH)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {530,170})));

public
  Modelica.Blocks.Continuous.Integrator Buildings_IC_Energy(
      k = 1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {610,80})));
protected
  Modelica.Blocks.Math.MultiSum Sum_Buildings_IC(
      nu = 3)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {570,80})));
  Modelica.Blocks.Sources.RealExpression Buildings_IC_MediumOffice(
      y = MediumOffice.Q_IC)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {530,110})));
  Modelica.Blocks.Sources.RealExpression Buildings_IC_Retail(
      y = Retail.Q_IC)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {530,90})));
  Modelica.Blocks.Sources.RealExpression Buildings_IC_MultiFamily(
      y = MultiFamily.Q_IC)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {530,70})));

public
  Modelica.Blocks.Continuous.Integrator Buildings_eleHP_heat_Energy(
      k = 1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {610,-20})));
protected
  Modelica.Blocks.Math.MultiSum Sum_Buildings_eleHP_heat(
      nu = 3)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {570,-20})));
  Modelica.Blocks.Sources.RealExpression Buildings_eleHP_heat_MediumOffice(
      y = MediumOffice.eleHP_heat)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {530,10})));
  Modelica.Blocks.Sources.RealExpression Buildings_eleHP_heat_Retail(
      y = Retail.eleHP_heat)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {530,-10})));
  Modelica.Blocks.Sources.RealExpression Buildings_eleHP_heat_MultiFamily(
      y = MultiFamily.eleHP_heat)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {530,-30})));

public
  Modelica.Blocks.Continuous.Integrator Buildings_eleHP_cool_Energy(
      k = 1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {610,-120})));
protected
  Modelica.Blocks.Math.MultiSum Sum_Buildings_eleHP_cool(
      nu = 3)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {570,-120})));
  Modelica.Blocks.Sources.RealExpression Buildings_eleHP_cool_MediumOffice(
      y = MediumOffice.eleHP_cool)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {530,-90})));
  Modelica.Blocks.Sources.RealExpression Buildings_eleHP_cool_Retail(
      y = Retail.eleHP_cool)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {530,-110})));
  Modelica.Blocks.Sources.RealExpression Buildings_eleHP_cool_MultiFamily(
      y = MultiFamily.eleHP_cool)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {530,-130})));

public
  Modelica.Blocks.Continuous.Integrator DES_heat_Energy(
      k = 1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {610,-200})));
protected
  Modelica.Blocks.Math.MultiSum Sum_DES_heat(
      nu = 1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {570,-200})));
  Modelica.Blocks.Sources.RealExpression DES_heat_NewDistrictSystem(
      y = NewDistrictSystem.Q_H_flow)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {530,-190})));

public
  Modelica.Blocks.Continuous.Integrator DES_cool_Energy(
      k = 1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {610,-260})));
protected
  Modelica.Blocks.Math.MultiSum Sum_DES_cool(
      nu = 1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {570,-260})));
  Modelica.Blocks.Sources.RealExpression DES_cool_NewDistrictSystem(
      y = NewDistrictSystem.Q_C_flow)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {530,-250})));

public
  Modelica.Blocks.Continuous.Integrator HeatLoss_Energy(
      k = 1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {610,-360})));
protected
  Modelica.Blocks.Math.MultiSum Sum_HeatLoss(
      nu = 6)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {570,-360})));
  Modelica.Blocks.Sources.RealExpression HeatLoss_Pipe_MediumOffice_Retail(
      y = Pipe_MediumOffice_Retail.heatLoss)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {530,-300})));
  Modelica.Blocks.Sources.RealExpression HeatLoss_Pipe_MediumOffice_MultiFamily(
      y = Pipe_MediumOffice_MultiFamily.heatLoss)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {530,-320})));
  Modelica.Blocks.Sources.RealExpression HeatLoss_Pipe_MediumOffice_NewDistrictSystem(
      y = Pipe_MediumOffice_NewDistrictSystem.heatLoss)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {530,-340})));
  Modelica.Blocks.Sources.RealExpression HeatLoss_Pipe_Retail_MultiFamily(
      y = Pipe_Retail_MultiFamily.heatLoss)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {530,-360})));
  Modelica.Blocks.Sources.RealExpression HeatLoss_Pipe_Retail_NewDistrictSystem(
      y = Pipe_Retail_NewDistrictSystem.heatLoss)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {530,-380})));
  Modelica.Blocks.Sources.RealExpression HeatLoss_Pipe_MultiFamily_NewDistrictSystem(
      y = Pipe_MultiFamily_NewDistrictSystem.heatLoss)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation = 0, origin = {530,-400})));


  equation;
  connect(MediumOffice.port_a, MediumOffice_node_a.ports[1])
    annotation(Line(points={{65,330},{65,310}}, color={0, 127, 255}));
  connect(MediumOffice.port_b, MediumOffice_node_b.ports[1])
    annotation(Line(points={{75,330},{75,310}}, color={0, 127, 255}));
  connect(Retail.port_a, Retail_node_a.ports[1])
    annotation(Line(points={{65,190},{65,170}}, color={0, 127, 255}));
  connect(Retail.port_b, Retail_node_b.ports[1])
    annotation(Line(points={{75,190},{75,170}}, color={0, 127, 255}));
  connect(MultiFamily.port_a, MultiFamily_node_a.ports[1])
    annotation(Line(points={{65,-90},{65,-110}}, color={0, 127, 255}));
  connect(MultiFamily.port_b, MultiFamily_node_b.ports[1])
    annotation(Line(points={{75,-90},{75,-110}}, color={0, 127, 255}));
  connect(NewDistrictSystem.port_a, NewDistrictSystem_node_a.ports[1])
    annotation(Line(points={{65,-230},{65,-250}}, color={0, 127, 255}));
  connect(NewDistrictSystem.port_b, NewDistrictSystem_node_b.ports[1])
    annotation(Line(points={{75,-230},{75,-250}}, color={0, 127, 255}));
  connect(MediumOffice_node_a.ports[2], Pipe_MediumOffice_Retail.port_a_hot)
    annotation(Line(points={{65,310},{65,290},{110,290},{110,302},{115,302}}, color={0, 127, 255}));
  connect(MediumOffice_node_b.ports[2], Pipe_MediumOffice_Retail.port_a_cold)
    annotation(Line(points={{75,310},{75,290},{110,290},{110,297},{115,297}}, color={0, 127, 255}));
  connect(Pipe_MediumOffice_Retail.port_b_hot, Retail_node_a.ports[2])
    annotation(Line(points={{125,302},{140,302},{140,140},{65,140},{65,170}}, color={0, 127, 255}));
  connect(Pipe_MediumOffice_Retail.port_b_cold, Retail_node_b.ports[2])
    annotation(Line(points={{125,298},{140,298},{140,140},{75,140},{75,170}}, color={0, 127, 255}));
  connect(MediumOffice_node_a.ports[3], Pipe_MediumOffice_MultiFamily.port_a_hot)
    annotation(Line(points={{65,310},{65,290},{110,290},{110,352},{115,352}}, color={0, 127, 255}));
  connect(MediumOffice_node_b.ports[3], Pipe_MediumOffice_MultiFamily.port_a_cold)
    annotation(Line(points={{75,310},{75,290},{110,290},{110,347},{115,347}}, color={0, 127, 255}));
  connect(Pipe_MediumOffice_MultiFamily.port_b_hot, MultiFamily_node_a.ports[2])
    annotation(Line(points={{125,352},{140,352},{140,-140},{65,-140},{65,-110}}, color={0, 127, 255}));
  connect(Pipe_MediumOffice_MultiFamily.port_b_cold, MultiFamily_node_b.ports[2])
    annotation(Line(points={{125,348},{140,348},{140,-140},{75,-140},{75,-110}}, color={0, 127, 255}));
  connect(MediumOffice_node_a.ports[4], Pipe_MediumOffice_NewDistrictSystem.port_a_hot)
    annotation(Line(points={{65,310},{65,290},{110,290},{110,402},{115,402}}, color={0, 127, 255}));
  connect(MediumOffice_node_b.ports[4], Pipe_MediumOffice_NewDistrictSystem.port_a_cold)
    annotation(Line(points={{75,310},{75,290},{110,290},{110,397},{115,397}}, color={0, 127, 255}));
  connect(Pipe_MediumOffice_NewDistrictSystem.port_b_hot, NewDistrictSystem_node_a.ports[2])
    annotation(Line(points={{125,402},{140,402},{140,-280},{65,-280},{65,-250}}, color={0, 127, 255}));
  connect(Pipe_MediumOffice_NewDistrictSystem.port_b_cold, NewDistrictSystem_node_b.ports[2])
    annotation(Line(points={{125,398},{140,398},{140,-280},{75,-280},{75,-250}}, color={0, 127, 255}));
  connect(Retail_node_a.ports[3], Pipe_Retail_MultiFamily.port_a_hot)
    annotation(Line(points={{65,170},{65,150},{110,150},{110,162},{115,162}}, color={0, 127, 255}));
  connect(Retail_node_b.ports[3], Pipe_Retail_MultiFamily.port_a_cold)
    annotation(Line(points={{75,170},{75,150},{110,150},{110,157},{115,157}}, color={0, 127, 255}));
  connect(Pipe_Retail_MultiFamily.port_b_hot, MultiFamily_node_a.ports[3])
    annotation(Line(points={{125,162},{140,162},{140,-140},{65,-140},{65,-110}}, color={0, 127, 255}));
  connect(Pipe_Retail_MultiFamily.port_b_cold, MultiFamily_node_b.ports[3])
    annotation(Line(points={{125,158},{140,158},{140,-140},{75,-140},{75,-110}}, color={0, 127, 255}));
  connect(Retail_node_a.ports[4], Pipe_Retail_NewDistrictSystem.port_a_hot)
    annotation(Line(points={{65,170},{65,150},{110,150},{110,262},{115,262}}, color={0, 127, 255}));
  connect(Retail_node_b.ports[4], Pipe_Retail_NewDistrictSystem.port_a_cold)
    annotation(Line(points={{75,170},{75,150},{110,150},{110,257},{115,257}}, color={0, 127, 255}));
  connect(Pipe_Retail_NewDistrictSystem.port_b_hot, NewDistrictSystem_node_a.ports[3])
    annotation(Line(points={{125,262},{140,262},{140,-280},{65,-280},{65,-250}}, color={0, 127, 255}));
  connect(Pipe_Retail_NewDistrictSystem.port_b_cold, NewDistrictSystem_node_b.ports[3])
    annotation(Line(points={{125,258},{140,258},{140,-280},{75,-280},{75,-250}}, color={0, 127, 255}));
  connect(MultiFamily_node_a.ports[4], Pipe_MultiFamily_NewDistrictSystem.port_a_hot)
    annotation(Line(points={{65,-110},{65,-130},{110,-130},{110,-67},{115,-67}}, color={0, 127, 255}));
  connect(MultiFamily_node_b.ports[4], Pipe_MultiFamily_NewDistrictSystem.port_a_cold)
    annotation(Line(points={{75,-110},{75,-130},{110,-130},{110,-72},{115,-72}}, color={0, 127, 255}));
  connect(Pipe_MultiFamily_NewDistrictSystem.port_b_hot, NewDistrictSystem_node_a.ports[4])
    annotation(Line(points={{125,-68},{140,-68},{140,-280},{65,-280},{65,-250}}, color={0, 127, 255}));
  connect(Pipe_MultiFamily_NewDistrictSystem.port_b_cold, NewDistrictSystem_node_b.ports[4])
    annotation(Line(points={{125,-72},{140,-72},{140,-280},{75,-280},{75,-250}}, color={0, 127, 255}));
  connect(Sum_Buildings_PumpingElectricity.y, Buildings_PumpingElectricity_Energy.u)
    annotation(Line(points={{580,480},{600,480}}, color={0, 127, 255}));
  connect(Buildings_PumpingElectricity_MediumOffice.y, Sum_Buildings_PumpingElectricity.u[1])
    annotation(Line(points={{540,510},{550,510},{550,480},{560,480}}, color={0, 127, 255}));
  connect(Buildings_PumpingElectricity_Retail.y, Sum_Buildings_PumpingElectricity.u[2])
    annotation(Line(points={{540,490},{550,490},{550,480},{560,480}}, color={0, 127, 255}));
  connect(Buildings_PumpingElectricity_MultiFamily.y, Sum_Buildings_PumpingElectricity.u[3])
    annotation(Line(points={{540,470},{550,470},{550,480},{560,480}}, color={0, 127, 255}));
  connect(Sum_Buildings_DH.y, Buildings_DH_Energy.u)
    annotation(Line(points={{580,380},{600,380}}, color={0, 127, 255}));
  connect(Buildings_DH_MediumOffice.y, Sum_Buildings_DH.u[1])
    annotation(Line(points={{540,410},{550,410},{550,380},{560,380}}, color={0, 127, 255}));
  connect(Buildings_DH_Retail.y, Sum_Buildings_DH.u[2])
    annotation(Line(points={{540,390},{550,390},{550,380},{560,380}}, color={0, 127, 255}));
  connect(Buildings_DH_MultiFamily.y, Sum_Buildings_DH.u[3])
    annotation(Line(points={{540,370},{550,370},{550,380},{560,380}}, color={0, 127, 255}));
  connect(Sum_Buildings_DC.y, Buildings_DC_Energy.u)
    annotation(Line(points={{580,280},{600,280}}, color={0, 127, 255}));
  connect(Buildings_DC_MediumOffice.y, Sum_Buildings_DC.u[1])
    annotation(Line(points={{540,310},{550,310},{550,280},{560,280}}, color={0, 127, 255}));
  connect(Buildings_DC_Retail.y, Sum_Buildings_DC.u[2])
    annotation(Line(points={{540,290},{550,290},{550,280},{560,280}}, color={0, 127, 255}));
  connect(Buildings_DC_MultiFamily.y, Sum_Buildings_DC.u[3])
    annotation(Line(points={{540,270},{550,270},{550,280},{560,280}}, color={0, 127, 255}));
  connect(Sum_Buildings_IH.y, Buildings_IH_Energy.u)
    annotation(Line(points={{580,180},{600,180}}, color={0, 127, 255}));
  connect(Buildings_IH_MediumOffice.y, Sum_Buildings_IH.u[1])
    annotation(Line(points={{540,210},{550,210},{550,180},{560,180}}, color={0, 127, 255}));
  connect(Buildings_IH_Retail.y, Sum_Buildings_IH.u[2])
    annotation(Line(points={{540,190},{550,190},{550,180},{560,180}}, color={0, 127, 255}));
  connect(Buildings_IH_MultiFamily.y, Sum_Buildings_IH.u[3])
    annotation(Line(points={{540,170},{550,170},{550,180},{560,180}}, color={0, 127, 255}));
  connect(Sum_Buildings_IC.y, Buildings_IC_Energy.u)
    annotation(Line(points={{580,80},{600,80}}, color={0, 127, 255}));
  connect(Buildings_IC_MediumOffice.y, Sum_Buildings_IC.u[1])
    annotation(Line(points={{540,110},{550,110},{550,80},{560,80}}, color={0, 127, 255}));
  connect(Buildings_IC_Retail.y, Sum_Buildings_IC.u[2])
    annotation(Line(points={{540,90},{550,90},{550,80},{560,80}}, color={0, 127, 255}));
  connect(Buildings_IC_MultiFamily.y, Sum_Buildings_IC.u[3])
    annotation(Line(points={{540,70},{550,70},{550,80},{560,80}}, color={0, 127, 255}));
  connect(Sum_Buildings_eleHP_heat.y, Buildings_eleHP_heat_Energy.u)
    annotation(Line(points={{580,-20},{600,-20}}, color={0, 127, 255}));
  connect(Buildings_eleHP_heat_MediumOffice.y, Sum_Buildings_eleHP_heat.u[1])
    annotation(Line(points={{540,10},{550,10},{550,-20},{560,-20}}, color={0, 127, 255}));
  connect(Buildings_eleHP_heat_Retail.y, Sum_Buildings_eleHP_heat.u[2])
    annotation(Line(points={{540,-10},{550,-10},{550,-20},{560,-20}}, color={0, 127, 255}));
  connect(Buildings_eleHP_heat_MultiFamily.y, Sum_Buildings_eleHP_heat.u[3])
    annotation(Line(points={{540,-30},{550,-30},{550,-20},{560,-20}}, color={0, 127, 255}));
  connect(Sum_Buildings_eleHP_cool.y, Buildings_eleHP_cool_Energy.u)
    annotation(Line(points={{580,-120},{600,-120}}, color={0, 127, 255}));
  connect(Buildings_eleHP_cool_MediumOffice.y, Sum_Buildings_eleHP_cool.u[1])
    annotation(Line(points={{540,-90},{550,-90},{550,-120},{560,-120}}, color={0, 127, 255}));
  connect(Buildings_eleHP_cool_Retail.y, Sum_Buildings_eleHP_cool.u[2])
    annotation(Line(points={{540,-110},{550,-110},{550,-120},{560,-120}}, color={0, 127, 255}));
  connect(Buildings_eleHP_cool_MultiFamily.y, Sum_Buildings_eleHP_cool.u[3])
    annotation(Line(points={{540,-130},{550,-130},{550,-120},{560,-120}}, color={0, 127, 255}));
  connect(Sum_DES_heat.y, DES_heat_Energy.u)
    annotation(Line(points={{580,-200},{600,-200}}, color={0, 127, 255}));
  connect(DES_heat_NewDistrictSystem.y, Sum_DES_heat.u[1])
    annotation(Line(points={{540,-190},{550,-190},{550,-200},{560,-200}}, color={0, 127, 255}));
  connect(Sum_DES_cool.y, DES_cool_Energy.u)
    annotation(Line(points={{580,-260},{600,-260}}, color={0, 127, 255}));
  connect(DES_cool_NewDistrictSystem.y, Sum_DES_cool.u[1])
    annotation(Line(points={{540,-250},{550,-250},{550,-260},{560,-260}}, color={0, 127, 255}));
  connect(Sum_HeatLoss.y, HeatLoss_Energy.u)
    annotation(Line(points={{580,-360},{600,-360}}, color={0, 127, 255}));
  connect(HeatLoss_Pipe_MediumOffice_Retail.y, Sum_HeatLoss.u[1])
    annotation(Line(points={{540,-300},{550,-300},{550,-360},{560,-360}}, color={0, 127, 255}));
  connect(HeatLoss_Pipe_MediumOffice_MultiFamily.y, Sum_HeatLoss.u[2])
    annotation(Line(points={{540,-320},{550,-320},{550,-360},{560,-360}}, color={0, 127, 255}));
  connect(HeatLoss_Pipe_MediumOffice_NewDistrictSystem.y, Sum_HeatLoss.u[3])
    annotation(Line(points={{540,-340},{550,-340},{550,-360},{560,-360}}, color={0, 127, 255}));
  connect(HeatLoss_Pipe_Retail_MultiFamily.y, Sum_HeatLoss.u[4])
    annotation(Line(points={{540,-360},{550,-360},{550,-360},{560,-360}}, color={0, 127, 255}));
  connect(HeatLoss_Pipe_Retail_NewDistrictSystem.y, Sum_HeatLoss.u[5])
    annotation(Line(points={{540,-380},{550,-380},{550,-360},{560,-360}}, color={0, 127, 255}));
  connect(HeatLoss_Pipe_MultiFamily_NewDistrictSystem.y, Sum_HeatLoss.u[6])
    annotation(Line(points={{540,-400},{550,-400},{550,-360},{560,-360}}, color={0, 127, 255}));

  annotation (Diagram(coordinateSystem(extent={{-520,-520},{520,520}})), 
    Icon(coordinateSystem(extent={{-100,-120},{160,100}}))); 
end Test;
