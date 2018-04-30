double heatTempCalc(double x[8])
{
	double b[8];
	double t = 0;
	int i = 0;
	b[0]=-2.0696;		//const
	b[1]=-0.0207;		//weekday
	b[2]=-0.0015;		//hour	
	b[3]=-0.0043;		//month
	b[4]=0;			//m_flow
	b[5]=0.927;		//t_Inlet
	b[6]=-0.0054;		//hum_out
	b[7]=0.0216;		//t_out

	for(i=0;i<=8;i++){
		t = t + b[i]*x[i];
	}

	return t;
}

//y = -2.0696 - 0.0207 * Day.of.Week - 0.0015 * Hour - 0.0043 * Month + 0.927 * ETS.Heating.Inlet.Temperature - 0.0054 * Site.Outdoor.Air.Relative.Humidity + 0.0216 * Site.Outdoor.Air.Drybulb.Temperature

