double heatQCalc(double x[8])
{
    double b[8];
    double q = 0;
    int i = 0;
    b[0]=1973.8078 + 4500;	//const
    b[1]=172.6118;	//weekday
    b[2]=-151.6997;	//hour	
    b[3]=12.6559;	//month
    b[4]=0;		//m_flow
    b[5]=5.4608;	//t_Inlet
    b[6]=23.1498;	//hum_out
    b[7]=153.9349;	//t_out
 
    for(i=0;i<=8;i++){
        q = q + b[i]*x[i];
    }

    return q;
 
}

//y = 1973.8078 + 172.6118 * Day.of.Week - 151.6997 * Hour + 12.6559 * Month + 5.4608 * ETS.Heating.Inlet.Temperature + 23.1498 * Site.Outdoor.Air.Relative.Humidity - 153.9349 * Site.Outdoor.Air.Drybulb.Temperature

