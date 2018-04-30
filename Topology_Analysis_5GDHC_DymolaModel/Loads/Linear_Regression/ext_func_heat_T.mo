within Topology_Analysis_5GDHC.Loads.Linear_Regression;
function ext_func_heat_T

  input Real n[8];
  output Real result;
  external "C" result = heatTempCalc(n);
  annotation(Include = "#include \"Resources/Loads/Linear_Regression_C/LR_heat_tout.c\"");

end ext_func_heat_T;
