#!/bin/bash
  

###  Copyright 2023 Punam Rattu ###
#########################################################################
#  This script calculates the translocation rate (nm/ns) of 1 DNA nucleo-
#  tide through a region of the pore, as described by Rattu et al. 
#  (doi.org/10.1016/j.csbj.2021.11.014). The translocation of the
#  DNA strand can be calculated as the average of the translocation rate
#  of all DNA nucleotides in the strand.
#
#  This script uses the z-coordinate of the center of mass (COM) of a DNA
#  nucleotide over time. It calculates the duration (ns) that the nucleotide 
#  resides in the pore region (exit time - entry time). The translocation
#  rate = z-length of region (nm)/duration (ns).
#########################################################################

#########################################################################
#INSTRUCTIONS#
#########################################################################
#1. Prepare input file [FILE], containing the z-coordinate (nm) of the center of mass (COM) of a DNA nucleotide over time (nm)
#2. Change the z-coordinates of the boundaries of the pore regions
#3. Run script: python translocation_rate_region.sh [FILE] 




for file in $@; do



#define boundaries of regions for which to calculate translocation rate (z-coordinate in nm)
#e.g. for CsgG-CsgF complex:
# a = CsgG F56
# b = CsgG Y51
# c = CsgF N17
# d = CsgG Y196
#regions: a-b, b-c, c-d

a=0.28
b=-0.68
c=-2.8
d=-4.75

#time at which nucleotide crosses boundary (enters/exits a region)
v=$(awk -v a="$a" '{if ($2 <= a) {print $1;} }' $@ | head -1)
w=$(awk -v b="$b" '{if ($2 <= b) {print $1;} }' $@ | head -1)
x=$(awk -v c="$c" '{if ($2 <= c) {print $1;} }' $@ | head -1)
y=$(awk -v d="$d" '{if ($2 <= d) {print $1;} }' $@ | head -1)

#if nucleotide does not enter a region, set time to end of simulation (ns) and set boundary to z-coord at end of sim (ns)
if [ -z "$v" ]; then v1=70; a=$(awk '{print $2}' $@ | tail -1); else v1=$v; fi
v1=$(echo $v1)
if [ -z "$w" ]; then w1=70; b=$(awk '{print $2}' $@ | tail -1); else w1=$w; fi
w1=$(echo $w1)
if [ -z "$x" ]; then x1=70; c=$(awk '{print $2}' $@ | tail -1); else x1=$x; fi
x1=$(echo $x1)
if [ -z "$y" ]; then y1=70; d=$(awk '{print $2}' $@ | tail -1); else y1=$y; fi
y1=$(echo $y1)

#duration spent by nucleotide in region (ns)
region1 = $(python -c "import numpy as np; w1=$w1; v1=$v1; z=w1-v1; print(z)")
region2 = $(python -c "import numpy as np; w1=$w1; x1=$x1; z=x1-w1; print(z)")
region3 = $(python -c "import numpy as np; y1=$y1; x1=$x1; z=y1-x1; print(z)")

#distance between residues - length of the region (nm)
distance1 = $(python -c "import numpy as np; b=$b; a=$a; z=a-b; print(z)")
distance2 = $(python -c "import numpy as np; c=$c; b=$b; z=b-c; print(z)")
distance3 = $(python -c "import numpy as np; d=$d; c=$c; z=c-d; print(z)")

#translocation rate of nucleotide in pore regions (nm/ns)
rate1=$(python -c "import numpy as np; distance1=$distance1; region1=$region1; z=distance1/region1; print(z)")
rate2=$(python -c "import numpy as np; distance2=$distance2; region2=$region2; z=distance2/region2; print(z)")
rate3=$(python -c "import numpy as np; distance3=$distance3; region3=$region3; z=distance3/region3; print(z)")

echo "pore region, nucleotide rate (nm/ns)" > rate_$@
echo "region1" $rate1 >> rate_$@
echo "region2" $rate2 >> rate_$@
echo "region3" $rate3 >> rate_$@

echo $@ $rate1 >> rate-region1
echo $@ $rate2 >> rate-region2
echo $@ $rate3 >> rate-region3

done
