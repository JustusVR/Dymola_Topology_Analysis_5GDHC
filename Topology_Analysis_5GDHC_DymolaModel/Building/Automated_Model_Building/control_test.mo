within Topology_Analysis_5GDHC.Building.Automated_Model_Building;
model control_test
  Modelica.Blocks.Interfaces.RealOutput individual annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput connected annotation (Placement(transformation(extent={{100,-70},{120,-50}})));

  Modelica.Blocks.Interfaces.IntegerInput u
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
equation
  if u == 1 then
     individual = 0;
     connected = 1;
  else
     individual = 1;
     connected = 0;
  end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end control_test;
