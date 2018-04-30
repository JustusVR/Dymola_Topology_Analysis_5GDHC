within Topology_Analysis_5GDHC.Heat_Exchanger.Loads.Linear_Regression;
function ext_func_heat_P

  input Real n[8];
  output Real result;
  external "C" result = heatPCalc(n);
  annotation(Include = "#include \"Resources/Loads/Linear_Regression_C/LR_heat_p.c\"");

end ext_func_heat_P;
