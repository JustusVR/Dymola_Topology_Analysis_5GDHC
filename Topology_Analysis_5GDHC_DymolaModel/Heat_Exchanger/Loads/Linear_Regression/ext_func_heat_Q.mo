within Topology_Analysis_5GDHC.Heat_Exchanger.Loads.Linear_Regression;
function ext_func_heat_Q
  input Real n[8];
  output Real result;
  external "C" result = heatQCalc(n);
  annotation(Include = "#include \"Resources/Loads/Linear_Regression_C/LR_heat_q.c\"");
end ext_func_heat_Q;
