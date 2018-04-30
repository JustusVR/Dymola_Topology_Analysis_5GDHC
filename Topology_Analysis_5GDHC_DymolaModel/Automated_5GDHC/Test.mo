within Topology_Analysis_5GDHC.Automated_5GDHC;
model Test

  extends Modelica.Icons.Example;

  replaceable package Medium = Buildings.Media.Water;

  parameter Modelica.SIunits.MassFlowRate m_flow_nominal = 1;

public
  Building.Automated_Model_Building.Building_TA_LookUp_old MediumOffice(
      redeclare package Medium = Medium) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={70,350})));
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
  Building.Automated_Model_Building.Building_TA_LookUp_old Retail(redeclare
      package Medium = Medium) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={70,210})));
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
  Building.Automated_Model_Building.Building_TA_LookUp_old MultiFamily(
      redeclare package Medium = Medium) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={70,-70})));
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


equation
  connect(MediumOffice.port_a, MediumOffice_node_a.ports[1])
    annotation(Line(points={{64.2857,330},{64.2857,326},{64,326},{64,320},{64.1,
          320},{64.1,310}},                     color={0, 127, 255}));
  connect(MediumOffice.port_b, MediumOffice_node_b.ports[1])
    annotation(Line(points={{75.7143,330},{75.7143,326},{76,326},{76,320},{74.1,
          320},{74.1,310}},                     color={0, 127, 255}));
  connect(Retail.port_a, Retail_node_a.ports[1])
    annotation(Line(points={{64.2857,190},{64.2857,186},{64,186},{64,180},{64.1,
          180},{64.1,170}},                     color={0, 127, 255}));
  connect(Retail.port_b, Retail_node_b.ports[1])
    annotation(Line(points={{75.7143,190},{75.7143,186},{76,186},{76,180},{74.1,
          180},{74.1,170}},                     color={0, 127, 255}));
  connect(MultiFamily.port_a, MultiFamily_node_a.ports[1])
    annotation(Line(points={{64.2857,-90},{64.2857,-96},{64,-96},{64,-100},{
          64.1,-100},{64.1,-110}},               color={0, 127, 255}));
  connect(MultiFamily.port_b, MultiFamily_node_b.ports[1])
    annotation(Line(points={{75.7143,-90},{75.7143,-96},{76,-96},{76,-100},{
          74.1,-100},{74.1,-110}},               color={0, 127, 255}));
  connect(NewDistrictSystem.port_a, NewDistrictSystem_node_a.ports[1])
    annotation(Line(points={{64.2857,-230},{64.2857,-236},{64,-236},{64,-240},{
          64.1,-240},{64.1,-250}},                color={0, 127, 255}));
  connect(NewDistrictSystem.port_b, NewDistrictSystem_node_b.ports[1])
    annotation(Line(points={{75.7143,-230},{75.7143,-236},{76,-236},{76,-240},{
          74.1,-240},{74.1,-250}},                color={0, 127, 255}));
  connect(MediumOffice_node_a.ports[2], Pipe_MediumOffice_Retail.port_a_hot)
    annotation(Line(points={{64.7,310},{64.7,290},{110,290},{110,302.5},{114.9,
          302.5}},                                                            color={0, 127, 255}));
  connect(MediumOffice_node_b.ports[2], Pipe_MediumOffice_Retail.port_a_cold)
    annotation(Line(points={{74.7,310},{74.7,290},{110,290},{110,297},{115,297}},
                                                                              color={0, 127, 255}));
  connect(Pipe_MediumOffice_Retail.port_b_hot, Retail_node_a.ports[2])
    annotation(Line(points={{124.9,302.5},{140,302.5},{140,140},{64.7,140},{
          64.7,170}},                                                         color={0, 127, 255}));
  connect(Pipe_MediumOffice_Retail.port_b_cold, Retail_node_b.ports[2])
    annotation(Line(points={{124.9,297},{140,297},{140,140},{74.7,140},{74.7,
          170}},                                                              color={0, 127, 255}));
  connect(MediumOffice_node_a.ports[3], Pipe_MediumOffice_MultiFamily.port_a_hot)
    annotation(Line(points={{65.3,310},{65.3,290},{110,290},{110,352.5},{114.9,
          352.5}},                                                            color={0, 127, 255}));
  connect(MediumOffice_node_b.ports[3], Pipe_MediumOffice_MultiFamily.port_a_cold)
    annotation(Line(points={{75.3,310},{75.3,290},{110,290},{110,347},{115,347}},
                                                                              color={0, 127, 255}));
  connect(Pipe_MediumOffice_MultiFamily.port_b_hot, MultiFamily_node_a.ports[2])
    annotation(Line(points={{124.9,352.5},{140,352.5},{140,-140},{64.7,-140},{
          64.7,-110}},                                                           color={0, 127, 255}));
  connect(Pipe_MediumOffice_MultiFamily.port_b_cold, MultiFamily_node_b.ports[2])
    annotation(Line(points={{124.9,347},{140,347},{140,-140},{74.7,-140},{74.7,
          -110}},                                                                color={0, 127, 255}));
  connect(MediumOffice_node_a.ports[4], Pipe_MediumOffice_NewDistrictSystem.port_a_hot)
    annotation(Line(points={{65.9,310},{65.9,290},{110,290},{110,402.5},{114.9,
          402.5}},                                                            color={0, 127, 255}));
  connect(MediumOffice_node_b.ports[4], Pipe_MediumOffice_NewDistrictSystem.port_a_cold)
    annotation(Line(points={{75.9,310},{75.9,290},{110,290},{110,397},{115,397}},
                                                                              color={0, 127, 255}));
  connect(Pipe_MediumOffice_NewDistrictSystem.port_b_hot, NewDistrictSystem_node_a.ports[2])
    annotation(Line(points={{124.9,402.5},{140,402.5},{140,-280},{64.7,-280},{
          64.7,-250}},                                                           color={0, 127, 255}));
  connect(Pipe_MediumOffice_NewDistrictSystem.port_b_cold, NewDistrictSystem_node_b.ports[2])
    annotation(Line(points={{124.9,397},{140,397},{140,-280},{74.7,-280},{74.7,
          -250}},                                                                color={0, 127, 255}));
  connect(Retail_node_a.ports[3], Pipe_Retail_MultiFamily.port_a_hot)
    annotation(Line(points={{65.3,170},{65.3,150},{110,150},{110,162.5},{114.9,
          162.5}},                                                            color={0, 127, 255}));
  connect(Retail_node_b.ports[3], Pipe_Retail_MultiFamily.port_a_cold)
    annotation(Line(points={{75.3,170},{75.3,150},{110,150},{110,157},{115,157}},
                                                                              color={0, 127, 255}));
  connect(Pipe_Retail_MultiFamily.port_b_hot, MultiFamily_node_a.ports[3])
    annotation(Line(points={{124.9,162.5},{140,162.5},{140,-140},{65.3,-140},{
          65.3,-110}},                                                           color={0, 127, 255}));
  connect(Pipe_Retail_MultiFamily.port_b_cold, MultiFamily_node_b.ports[3])
    annotation(Line(points={{124.9,157},{140,157},{140,-140},{75.3,-140},{75.3,
          -110}},                                                                color={0, 127, 255}));
  connect(Retail_node_a.ports[4], Pipe_Retail_NewDistrictSystem.port_a_hot)
    annotation(Line(points={{65.9,170},{65.9,150},{110,150},{110,262.5},{114.9,
          262.5}},                                                            color={0, 127, 255}));
  connect(Retail_node_b.ports[4], Pipe_Retail_NewDistrictSystem.port_a_cold)
    annotation(Line(points={{75.9,170},{75.9,150},{110,150},{110,257},{115,257}},
                                                                              color={0, 127, 255}));
  connect(Pipe_Retail_NewDistrictSystem.port_b_hot, NewDistrictSystem_node_a.ports[3])
    annotation(Line(points={{124.9,262.5},{140,262.5},{140,-280},{65.3,-280},{
          65.3,-250}},                                                           color={0, 127, 255}));
  connect(Pipe_Retail_NewDistrictSystem.port_b_cold, NewDistrictSystem_node_b.ports[3])
    annotation(Line(points={{124.9,257},{140,257},{140,-280},{75.3,-280},{75.3,
          -250}},                                                                color={0, 127, 255}));
  connect(MultiFamily_node_a.ports[4], Pipe_MultiFamily_NewDistrictSystem.port_a_hot)
    annotation(Line(points={{65.9,-110},{65.9,-130},{110,-130},{110,-67.5},{
          114.9,-67.5}},                                                         color={0, 127, 255}));
  connect(MultiFamily_node_b.ports[4], Pipe_MultiFamily_NewDistrictSystem.port_a_cold)
    annotation(Line(points={{75.9,-110},{75.9,-130},{110,-130},{110,-73},{115,
          -73}},                                                                 color={0, 127, 255}));
  connect(Pipe_MultiFamily_NewDistrictSystem.port_b_hot, NewDistrictSystem_node_a.ports[4])
    annotation(Line(points={{124.9,-67.5},{140,-67.5},{140,-280},{65.9,-280},{
          65.9,-250}},                                                           color={0, 127, 255}));
  connect(Pipe_MultiFamily_NewDistrictSystem.port_b_cold, NewDistrictSystem_node_b.ports[4])
    annotation(Line(points={{124.9,-73},{140,-73},{140,-280},{75.9,-280},{75.9,
          -250}},                                                                color={0, 127, 255}));
  connect(Sum_Buildings_PumpingElectricity.y, Buildings_PumpingElectricity_Energy.u)
    annotation(Line(points={{581.7,480},{598,480}},
                                                  color={0, 127, 255}));
  connect(Buildings_PumpingElectricity_MediumOffice.y, Sum_Buildings_PumpingElectricity.u[1])
    annotation(Line(points={{541,510},{550,510},{550,484.667},{560,484.667}},
                                                                      color={0, 127, 255}));
  connect(Buildings_PumpingElectricity_Retail.y, Sum_Buildings_PumpingElectricity.u[2])
    annotation(Line(points={{541,490},{550,490},{550,480},{560,480}}, color={0, 127, 255}));
  connect(Buildings_PumpingElectricity_MultiFamily.y, Sum_Buildings_PumpingElectricity.u[3])
    annotation(Line(points={{541,470},{550,470},{550,475.333},{560,475.333}},
                                                                      color={0, 127, 255}));
  connect(Sum_Buildings_DH.y, Buildings_DH_Energy.u)
    annotation(Line(points={{581.7,380},{598,380}},
                                                  color={0, 127, 255}));
  connect(Buildings_DH_MediumOffice.y, Sum_Buildings_DH.u[1])
    annotation(Line(points={{541,410},{550,410},{550,384.667},{560,384.667}},
                                                                      color={0, 127, 255}));
  connect(Buildings_DH_Retail.y, Sum_Buildings_DH.u[2])
    annotation(Line(points={{541,390},{550,390},{550,380},{560,380}}, color={0, 127, 255}));
  connect(Buildings_DH_MultiFamily.y, Sum_Buildings_DH.u[3])
    annotation(Line(points={{541,370},{550,370},{550,375.333},{560,375.333}},
                                                                      color={0, 127, 255}));
  connect(Sum_Buildings_DC.y, Buildings_DC_Energy.u)
    annotation(Line(points={{581.7,280},{598,280}},
                                                  color={0, 127, 255}));
  connect(Buildings_DC_MediumOffice.y, Sum_Buildings_DC.u[1])
    annotation(Line(points={{541,310},{550,310},{550,284.667},{560,284.667}},
                                                                      color={0, 127, 255}));
  connect(Buildings_DC_Retail.y, Sum_Buildings_DC.u[2])
    annotation(Line(points={{541,290},{550,290},{550,280},{560,280}}, color={0, 127, 255}));
  connect(Buildings_DC_MultiFamily.y, Sum_Buildings_DC.u[3])
    annotation(Line(points={{541,270},{550,270},{550,275.333},{560,275.333}},
                                                                      color={0, 127, 255}));
  connect(Sum_Buildings_IH.y, Buildings_IH_Energy.u)
    annotation(Line(points={{581.7,180},{598,180}},
                                                  color={0, 127, 255}));
  connect(Buildings_IH_MediumOffice.y, Sum_Buildings_IH.u[1])
    annotation(Line(points={{541,210},{550,210},{550,184.667},{560,184.667}},
                                                                      color={0, 127, 255}));
  connect(Buildings_IH_Retail.y, Sum_Buildings_IH.u[2])
    annotation(Line(points={{541,190},{550,190},{550,180},{560,180}}, color={0, 127, 255}));
  connect(Buildings_IH_MultiFamily.y, Sum_Buildings_IH.u[3])
    annotation(Line(points={{541,170},{550,170},{550,175.333},{560,175.333}},
                                                                      color={0, 127, 255}));
  connect(Sum_Buildings_IC.y, Buildings_IC_Energy.u)
    annotation(Line(points={{581.7,80},{598,80}},
                                                color={0, 127, 255}));
  connect(Buildings_IC_MediumOffice.y, Sum_Buildings_IC.u[1])
    annotation(Line(points={{541,110},{550,110},{550,84.6667},{560,84.6667}},
                                                                    color={0, 127, 255}));
  connect(Buildings_IC_Retail.y, Sum_Buildings_IC.u[2])
    annotation(Line(points={{541,90},{550,90},{550,80},{560,80}}, color={0, 127, 255}));
  connect(Buildings_IC_MultiFamily.y, Sum_Buildings_IC.u[3])
    annotation(Line(points={{541,70},{550,70},{550,75.3333},{560,75.3333}},
                                                                  color={0, 127, 255}));
  connect(Sum_Buildings_eleHP_heat.y, Buildings_eleHP_heat_Energy.u)
    annotation(Line(points={{581.7,-20},{598,-20}},
                                                  color={0, 127, 255}));
  connect(Buildings_eleHP_heat_MediumOffice.y, Sum_Buildings_eleHP_heat.u[1])
    annotation(Line(points={{541,10},{550,10},{550,-15.3333},{560,-15.3333}},
                                                                    color={0, 127, 255}));
  connect(Buildings_eleHP_heat_Retail.y, Sum_Buildings_eleHP_heat.u[2])
    annotation(Line(points={{541,-10},{550,-10},{550,-20},{560,-20}}, color={0, 127, 255}));
  connect(Buildings_eleHP_heat_MultiFamily.y, Sum_Buildings_eleHP_heat.u[3])
    annotation(Line(points={{541,-30},{550,-30},{550,-24.6667},{560,-24.6667}},
                                                                      color={0, 127, 255}));
  connect(Sum_Buildings_eleHP_cool.y, Buildings_eleHP_cool_Energy.u)
    annotation(Line(points={{581.7,-120},{598,-120}},
                                                    color={0, 127, 255}));
  connect(Buildings_eleHP_cool_MediumOffice.y, Sum_Buildings_eleHP_cool.u[1])
    annotation(Line(points={{541,-90},{550,-90},{550,-115.333},{560,-115.333}},
                                                                        color={0, 127, 255}));
  connect(Buildings_eleHP_cool_Retail.y, Sum_Buildings_eleHP_cool.u[2])
    annotation(Line(points={{541,-110},{550,-110},{550,-120},{560,-120}}, color={0, 127, 255}));
  connect(Buildings_eleHP_cool_MultiFamily.y, Sum_Buildings_eleHP_cool.u[3])
    annotation(Line(points={{541,-130},{550,-130},{550,-124.667},{560,-124.667}},
                                                                          color={0, 127, 255}));
  connect(Sum_DES_heat.y, DES_heat_Energy.u)
    annotation(Line(points={{581.7,-200},{598,-200}},
                                                    color={0, 127, 255}));
  connect(DES_heat_NewDistrictSystem.y, Sum_DES_heat.u[1])
    annotation(Line(points={{541,-190},{550,-190},{550,-200},{560,-200}}, color={0, 127, 255}));
  connect(Sum_DES_cool.y, DES_cool_Energy.u)
    annotation(Line(points={{581.7,-260},{598,-260}},
                                                    color={0, 127, 255}));
  connect(DES_cool_NewDistrictSystem.y, Sum_DES_cool.u[1])
    annotation(Line(points={{541,-250},{550,-250},{550,-260},{560,-260}}, color={0, 127, 255}));
  connect(Sum_HeatLoss.y, HeatLoss_Energy.u)
    annotation(Line(points={{581.7,-360},{598,-360}},
                                                    color={0, 127, 255}));
  connect(HeatLoss_Pipe_MediumOffice_Retail.y, Sum_HeatLoss.u[1])
    annotation(Line(points={{541,-300},{550,-300},{550,-354.167},{560,-354.167}},
                                                                          color={0, 127, 255}));
  connect(HeatLoss_Pipe_MediumOffice_MultiFamily.y, Sum_HeatLoss.u[2])
    annotation(Line(points={{541,-320},{550,-320},{550,-356.5},{560,-356.5}},
                                                                          color={0, 127, 255}));
  connect(HeatLoss_Pipe_MediumOffice_NewDistrictSystem.y, Sum_HeatLoss.u[3])
    annotation(Line(points={{541,-340},{550,-340},{550,-358.833},{560,-358.833}},
                                                                          color={0, 127, 255}));
  connect(HeatLoss_Pipe_Retail_MultiFamily.y, Sum_HeatLoss.u[4])
    annotation(Line(points={{541,-360},{550,-360},{550,-361.167},{560,-361.167}},
                                                                          color={0, 127, 255}));
  connect(HeatLoss_Pipe_Retail_NewDistrictSystem.y, Sum_HeatLoss.u[5])
    annotation(Line(points={{541,-380},{550,-380},{550,-363.5},{560,-363.5}},
                                                                          color={0, 127, 255}));
  connect(HeatLoss_Pipe_MultiFamily_NewDistrictSystem.y, Sum_HeatLoss.u[6])
    annotation(Line(points={{541,-400},{550,-400},{550,-365.833},{560,-365.833}},
                                                                          color={0, 127, 255}));

  annotation (Diagram(coordinateSystem(extent={{-520,-520},{520,520}})),
    Icon(coordinateSystem(extent={{-100,-120},{160,100}})));
end Test;
