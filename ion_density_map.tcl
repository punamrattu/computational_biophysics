###################################################################################
#  This script generates a volumetric map of the average density of an ion group
#  in the simulation box, using VMD volmap plugin
#  (https://www.ks.uiuc.edu/Research/vmd/vmd-1.9.1/ug/node153.html).
#  
#  Please cite VMD: Humphrey, W., Dalke, A. and Schulten, K., "VMD - Visual Molecular 
#  Dynamics", J. Molec. Graphics, 1996, vol. 14, pp. 33-38.
###################################################################################

###################################################################################
#INSTRUCTIONS#
###################################################################################
#1. Change the name of the pdb file [PDB] and xtc file [XTC] to match the name of your files
#2. Change the name of the ion [ION] to match the name of the ion in your pdb file
#3. Change [ion] to the ion name equivalent to VMD nomenclature. E.g. chloride = cl




mol load pdb   [PDB].pdb
mol addfile [XTC].xtc step 1  waitfor all

set [ion] [atomselect top "name [ION]"]
volmap density $[ion] -res 1.0 -radscale 1.0  -allframes -combine avg -o ion_nr_density_avg.dx

quit
 
