within Topology_Analysis_5GDHC.Automated_5GDHC;
package Reading_Models
  model Pipe_Test_Reader
    "Pipe with finite volume discretization along flow path"
    extends Buildings.Fluid.FixedResistances.BaseClasses.Pipe(
     diameter=sqrt(4*m_flow_nominal/rho_default/v_nominal/Modelica.Constants.pi),
     dp_nominal=2*dpStraightPipe_nominal,
     preDro(dp(nominal=length*10)));
    // Because dp_nominal is a non-literal value, we set
    // dp.nominal=100 instead of the default dp.nominal=dp_nominal,
    // because the latter is ignored by Dymola 2012 FD 01.

    parameter Modelica.SIunits.Velocity v_nominal = 0.15
      "Velocity at m_flow_nominal (used to compute default diameter)";
    parameter Modelica.SIunits.Length roughness(min=0) = 2.5e-5
      "Absolute roughness of pipe, with a default for a smooth steel pipe (dummy if use_roughness = false)";
    final parameter Modelica.SIunits.PressureDifference dpStraightPipe_nominal(displayUnit="Pa")=
        Modelica.Fluid.Pipes.BaseClasses.WallFriction.Detailed.pressureLoss_m_flow(
        m_flow=m_flow_nominal,
        rho_a=rho_default,
        rho_b=rho_default,
        mu_a=mu_default,
        mu_b=mu_default,
        length=length,
        diameter=diameter,
        roughness=roughness,
        m_flow_small=m_flow_small)
      "Pressure loss of a straight pipe at m_flow_nominal";

    parameter Boolean useMultipleHeatPorts=false
      "= true to use one heat port for each segment of the pipe, false to use a single heat port for the entire pipe";

    Modelica.Thermal.HeatTransfer.Components.ThermalConductor conPipWal[nSeg](
        each G=2*Modelica.Constants.pi*lambdaIns*length/nSeg/Modelica.Math.log((
          diameter/2.0 + thicknessIns)/(diameter/2.0)))
      "Thermal conductance through pipe wall"
      annotation (Placement(transformation(extent={{-28,-38},{-8,-18}})));
    Modelica.Thermal.HeatTransfer.Components.ThermalCollector colAllToOne(m=nSeg) if
         not useMultipleHeatPorts
      "Connector to assign multiple heat ports to one heat port" annotation (
        Placement(transformation(
          extent={{-6,-6},{6,6}},
          rotation=180,
          origin={-50,10})));

    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if not
      useMultipleHeatPorts
      "Single heat port that connects to outside of pipe wall (default, enabled when useMultipleHeatPorts=false)"
      annotation (Placement(transformation(extent={{-10,40},{10,20}}),
          iconTransformation(extent={{-10,60},{10,40}})));
    Modelica.Fluid.Interfaces.HeatPorts_a heatPorts[nSeg] if
         useMultipleHeatPorts
      "Multiple heat ports that connect to outside of pipe wall (enabled if useMultipleHeatPorts=true)"
      annotation (Placement(transformation(extent={{-10,-70},{11,-50}}),
          iconTransformation(extent={{-30,-60},{30,-40}})));
  equation
    connect(conPipWal.port_b, vol.heatPort) annotation (Line(
        points={{-8,-28},{-1,-28}},
        color={191,0,0},
        smooth=Smooth.None));
    if useMultipleHeatPorts then
      connect(heatPorts, conPipWal.port_a) annotation (Line(
          points={{0.5,-60},{-50,-60},{-50,-28},{-28,-28}},
          color={191,0,0},
          smooth=Smooth.None));
    else
      connect(colAllToOne.port_a, conPipWal.port_a) annotation (Line(
          points={{-50,4},{-50,-28},{-28,-28}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(colAllToOne.port_b, heatPort) annotation (Line(
          points={{-50,16},{-50,30},{5.55112e-16,30}},
          color={191,0,0},
          smooth=Smooth.None));

    end if;
    annotation (
      defaultComponentName="pip",
      Documentation(info="<html>
<p>
Model of a pipe with flow resistance and optional heat exchange with environment.
</p>
<h4>Heat loss calculation</h4>
<p>
There are two possible configurations:
</p>
<ol>
<li>
If <code>useMultipleHeatPorts=false</code> (default option), the pipe uses a single heat port
for the heat exchange with the environment. Note that if the heat port
is unconnected, then all volumes are still connected through the heat conduction elements
<code>conPipWal</code>.
Therefore, they exchange a small amount of heat, which is not physical.
To avoid this, set <code>useMultipleHeatPorts=true</code>.
</li>
<li>
If <code>useMultipleHeatPorts=true</code>,
then one heat port for each segment of the pipe is
used for the heat exchange with the environment.
If the heat port is unconnected, then the pipe has no heat loss.
</li>
</ol>
<h4>Pressure drop calculation</h4>
<p>
The default value for the parameter <code>diameter</code> is computed such that the flow velocity
is equal to <code>v_nominal=0.15</code> for a mass flow rate of <code>m_flow_nominal</code>.
Both parameters, <code>diameter</code> and <code>v_nominal</code>, can be overwritten
by the user.
The default value for <code>dp_nominal</code> is two times the pressure drop that the pipe
would have if it were straight with no fittings.
The factor of two that takes into account the pressure loss of fittings can be overwritten.
These fittings could also be explicitly modeled outside of this component using models from
the package
<a href=\"modelica://Modelica.Fluid.Fittings\">
Modelica.Fluid.Fittings</a>.
For mass flow rates other than <code>m_flow_nominal</code>, the model
<a href=\"modelica://Buildings.Fluid.FixedResistances.PressureDrop\">
Buildings.Fluid.FixedResistances.PressureDrop</a> is used to
compute the pressure drop.
</p>
<p>
For a steady-state model of a flow resistance, use
<a href=\"modelica://Buildings.Fluid.FixedResistances.PressureDrop\">
Buildings.Fluid.FixedResistances.PressureDrop</a> instead of this model.
</p>
</html>",   revisions="<html>
<ul>
<li>
January 22, 2016, by Michael Wetter:<br/>
Corrected type declaration of pressure difference.
This is
for <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/404\">#404</a>.
</li>
<li>
October 30, 2015, by Michael Wetter:<br/>
Improved documentation for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/455\">#455</a>.
</li>
<li>
February 5, 2015, by Michael Wetter:<br/>
Renamed <code>res</code> to <code>preDro</code> for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/292\">#292</a>.
</li>
<li>
September 13, 2013 by Michael Wetter:<br/>
Replaced <code>nominal</code> with <code>default</code> values
as they are computed using the default Medium values.
</li>
<li>
February 22, 2012 by Michael Wetter:<br/>
Renamed <code>useMultipleHeatPort</code> to <code>useMultipleHeatPorts</code> and
used heat port connector from <code>Modelica.Fluid</code> package for vector of heat ports.
</li>
<li>
February 15, 2012 by Michael Wetter:<br/>
Revised implementation and added default values.
</li>
<li>
February 12, 2012 by Wangda Zuo:<br/>
First implementation.
</li>
</ul>
</html>"));
  end Pipe_Test_Reader;

  model Boundary_pT_Test_Reader
    "Boundary with prescribed pressure, temperature, composition and trace substances"
    extends Modelica.Fluid.Sources.BaseClasses.PartialSource;
    parameter Boolean use_p_in = false
      "Get the pressure from the input connector"
      annotation(Evaluate=true, HideResult=true);
    parameter Boolean use_T_in= false
      "Get the temperature from the input connector"
      annotation(Evaluate=true, HideResult=true);
    parameter Boolean use_X_in = false
      "Get the composition from the input connector"
      annotation(Evaluate=true, HideResult=true);
    parameter Boolean use_C_in = false
      "Get the trace substances from the input connector"
      annotation(Evaluate=true, HideResult=true);

    parameter Medium.AbsolutePressure p = Medium.p_default
      "Fixed value of pressure"
      annotation (Dialog(enable = not use_p_in));
    parameter Medium.Temperature T = Medium.T_default
      "Fixed value of temperature"
      annotation (Dialog(enable = not use_T_in));
    parameter Medium.MassFraction X[Medium.nX](
      final quantity=Medium.substanceNames) = Medium.X_default
      "Fixed value of composition"
      annotation (Dialog(enable = (not use_X_in) and Medium.nXi > 0));
    parameter Medium.ExtraProperty C[Medium.nC](
      final quantity=Medium.extraPropertiesNames) = fill(0, Medium.nC)
      "Fixed values of trace substances"
      annotation (Dialog(enable = (not use_C_in) and Medium.nC > 0));
    Modelica.Blocks.Interfaces.RealInput p_in(final unit="Pa") if use_p_in
      "Prescribed boundary pressure"
      annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
    Modelica.Blocks.Interfaces.RealInput T_in(final unit="K",
                                              displayUnit="degC") if use_T_in
      "Prescribed boundary temperature"
      annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
    Modelica.Blocks.Interfaces.RealInput X_in[Medium.nX](
      each final unit = "kg/kg",
      final quantity=Medium.substanceNames) if use_X_in
      "Prescribed boundary composition"
      annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
    Modelica.Blocks.Interfaces.RealInput C_in[Medium.nC](
      final quantity=Medium.extraPropertiesNames) if use_C_in
      "Prescribed boundary trace substances"
      annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
  protected
    Modelica.Blocks.Interfaces.RealInput p_in_internal(final unit="Pa")
      "Needed to connect to conditional connector";
    Modelica.Blocks.Interfaces.RealInput T_in_internal(final unit="K",
                                                       displayUnit="degC")
      "Needed to connect to conditional connector";
    Modelica.Blocks.Interfaces.RealInput X_in_internal[Medium.nX](
      each final unit = "kg/kg",
      final quantity=Medium.substanceNames)
      "Needed to connect to conditional connector";
    Modelica.Blocks.Interfaces.RealInput C_in_internal[Medium.nC](
      final quantity=Medium.extraPropertiesNames)
      "Needed to connect to conditional connector";

  initial equation
    if not use_X_in then
      Modelica.Fluid.Utilities.checkBoundary(Medium.mediumName, Medium.substanceNames,
        Medium.singleState, true, X_in_internal, "Boundary_pT");
    end if;

  equation
    if use_X_in then
      Modelica.Fluid.Utilities.checkBoundary(Medium.mediumName, Medium.substanceNames,
        Medium.singleState, true, X_in_internal, "Boundary_pT");
    end if;
    connect(p_in, p_in_internal);
    connect(T_in, T_in_internal);
    connect(X_in, X_in_internal);
    connect(C_in, C_in_internal);
    if not use_p_in then
      p_in_internal = p;
    end if;
    if not use_T_in then
      T_in_internal = T;
    end if;
    if not use_X_in then
      X_in_internal = X;
    end if;
    if not use_C_in then
      C_in_internal = C;
    end if;
    medium.p = p_in_internal;
    medium.T = T_in_internal;
    medium.Xi = X_in_internal[1:Medium.nXi];
    ports.C_outflow = fill(C_in_internal, nPorts);
    annotation (defaultComponentName="bou",
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Ellipse(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Sphere,
            fillColor={0,127,255}),
          Text(
            extent={{-150,110},{150,150}},
            textString="%name",
            lineColor={0,0,255}),
          Line(
            visible=use_p_in,
            points={{-100,80},{-58,80}},
            color={0,0,255}),
          Line(
            visible=use_T_in,
            points={{-100,40},{-92,40}},
            color={0,0,255}),
          Line(
            visible=use_X_in,
            points={{-100,-40},{-92,-40}},
            color={0,0,255}),
          Line(
            visible=use_C_in,
            points={{-100,-80},{-60,-80}},
            color={0,0,255}),
          Text(
            visible=use_p_in,
            extent={{-152,134},{-68,94}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="p"),
          Text(
            visible=use_X_in,
            extent={{-164,4},{-62,-36}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="X"),
          Text(
            visible=use_C_in,
            extent={{-164,-90},{-62,-130}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="C"),
          Text(
            visible=use_T_in,
            extent={{-162,34},{-60,-6}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="T")}),
      Documentation(info="<html>
<p>
Defines prescribed values for boundary conditions:
</p>
<ul>
<li> Prescribed boundary pressure.</li>
<li> Prescribed boundary temperature.</li>
<li> Boundary composition (only for multi-substance or trace-substance flow).</li>
</ul>
<p>If <code>use_p_in</code> is false (default option), the <code>p</code> parameter
is used as boundary pressure, and the <code>p_in</code> input connector is disabled; if <code>use_p_in</code> is true, then the <code>p</code> parameter is ignored, and the value provided by the input connector is used instead.</p>
<p>The same applies to the temperature, composition and trace substances.</p>
<p>
Note, that boundary temperature,
mass fractions and trace substances have only an effect if the mass flow
is from the boundary into the port. If mass is flowing from
the port into the boundary, the boundary definitions,
with exception of boundary pressure, do not have an effect.
</p>
</html>",
  revisions="<html>
<ul>
<li>
April 18, 2017, by Filip Jorissen:<br/>
Changed <code>checkBoundary</code> implementation
such that it is run as an initial equation
when it depends on parameters only.
See <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/728\">#728</a>.
</li>
<li>
January 26, 2016, by Michael Wetter:<br/>
Added <code>unit</code> and <code>quantity</code> attributes.
</li>
<li>
May 29, 2014, by Michael Wetter:<br/>
Removed undesirable annotation <code>Evaluate=true</code>.
</li>
<li>
September 29, 2009, by Michael Wetter:<br/>
First implementation.
Implementation is based on <code>Modelica.Fluid</code>.
</li>
</ul>
</html>"));
  end Boundary_pT_Test_Reader;
end Reading_Models;
