within Topology_Analysis_5GDHC.Loads.Linear_Regression;
function ext_func_cool_P
  input Real n[8];
  output Real result;
  external "C" result = coolPCalc(n);
  annotation(Include = "#include \"Resources/Loads/Linear_Regression_C/LR_cool_p.c\"");
end ext_func_cool_P;
