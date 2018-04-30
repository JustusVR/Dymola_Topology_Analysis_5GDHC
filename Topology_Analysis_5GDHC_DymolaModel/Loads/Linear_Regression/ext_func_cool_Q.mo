within Topology_Analysis_5GDHC_DymolaModel.Loads.Linear_Regression;
function ext_func_cool_Q
  input Real n[8];
  output Real result;
  external "C" result = coolQCalc(n);
  annotation(Include = "#include \"Resources/Loads/Linear_Regression_C/LR_cool_q.c\"");
end ext_func_cool_Q;
