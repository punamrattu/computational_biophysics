# Computational Biophysics Repository
A collection of scripts for analysing molecular dynamics simulations of nanopores and DNA translocation. Please reach out to me at punamrattu@gmail.com for queries and help.


|File name|Description|
|---|---|
|`ionic_current_through_pore/count_ion.pl`|Calculates the ionic current through a nanopore, as described by Aksimentiev et al. (https://doi.org/10.1529/biophysj.104.058727).|
|`ionic_current_through_pore/current_mean_sd.py`|Calculates the mean current ± SD through a nanopore.|
|`ionic_current_through_pore/total_cumulative_current.sh`|Calculates cumulative current through a nanopore.|
|`ion_density_map.tcl`|Generates a volumetric map of the average density of an ion group in the simulation box, using VMD volmap plugin.|
|`pore_lining_hydrophobicity_score.py`|Assigns Wimley-White hydrophobicity score to residues lining the protein pore.|
|`translocation_rate_region.sh`|Calculates the translocation rate (nm/ns) of a DNA nucleotide through a pore region, as described by Rattu et al (doi.org/10.1016/j.csbj.2021.11.014).|
|`model_pores/pore_regions_calculator`|Scripts calculate the z-coordinates of regions in the model pores studied in Rattu et al. (https://doi.org/10.1039/D0NR04890A)|


### Citations
If you use any of the code in your work, please cite our relevant papers:
- Rattu P, Glencross F, Mader SL, Skylaris CK, Matthews SJ, Rouse SR, Khalid S. (2021) “Atomistic level characterisation of ssDNA translocation through the E. coli proteins CsgG and CsgF for nanopore sequencing.” Comput. Struct. Biotechnol. J., 19, 6417-6430. https://doi.org/10.1016/j.csbj.2021.11.014
- Rattu P, Belzunces B, Haynes T, Skylaris CK, Khalid S. (2021) “Translocation of flexible and tensioned ssDNA through in silico designed hydrophobic nanopores with two constrictions”. Nanoscale, 13, 1673-1679. https://doi.org/10.1039/d0nr04890a
- Haynes T, Smith IPS, Wallace EJ, Trick JL, Sansom MSP, Khalid S. (2018) “Electric-field driven Translocation of ssDNA through hydrophobic nanopores.” ACS Nano, 12(8), 8208-8213. https://doi.org/10.1021/acsnano.8b03365
- Guy AT, Piggot TJ, Khalid S. (2012) “Single-Stranded DNA within Nanopores: Conformational Dynamics and Implications for Sequencing; a Molecular Dynamics Simulation Study.” Biophys. J., 103(5), 1028-1036. https://doi.org/10.1016/j.bpj.2012.08.012
- Bond PJ, Guy AT , Heron A, Bayley H, Khalid S. (2011) “Molecular dynamics simulations of DNA within a nanopore: arginine-phosphate tethering and a binding/sliding mechanism for translocation.” Biochemistry, 50(18), 3777-3783.


### License 
[GPLv3](https://www.gnu.org/licenses/gpl-3.0.en.html)
