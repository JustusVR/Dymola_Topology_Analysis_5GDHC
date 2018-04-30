double coolTempCalc(double x[8])
{
	double b[8];
	double t = 0;
	int i = 0;
	b[0]=5.6342;		//const
	b[1]=-0.0228;		//weekday
	b[2]=0.0378;		//hour	
	b[3]=0.021;		//month
	b[4]=0;			//m_flow
	b[5]=0.9729;		//t_Inlet
	b[6]=0.0086;		//hum_out
	b[7]=0.0243;		//t_out

	for(i=0;i<=8;i++){
		t = t + b[i]*x[i];
	}

	return t;
}

//y = 5.6342 - 0.0228 * Day.of.Week + 0.0378 * Hour + 0.021 * Month + 0.9729 * ETS.Cooling.Inlet.Temperature + 0.0086 * Site.Outdoor.Air.Relative.Humidity + 0.0243 * Site.Outdoor.Air.Drybulb.Temperature

