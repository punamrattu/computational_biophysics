#!/usr/bin/python
  

###  Copyright 2023 Punam Rattu ###
###################################################################################
#  This script assigns Wimley-White hydrophobicity score (doi.org/10.1038/nsb1096-842)
#  to residues lining the protein pore, identified using PoreWalker
#  (https://www.ebi.ac.uk/thornton-srv/software/PoreWalker/) 
###################################################################################

###################################################################################
#INSTRUCTIONS#
###################################################################################
#1. Use PoreWalker to identify the pore lining residues in the protein of interest
#2. Convert the output txt file into csv
#3. Change the name of the csv file in this script to match your csv file name
#4. Run script: python pore_lining_hydrophobicity_score.py





import os
import numpy as np
import pandas as pd

df=pd.read_csv('[CSV]')

df["score"] = df["AA"].map(lambda x: "-0.44" if "MET" in x else "0.19" if "GLN" in x else "−0.58" if "PHE" in x else "-0.81" if "ILE" in x else "-0.69" if "LEU" in x else "-0.53" if "VAL" in x else "-0.31" if "PRO" in x else "-0.24" if "TRP" in x else "0.11" if "THR" in x else "1.61" if "GLU" in x else "0.22" if "CYS" in x else "0.23" if "TYR" in x else "0.33" if "ALA" in x else "0.33" if "SER" in x else "0.43" if "ASN" in x else "2.41" if "ASP" in x else "1.00" if "ARG" in x else "1.14" if "GLY" in x else "1.81" if "LYS" in x else "")

# save output
df.to_csv('wimley-white-score-pore-lining.csv')
df.to_csv('wimley-white-score.csv', columns=['Xcoord (CB)','score'])	# save z-coordinate vs. score
