within Topology_Analysis_5GDHC_DymolaModel.Test_Models;
model Test_plant "Test of a pipe with multiple segments"
  extends Modelica.Icons.Example;

  replaceable package Medium = Buildings.Media.Water;

  Buildings.Fluid.Sensors.Temperature senTem_b(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{130,-40},{150,-60}})));
  Buildings.Fluid.Sensors.Temperature senTem_a(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{130,20},{150,40}})));
  DES.Ideal_T_JVR ideal_T_JVR(redeclare package Medium = Medium, m_flow_nominal=
       1) annotation (Placement(transformation(extent={{180,20},{236,80}})));
  Building.Automated_Model_Building.Building_bidirectional
    building_bidirectional(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-60,20},{-4,80}})));
  Dual_Pipe.Dual_Pipe dual_Pipe(
    redeclare package Medium = Medium,
    diameter=0.5,
    length=100,
    m_flow_nominal=1)
    annotation (Placement(transformation(extent={{60,-20},{80,0}})));
equation

  connect(building_bidirectional.port_a, dual_Pipe.port_a_hot)
    annotation (Line(points={{-40,20},{-40,-5},{59.8,-5}}, color={0,127,255}));
  connect(building_bidirectional.port_b, dual_Pipe.port_a_cold)
    annotation (Line(points={{-24,20},{-24,-16},{60,-16}}, color={0,127,255}));
  connect(dual_Pipe.port_b_hot, ideal_T_JVR.port_a)
    annotation (Line(points={{79.8,-5},{200,-5},{200,20}}, color={0,127,255}));
  connect(dual_Pipe.port_b_cold, ideal_T_JVR.port_b) annotation (Line(points={{
          79.8,-16},{216,-16},{216,20}}, color={0,127,255}));
  connect(dual_Pipe.port_b_hot, senTem_a.port) annotation (Line(points={{79.8,
          -5},{119.9,-5},{119.9,20},{140,20}}, color={0,127,255}));
  connect(senTem_b.port, dual_Pipe.port_b_cold) annotation (Line(points={{140,
          -40},{120,-40},{120,-16},{79.8,-16}}, color={0,127,255}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-200,-100},{260,
            100}})),
experiment(Tolerance=1e-6, StopTime=120),
__Dymola_Commands(file=
          "modelica://Buildings/Resources/Scripts/Dymola/Fluid/FixedResistances/Examples/Pipe.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
This model demonstrates the use of a pipe model.
Both pipe models have the same mass flow rates and temperatures.
Otherwise, the <code>assert</code> block would terminate the simulation.
</p>
<p>
The model on the top is connected to the ambient with one heat port,
whereas the model at the bottom uses a vector of heat ports.
Since they are all connected to the same temperature, they
result in the same energy balance for the medium that flows
through the pipe.
</p>
</html>", revisions="<html>
<ul>
<li>
December 22, 2014 by Michael Wetter:<br/>
Removed <code>Modelica.Fluid.System</code>
to address issue
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/311\">#311</a>.
</li>
<li>
February 22, 2012 by Michael Wetter:<br/>
Revised implementation.
</li>
<li>
February 12, 2012 by Wangda Zuo:<br/>
First implementation.
</li>
</ul>
</html>"));
end Test_plant;
