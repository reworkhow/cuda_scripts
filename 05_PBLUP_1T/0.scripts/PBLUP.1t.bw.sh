#!/bin/bash

. ./00_config

cd ${RUN}
##Get A inverse based on stacked_ped
invnrm -a -v Ainverse -i $PED -o inbreedings  &

##
awk '{print $1}' $FILE > id.dat &
awk '{print $1}' $PED > id.eff &
awk '{print $3}' $FILE > y &

##fit fixed effect for comtemporary groups and slices

awk '{print $2}' $FILE > cg1.dat &
awk '$2!="."{print $2}' $FILE | sort -u > cg1.eff &
wait

## make incidence matrices
cgen_z -d cg1.dat -e cg1.eff -r y -o X &
cgen_z -d id.dat -e id.eff -r y -o Z &
wait

cmult -t -a X -b X -c XtX &
cmult -t -a X -b Z -c XtZ &
cmult -t -a Z -b X -c ZtX &
cmult -t -a Z -b Z -c ZtZ &
cmult -t -a X -b y -c Xty &
cmult -t -a Z -b y -c Zty &
wait

cadd -a ZtZ -r $lambda -b Ainverse -c ZtZ.L


## solve
pcgbigd -A lhs.map -b rhs.map -o out${TRNAME} -n 500000
