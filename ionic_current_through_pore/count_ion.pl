#! /usr/bin/perl -w


#########################################################################
#  This script calculates the ionic current through a pore as described by 
#  Aksimentiev et al. (https://doi.org/10.1529/biophysj.104.058727). 
#  This script is modified by me (DR PUNAM RATTU), and originally written 
#  by DR ANDREW T GUY (https://www.semanticscholar.org/author/Andrew-T.-Guy/39061500).
#########################################################################

#########################################################################
#INSTRUCTIONS#
#########################################################################
#1. Prepare input file, containing the coordinates of the ions of interest, e.g. potassium, over time. This can be generated in GROMACS using the following command: gmx traj -s [TPR] -f [XTC] -ox coord_k.xvg (fit to protein backbone).
#2. Change parameters $in (name of input file), $out (name of output file), $q (charge of the ion.
#3. Run script: perl ./count_ion.pl





# define pore dimensions (xyz limits) in nm
$checkz = "on"; # if on, will only count ion currents in z-dimension (between $z0 and $z1)  
$x0 = 7;
$x1 = 12.5;
$y0 = 6.5;
$y1 = 12.5;
$z0 = 5.5; # if $checkz is on, then count ions if coords >= $z0 nm
$z1 = 14.5; #  # if $checkz is on, then count ions if coords <= $z1 nm

$in = "coord_k.xvg"; 
$out = "current_k.xvg"; # output file, current vs time

$start = 0000; # start time to do analysis, ps
$end = 50000; # end time to do analysis, ps

$lz = 9; # box z length in nm (direction of electric field). if $checkz = on, this should be $z1 - $z0
$lx = 19.2213; # box x length, nm - only affects conductivity estimate
$ly = 19.2213; # box y length, nm - only affects conductivity estimate
$q = 1; # ion charge
$field = 0.024; # field strength in V/nm

#========================================================================================================

open (OUT, "> $out");
open (IN, "$in");
$i = -1;
while (<IN>)
{
        next if /^#/;
        next if /^@/;
	@line = (split);
	chomp;

        if (($line[0] <= $end) && ($i > 0)) 
		{
		$l = 3;
		$k = $l - 1;
        $j = $l - 2;
		$sum = 0;
                while ($l < @line)
                        {
				if ( (($checkz eq "on") || ($checkz eq "On") ||  ($checkz eq "ON")) &&  ($line[$l] >= $z0) && ($line[$l] <= $z1) && ($coord[$l] >= $z0) && ($coord[$l] <= $z1) && ($line[$k] >= $y0) && ($line[$k] <= $y1) && ($coord[$k] >= $y0) && ($coord[$k] <= $y1) && ($line[$j] >= $x0) && ($line[$j] <= $x1) && ($coord[$j] >= $x0) && ($coord[$j] <= $x1) )
				{
	                        $sum += ($line[$l] - $coord[$l]); #### if the ion is in the pore in the previous and current time frame, count it!
				}
			if (($checkz ne "on") && ($checkz ne "On") &&  ($checkz ne "ON"))
				{
                                $sum += ($line[$l] - $coord[$l]); #### no z-check here... 
                }
				$coord[$l] = $line[$l];
				$coord[$k] = $line[$k];
				$coord[$j] = $line[$j];
	            $l += 3;
	            $k += 3;
	            $j += 3
                        }
		$current = $sum  * $normalize;
		$cumcurrent += $current;
		print OUT "$line[0] $current $cumcurrent\n";
		$i ++
		}


        if (($line[0] <= $end) && ($i == 0)) 
        {
        $dt = ( $line[0] - $init ); # time
		$dt = 1; ############################################################## ignore the timstep! this is instantaneous	
		$normalize = ($q ) / ($dt * $lz); # conversion factor
        $current = $cumcurrent = 0;
        print OUT "$start 0 0\n";
        $l = 3;
        $k = $l - 1;
        $j = $l - 2;
        $sum = 0;
                while ($l < @line)
                        {
				if ( (($checkz eq "on") || ($checkz eq "On") ||  ($checkz eq "ON")) &&  ($line[$l] >= $z0) && ($line[$l] <= $z1) && ($coord[$l] >= $z0) && ($coord[$l] <= $z1) && ($line[$k] >= $y0) && ($line[$k] <= $y1) && ($coord[$k] >= $y0) && ($coord[$k] <= $y1) && ($line[$j] >= $x0) && ($line[$j] <= $x1) && ($coord[$j] >= $x0) && ($coord[$j] <= $x1) )
				{
	                        $sum += ($line[$l] - $coord[$l]); #### if the ion is in the pore in the previous and current time frame, count it!
				}
			if (($checkz ne "on") && ($checkz ne "On") &&  ($checkz ne "ON"))
				{
                                $sum += ($line[$l] - $coord[$l]); #### no z-check here... 
                }
				$coord[$l] = $line[$l];
				$coord[$k] = $line[$k];
				$coord[$j] = $line[$j];
	            $l += 3;
	            $k += 3;
	            $j += 3
                        }
		$current = $sum  * $normalize;
		$cumcurrent += $current;
		print OUT "$line[0] $current $cumcurrent\n";
		$i ++
		}


	if (($line[0] >= $start) && ($i == -1)) 
		{
		#$numions = @line;
		$l = 3;
		$k = $l - 1;
		$j = $l - 2;
		while ($l < @line)
			{
			$init = $line[0];
			$coord[$l] = $line[$l];
			$coord[$k] = $line[$k];
			$coord[$j] = $line[$j];
			$l += 3;
			$k += 3;
	        $j += 3
			}
		$i ++
		}

}
close (IN);
close (OUT);

$meancurrent = ($cumcurrent * (1.6 * 10**-19)) / ((($end - $start)/$dt) * (10**-12)) ; # time in seconds. gives average current in A

$field *= 10**9; # field strength in V/m
$zrea = ( $lx * 10**-9 ) * ( $ly * 10**-9 ); # area in m^2
$cond = $meancurrent / ( $zrea * $field ); 
$zA = $meancurrent * 10**12;

if (($checkz eq "on") || ($checkz eq "On") ||  ($checkz eq "ON")) 
	{
	print STDERR "for z-axis coords $z0 nm to $z1 nm (do not use -nojump in g_traj)\n";
	}
if (($checkz ne "on") && ($checkz ne "On") &&  ($checkz ne "ON"))
	{
	print STDERR "for whole box (use -nojump in g_traj)\n";
	}

print STDERR "for $start ps to $end ps\n";
print STDERR "number of ions = $cumcurrent\n";
print STDERR "mean current = $zA pA\n";
print STDERR "mean conductivity = $cond S/m\n";
print STDERR "see $out\n\n";


exit;

