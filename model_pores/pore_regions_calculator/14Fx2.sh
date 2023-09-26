#!/bin/bash


###  Copyright 2023 Punam Rattu ###
  
###################################################################################
#  This script calculate the z-coordinates of regions in the model pores studied
#  in Rattu et al., Nanoscale, 2021. This useful to determine e.g. when DNA exits 
#  a pore region.
#
#  Pore regions:
#       pore entrance-constriction 1 entrance
#       constriction 1 entrance-exit
#       constriction 1 exit-constriction 2 entrance
#       constriction 2 entrance-exit
#       constriction 2 exit-pore exit
#
#  Run script: 14Fx2.sh [pore_structure].gro




for file in $@; do
grep ' 5PHE' $@ > PHE2
grep ' 13PHE' $@ > PHE1
grep ' 23PHE' $@ >> PHE1
grep ' 31PHE' $@ >> PHE2
grep ' 41PHE' $@ >> PHE2
grep ' 49PHE' $@ >> PHE1
grep ' 59PHE' $@ >> PHE1
grep ' 67PHE' $@ >> PHE2
grep ' 77PHE' $@ >> PHE2
grep ' 85PHE' $@ >> PHE1
grep ' 95PHE' $@ >> PHE1
grep ' 103PHE' $@ >> PHE2
grep ' 113PHE' $@ >> PHE2
grep ' 121PHE' $@ >> PHE1
grep ' 131PHE' $@ >> PHE1
grep ' 139PHE' $@ >> PHE2
grep ' 149PHE' $@ >> PHE2
grep ' 157PHE' $@ >> PHE1
grep ' 167PHE' $@ >> PHE1
grep ' 175PHE' $@ >> PHE2
grep ' 185PHE' $@ >> PHE2
grep ' 193PHE' $@ >> PHE1
grep ' 203PHE' $@ >> PHE1
grep ' 211PHE' $@ >> PHE2
grep ' 221PHE' $@ >> PHE2
grep ' 229PHE' $@ >> PHE1
grep ' 239PHE' $@ >> PHE1
 
a=$(awk '{print $6}' PHE1 | sort -n | tail -1)
b=$(awk '{print $6}' PHE1 | sort -n | head -1)
c=$(awk '{print $6}' PHE2 | sort -n | tail -1)
d=$(awk '{print $6}' PHE2 | sort -n | head -1)
a1=$(awk '{print $6*10}' PHE1 | sort -n | tail -1)
b1=$(awk '{print $6*10}' PHE1 | sort -n | head -1)
c1=$(awk '{print $6*10}' PHE2 | sort -n | tail -1)
d1=$(awk '{print $6*10}' PHE2 | sort -n | head -1)

grep 'GLY' $@ > GLY
e=$(awk '{print $6}' GLY | sort -n | head -1)
f=$(awk '{print $6}' GLY | sort -n | tail -1)
grep 'TRP     CA' $@ > TRP
g=$(awk '{print $6}' TRP | sort -n | head -1)
h=$(awk '{print $6}' TRP | sort -n | tail -1)

e1=$(awk '{print $6*10}' GLY | sort -n | head -1)
f1=$(awk '{print $6*10}' GLY | sort -n | tail -1)
g1=$(awk '{print $6*10}' TRP | sort -n | head -1)
h1=$(awk '{print $6*10}' TRP | sort -n | tail -1)

echo 'lowest' $e > z_ranges.dat
echo 'loop' $g >> z_ranges.dat
echo 'phe_bot' $d >> z_ranges.dat
echo 'phe_bot' $c >> z_ranges.dat
echo 'phe_top' $b >> z_ranges.dat
echo 'phe_top' $a >> z_ranges.dat
echo 'loop' $h >> z_ranges.dat
echo 'highest' $f >> z_ranges.dat

echo $e1 >> z_ranges.dat
echo $g1 >> z_ranges.dat
echo $d1 >> z_ranges.dat
echo $c1 >> z_ranges.dat
echo $b1 >> z_ranges.dat
echo $a1 >> z_ranges.dat
echo $h1 >> z_ranges.dat
echo $f1 >> z_ranges.dat

rm GLY TRP PHE*

done
