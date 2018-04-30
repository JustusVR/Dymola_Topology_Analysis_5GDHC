#!/usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import absolute_import
from __future__ import division
from __future__ import print_function
from __future__ import unicode_literals
from io import open

from multiprocessing import Pool
import buildingspy.simulate.Simulator as si

import Topology_analysis as ta
import shutil


# Function to set common parameters and to run the simulation
def simulateCase(s):
    ''' Set common parameters and run a simulation.

    :param s: A simulator object.

    '''
    s.setStopTime((3600*24*100))
    # Kill the process if it does not finish in 10 minute
    s.setTimeOut(60 * 10)
    s.showProgressBar(False)
    s.printModelAndTime()
    s.simulate()


def main():
    li = []
    model = 'Topology_Analysis_5GDHC.Automated_5GDHC.Test'
    i = 0
    scenarios = ta.SetSimulations()
    for activeBuildings in scenarios:
	    for scenario in activeBuildings[3]:
	    	i += 1
	    	name = "case" + str(i)
	    	s = si.Simulator(model, 'dymola', name)
	    	for parameters in scenario:
	    		#print (parameters)
	    		s.addParameters({parameters[0]: parameters[1]})
            	li.append(s)
    
    # Run all cases in parallel
    po = Pool()
    po.map(simulateCase, li)

    # Clean up
    #shutil.rmtree('case1')

# Main function
if __name__ == '__main__':
    main()


