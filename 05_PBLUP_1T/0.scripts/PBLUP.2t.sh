#!/bin/bash

. ./00_config

cnewr -R R -r ${VCdir}/resid y1 y2

# Fixed effect on y1
cmult -t -a X1 -b X1 -R R11 -c X1RX1
cmult -t -a X1 -b X2 -R R12 -c X1RX2
cmult -t -a X1 -b Z1 -R R11 -c X1RZ1
cmult -t -a X1 -b Z2 -R R12 -c X1RZ2

# Fixed effect on y2
cmult -t -a X2 -b X1 -R R12 -c X2RX1
cmult -t -a X2 -b X2 -R R22 -c X2RX2
cmult -t -a X2 -b Z1 -R R12 -c X2RZ1
cmult -t -a X2 -b Z2 -R R22 -c X2RZ2

