double coolPCalc(double x[8])
{
	double b[8];
	double p = 0;
	int i = 0;
	b[0]=-3346.507;		//const
	b[1]=12.8881;		//weekday
	b[2]=-35.4752;		//hour	
	b[3]=135.2198;		//month
	b[4]=0;			//m_flow
	b[5]=53.0833;		//t_Inlet
	b[6]=12.2738;		//hum_out
	b[7]=154.0731;		//t_out

	for(i=0;i<=8;i++){
		p = p + b[i]*x[i];
	}

	return p;
}

//y = -3346.507 + 12.8881 * Day.of.Week - 35.4752 * Hour + 135.2198 * Month + 53.0833 * ETS.Cooling.Inlet.Temperature + 12.2738 * Site.Outdoor.Air.Relative.Humidity + 154.0731 * Site.Outdoor.Air.Drybulb.Temperature

