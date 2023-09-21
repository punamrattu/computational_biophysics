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
#  Run script: 14LLx2.sh [pore_structure].gro




for file in $@; do

grep ' 5LEU' $@ > LEU4
grep ' 7LEU' $@ > LEU3
grep ' 11LEU' $@ > LEU2
grep ' 13LEU' $@ > LEU1
grep ' 23LEU' $@ >> LEU1
grep ' 25LEU' $@ >> LEU2
grep ' 29LEU' $@ >> LEU3
grep ' 31LEU' $@ >> LEU4
grep ' 41LEU' $@ >> LEU4
grep ' 43LEU' $@ >> LEU3
grep ' 47LEU' $@ >> LEU2
grep ' 49LEU' $@ >> LEU1
grep ' 59LEU' $@ >> LEU1
grep ' 61LEU' $@ >> LEU2
grep ' 65LEU' $@ >> LEU3
grep ' 67LEU' $@ >> LEU4
grep ' 77LEU' $@ >> LEU4
grep ' 79LEU' $@ >> LEU3
grep ' 83LEU' $@ >> LEU2
grep ' 85LEU' $@ >> LEU1
grep ' 95LEU' $@ >> LEU1
grep ' 97LEU' $@ >> LEU2
grep ' 101LEU' $@ >> LEU3
grep ' 103LEU' $@ >> LEU4
grep ' 113LEU' $@ >> LEU4
grep ' 115LEU' $@ >> LEU3
grep ' 119LEU' $@ >> LEU2
grep ' 121LEU' $@ >> LEU1
grep ' 131LEU' $@ >> LEU1
grep ' 133LEU' $@ >> LEU2
grep ' 137LEU' $@ >> LEU3
grep ' 139LEU' $@ >> LEU4
grep ' 149LEU' $@ >> LEU4
grep ' 151LEU' $@ >> LEU3
grep ' 155LEU' $@ >> LEU2
grep ' 157LEU' $@ >> LEU1
grep ' 167LEU' $@ >> LEU1
grep ' 169LEU' $@ >> LEU2
grep ' 173LEU' $@ >> LEU3
grep ' 175LEU' $@ >> LEU4
grep ' 185LEU' $@ >> LEU4
grep ' 187LEU' $@ >> LEU3
grep ' 191LEU' $@ >> LEU2
grep ' 193LEU' $@ >> LEU1
grep ' 203LEU' $@ >> LEU1
grep ' 205LEU' $@ >> LEU2
grep ' 209LEU' $@ >> LEU3
grep ' 211LEU' $@ >> LEU4
grep ' 221LEU' $@ >> LEU4
grep ' 223LEU' $@ >> LEU3
grep ' 227LEU' $@ >> LEU2
grep ' 229LEU' $@ >> LEU1
grep ' 239LEU' $@ >> LEU1
grep ' 241LEU' $@ >> LEU2
grep ' 245LEU' $@ >> LEU3
grep ' 247LEU' $@ >> LEU4
awk '{print $6}' LEU1 | sort -n > LEU1_sort
awk '{print $6}' LEU2 | sort -n > LEU2_sort
awk '{print $6}' LEU3 | sort -n > LEU3_sort
awk '{print $6}' LEU4 | sort -n > LEU4_sort

a=$(awk '{print $1;}' LEU1_sort | tail -1)
b=$(awk '{print $1;}' LEU2_sort | head -1)
c=$(awk '{print $1;}' LEU3_sort | tail -1)
d=$(awk '{print $1;}' LEU4_sort | head -1)

a1=$(awk '{print $1*10;}' LEU1_sort | tail -1)
b1=$(awk '{print $1*10;}' LEU2_sort | head -1)
c1=$(awk '{print $1*10;}' LEU3_sort | tail -1)
d1=$(awk '{print $1*10;}' LEU4_sort | head -1)

grep 'GLY' $@ > GLY
e=$(awk '{print $6}' GLY | sort -n | head -1)
f=$(awk '{print $6}' GLY | sort -n | tail -1)
e1=$(awk '{print $6*10;}' GLY | sort -n | head -1)
f1=$(awk '{print $6*10;}' GLY | sort -n | tail -1)

grep 'TRP     CA' $@ > TRP
g=$(awk '{print $6}' TRP | sort -n | head -1)
h=$(awk '{print $6}' TRP | sort -n | tail -1)
g1=$(awk '{print $6*10;}' TRP | sort -n | head -1)
h1=$(awk '{print $6*10;}' TRP | sort -n | tail -1)

echo 'lowest' $e > z_ranges.dat
echo 'loop' $g >> z_ranges.dat
echo 'leu_bot_L4' $d >> z_ranges.dat
echo 'leu_bot_L3' $c >> z_ranges.dat
echo 'leu_top_L2' $b >> z_ranges.dat
echo 'leu_top_L1' $a >> z_ranges.dat
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

rm GLY TRP
rm *_sort

done
