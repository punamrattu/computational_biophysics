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
#  Run script: 16FFx2.sh [pore_structure].gro




for file in $@; do

grep ' 15PHE' $@ > PHE1
grep ' 55PHE' $@ >> PHE1
grep ' 95PHE' $@ >> PHE1
grep ' 135PHE' $@ >> PHE1
grep ' 175PHE' $@ >> PHE1
grep ' 215PHE' $@ >> PHE1
grep ' 255PHE' $@ >> PHE1
grep ' 295PHE' $@ >> PHE1

grep ' 27PHE' $@ > PHE2
grep ' 67PHE' $@ >> PHE2
grep ' 107PHE' $@ >> PHE2
grep ' 147PHE' $@ >> PHE2
grep ' 187PHE' $@ >> PHE2
grep ' 227PHE' $@ >> PHE2
grep ' 267PHE' $@ >> PHE2
grep ' 307PHE' $@ >> PHE2

grep ' 7PHE' $@ > PHE3
grep ' 47PHE' $@ >> PHE3
grep ' 87PHE' $@ >> PHE3
grep ' 127PHE' $@ >> PHE3
grep ' 167PHE' $@ >> PHE3
grep ' 207PHE' $@ >> PHE3
grep ' 247PHE' $@ >> PHE3
grep ' 287PHE' $@ >> PHE3

grep ' 35PHE' $@ > PHE4
grep ' 75PHE' $@ >> PHE4
grep ' 115PHE' $@ >> PHE4
grep ' 155PHE' $@ >> PHE4
grep ' 195PHE' $@ >> PHE4
grep ' 235PHE' $@ >> PHE4
grep ' 275PHE' $@ >> PHE4
grep ' 315PHE' $@ >> PHE4

awk '{print $6}' PHE1 | sort -n > PHE1_sort
awk '{print $6}' PHE2 | sort -n > PHE2_sort
awk '{print $6}' PHE3 | sort -n > PHE3_sort
awk '{print $6}' PHE4 | sort -n > PHE4_sort

a=$(awk '{print $1;}' PHE1_sort | tail -1)
b=$(awk '{print $1;}' PHE2_sort | head -1)
c=$(awk '{print $1;}' PHE3_sort | tail -1)
d=$(awk '{print $1;}' PHE4_sort | head -1)

a1=$(awk '{print $1*10;}' PHE1_sort | tail -1)
b1=$(awk '{print $1*10;}' PHE2_sort | head -1)
c1=$(awk '{print $1*10;}' PHE3_sort | tail -1)
d1=$(awk '{print $1*10;}' PHE4_sort | head -1)

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
echo 'phe_bot_L4' $d >> z_ranges.dat
echo 'phe_bot_L3' $c >> z_ranges.dat
echo 'phe_top_L2' $b >> z_ranges.dat
echo 'phe_top_L1' $a >> z_ranges.dat
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
