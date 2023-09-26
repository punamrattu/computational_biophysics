# Computational Biophysics Repository
A collection of scripts for analysing molecular dynamics simulations. Please reach out to me at punamrattu@gmail.com for queries and help.

### Citations
If you're using any code, please cite our papers:
(include Rattu et al. and relevant papers from Syma Khalid's research group)

### Description of scripts
|File name|Description|
|---|---|
|`ionic_current_through_pore/count_ion.pl`|Calculates the ionic current through a nanopore, as described by Aksimentiev et al. (https://doi.org/10.1529/biophysj.104.058727).|
|`ionic_current_through_pore/current_mean_sd.py`|Calculates the mean current ± SD through a nanopore.|
|`ionic_current_through_pore/total_cumulative_current.sh`|Calculates cumulative current through a nanopore.|
|`ion_density_map.tcl`|Generates a volumetric map of the average density of an ion group in the simulation box, using VMD volmap plugin.|
|`pore_lining_hydrophobicity_score.py`|Assigns Wimley-White hydrophobicity score to residues lining the protein pore.|
|`translocation_rate_region.sh`|Calculates the translocation rate (nm/ns) of a DNA nucleotide through a pore region, as described by Rattu et al (doi.org/10.1016/j.csbj.2021.11.014).|
|`model_pores/pore_regions_calculator`|Scripts calculate the z-coordinates of regions in the model pores studied in Rattu et al. (https://doi.org/10.1039/D0NR04890A)|


### License 
[GPLv3](https://www.gnu.org/licenses/gpl-3.0.en.html)
