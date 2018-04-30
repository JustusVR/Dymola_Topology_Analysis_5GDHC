double heatPCalc(double x[8])
{
	double b[8];
	double p = 0;
	int i = 0;
	b[0]=994.4124;		//const
	b[1]=66.7801;		//weekday
	b[2]=-60.8762;		//hour	
	b[3]=5.7464;		//month
	b[4]=0;			//m_flow
	b[5]=-6.4541;		//t_Inlet
	b[6]=8.7186;		//hum_out
	b[7]=-59.9856;		//t_out

	for(i=0;i<=8;i++){
		p = p + b[i]*x[i];
	}

	return p;
}


//y = 994.4124 + 66.7801 * Day.of.Week - 60.8762 * Hour + 5.7464 * Month - 6.4541 * ETS.Heating.Inlet.Temperature + 8.7186 * Site.Outdoor.Air.Relative.Humidity - 59.9856 * Site.Outdoor.Air.Drybulb.Temperature


