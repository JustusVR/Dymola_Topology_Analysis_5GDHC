within Topology_Analysis_5GDHC.DES.Ideal_Source.Valve_Control;
model ValveControl
  Modelica.Blocks.Interfaces.RealInput T_set
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput T_inlet
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

equation
  if T_set > T_inlet then
     y = 1;
   else
     y = 0;
   end if;

  annotation (Icon(graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-44,44},{52,-54}},
          lineColor={28,108,200},
          textString="C",
          textStyle={TextStyle.Bold})}),    Diagram(graphics={Text(
          extent={{-42,52},{48,-36}},
          lineColor={28,108,200},
          textString="C",
          textStyle={TextStyle.Bold})}));
end ValveControl;
