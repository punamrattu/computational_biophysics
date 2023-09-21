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
#  Run script: 16WWx2.sh [pore_structure].gro




for file in $@; do

grep ' 15TRP' $@ > TRP1
grep ' 55TRP' $@ >> TRP1
grep ' 95TRP' $@ >> TRP1
grep ' 135TRP' $@ >> TRP1
grep ' 175TRP' $@ >> TRP1
grep ' 215TRP' $@ >> TRP1
grep ' 255TRP' $@ >> TRP1
grep ' 295TRP' $@ >> TRP1

grep ' 27TRP' $@ > TRP2
grep ' 67TRP' $@ >> TRP2
grep ' 107TRP' $@ >> TRP2
grep ' 147TRP' $@ >> TRP2
grep ' 187TRP' $@ >> TRP2
grep ' 227TRP' $@ >> TRP2
grep ' 267TRP' $@ >> TRP2
grep ' 307TRP' $@ >> TRP2

grep ' 7TRP' $@ > TRP3
grep ' 47TRP' $@ >> TRP3
grep ' 87TRP' $@ >> TRP3
grep ' 127TRP' $@ >> TRP3
grep ' 167TRP' $@ >> TRP3
grep ' 207TRP' $@ >> TRP3
grep ' 247TRP' $@ >> TRP3
grep ' 287TRP' $@ >> TRP3

grep ' 35TRP' $@ > TRP4
grep ' 75TRP' $@ >> TRP4
grep ' 115TRP' $@ >> TRP4
grep ' 155TRP' $@ >> TRP4
grep ' 195TRP' $@ >> TRP4
grep ' 235TRP' $@ >> TRP4
grep ' 275TRP' $@ >> TRP4
grep ' 315TRP' $@ >> TRP4

awk '{print $6}' TRP1 | sort -n > TRP1_sort
awk '{print $6}' TRP2 | sort -n > TRP2_sort
awk '{print $6}' TRP3 | sort -n > TRP3_sort
awk '{print $6}' TRP4 | sort -n > TRP4_sort

a=$(awk '{print $1;}' TRP1_sort | tail -1)
b=$(awk '{print $1;}' TRP2_sort | head -1)
c=$(awk '{print $1;}' TRP3_sort | tail -1)
d=$(awk '{print $1;}' TRP4_sort | head -1)

a1=$(awk '{print $1*10;}' TRP1_sort | tail -1)
b1=$(awk '{print $1*10;}' TRP2_sort | head -1)
c1=$(awk '{print $1*10;}' TRP3_sort | tail -1)
d1=$(awk '{print $1*10;}' TRP4_sort | head -1)

grep 'ALA' $@ > VAL
e=$(awk '{print $6}' VAL | sort -n | head -1)
f=$(awk '{print $6}' VAL | sort -n | tail -1)
e1=$(awk '{print $6*10}' VAL | sort -n | head -1)
f1=$(awk '{print $6*10}' VAL | sort -n | tail -1)

grep 'SER' $@ > VAL
g=$(awk '{print $6}' VAL | sort -n | head -1)
h=$(awk '{print $6}' VAL | sort -n | tail -1)
g1=$(awk '{print $6*10}' VAL | sort -n | head -1)
h1=$(awk '{print $6*10}' VAL | sort -n | tail -1)

echo 'lowest' $g > z_ranges.dat
echo 'ala' $e >> z_ranges.dat
echo 'trp_bot_L4' $d >> z_ranges.dat
echo 'trp_bot_L3' $c >> z_ranges.dat
echo 'trp_top_L2' $b >> z_ranges.dat
echo 'trp_top_L1' $a >> z_ranges.dat
echo 'ala' $f >> z_ranges.dat
echo 'highest' $h >> z_ranges.dat

echo $g1 >> z_ranges.dat
echo $e1 >> z_ranges.dat
echo $d1 >> z_ranges.dat
echo $c1 >> z_ranges.dat
echo $b1 >> z_ranges.dat
echo $a1 >> z_ranges.dat
echo $f1 >> z_ranges.dat
echo $h1 >> z_ranges.dat

rm VAL
rm *_sort

done
