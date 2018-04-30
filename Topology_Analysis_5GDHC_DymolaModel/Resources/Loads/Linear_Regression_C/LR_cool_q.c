double coolQCalc(double x[8])
{
	double b[8];
	double q = 0;
	int i = 0;
	b[0]=-12257.1655-18000;	//const
	b[1]=53.8318;		//weekday
	b[2]=-152.5444;		//hour	
	b[3]=648.2771;		//month
	b[4]=0;			//m_flow
	b[5]=23.2287;		//t_Inlet
	b[6]=61.9153;		//hum_out
	b[7]=751.7141;		//t_out

	for(i=0;i<=8;i++){
		q = q + b[i]*x[i];
	}

	return q;
	 
}

//y = -12257.1655 + 53.8318 * Day.of.Week - 152.5444 * Hour + 648.2771 * Month + 23.2287 * ETS.Cooling.Inlet.Temperature + 61.9153 * Site.Outdoor.Air.Relative.Humidity + 751.7141 * Site.Outdoor.Air.Drybulb.Temperature





