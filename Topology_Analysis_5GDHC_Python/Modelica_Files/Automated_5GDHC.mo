within LinReg_District_Heating_Cooling;
package Automated_5GDHC
  model Test

  replaceable package Medium =
       Buildings.Media.Water "Medium model for water";

    RFBuilding_bidirectional Medium_Office(
      redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{-110.0,90.0},{-90.0,110.0}})));
    RFBuilding_bidirectional Retail(
      redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{90.0,90.0},{110.0,110.0}})));
    RFBuilding_bidirectional Multi-Family(
      redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{-110.0,-110.0},{-90.0,-90.0}})));
    RFBuilding_bidirectional New_District_System(
      redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{90.0,-110.0},{110.0,-90.0}})));

  equation
    connect(Medium_Office.pipeA_1, Retail.portB)
    connect(Medium_Office.pipeA_2, Multi-Family.portB)
    connect(Medium_Office.pipeA_3, New_District_System.portB)
    connect(Retail.pipeA_1, Medium_Office.portB)
    connect(Retail.pipeA_2, Multi-Family.portB)
    connect(Retail.pipeA_3, New_District_System.portB)
    connect(Multi-Family.pipeA_1, Medium_Office.portB)
    connect(Multi-Family.pipeA_2, Retail.portB)
    connect(Multi-Family.pipeA_3, New_District_System.portB)
    connect(New_District_System.pipeA_1, Medium_Office.portB)
    connect(New_District_System.pipeA_2, Retail.portB)
    connect(New_District_System.pipeA_3, Multi-Family.portB)

    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-220,-180},{220,180}})), Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-220,-180},{220,180}})));
  end Test;
end Automated_5GDHC;