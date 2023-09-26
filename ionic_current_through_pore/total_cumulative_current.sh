#!/bin/bash
  

###  Copyright 2023 Punam Rattu ###
##############################################################################
#  This script takes output from count_ion.pl to calculate cumulative current.
##############################################################################





#1. Using output from count_ion.pl; convert time from ps to ns, extract 3rd column containing cumulative current (units of the unitary charge (e = 1.6 × 10−19C))
awk '{print ($1/1000),$3}' current_k.xvg > tmp
awk 'NR % 10 == 0' tmp > cum_current_k.xvg	# add 0 0 at top of cum_current_k.xvg

#2. Perform the same as above for the 2nd ion
awk '{print ($1/1000),($3)}' current_cl.xvg > tmp
awk 'NR % 10 == 0' tmp > cum_current_cl.xvg

#3. Calculate TOTAL CUMULATIVE CURRENT = K+  +  Cl-
awk '{print $2}' cum_current_cl.xvg > tmp
paste cum_current_k.xvg tmp > tmp2
awk '{print $1,($2+$3)}' tmp2 > cum_current_total.xvg

rm tmp tmp2
