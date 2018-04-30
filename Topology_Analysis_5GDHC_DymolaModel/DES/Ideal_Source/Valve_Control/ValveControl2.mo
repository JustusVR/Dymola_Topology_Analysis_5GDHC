within Topology_Analysis_5GDHC_DymolaModel.DES.Ideal_Source.Valve_Control;
model ValveControl2
  Modelica.Blocks.Interfaces.RealInput u
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

equation
  if u > 0 then
     y=1;
   else
     y =0;
   end if;

  annotation (                                 Icon(graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}));
end ValveControl2;
