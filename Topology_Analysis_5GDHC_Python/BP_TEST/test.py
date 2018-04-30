#!/usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import absolute_import
from __future__ import division
from __future__ import print_function
from __future__ import unicode_literals
from io import open

from multiprocessing import Pool
import buildingspy.simulate.Simulator as si


# Function to set common parameters and to run the simulation
def simulateCase(s):
    ''' Set common parameters and run a simulation.

    :param s: A simulator object.

    '''
    s.setStopTime((3600*24*1))
    # Kill the process if it does not finish in 10 minute
    s.setTimeOut(60 * 10)
    s.showProgressBar(False)
    s.printModelAndTime()
    s.simulate()


def main():
    ''' Main method that configures and runs all simulations
    '''
    import shutil
    # Build list of cases to run
    #print 'hi'
    li = []
    model = 'Topology_Analysis_5GDHC.Automated_5GDHC.Test'
    s = si.Simulator(model, 'dymola', 'case1')
    s.addParameters({'Office4.connected': False})


    li.append(s)
    
    # Run all cases in parallel
    po = Pool()
    po.map(simulateCase, li)

    # Clean up
    #shutil.rmtree('case1')

# Main function
if __name__ == '__main__':
    main()

