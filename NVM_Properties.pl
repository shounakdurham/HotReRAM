#!/usr/bin/perl
#
# purpose: this is a perl program that demonstrates
#          how to read file contents from STDIN (perl stdin),
#          use the perl split function to split each line in 
#          the file into a list of words, and then print each word.
#
# usage:   perl this-program.pl #line_no

#use strict;
#use warnings;


open(DATA00, "</home/shounak/tools_Simulators/HotReRAM-master/ReRAM-Example/HotReRAM_Stats/X264_final/llc_rram_X264.ttrace") or die "couldn't open the file, $!";
open(DATA10, ">>", "/home/shounak/tools_Simulators/HotReRAM-master/ReRAM-Example/HotReRAM_Stats/X264_final/llc_rram_X264_delta.txt") or die "couldn't open the file, $!";
open(DATA20, ">>", "/home/shounak/tools_Simulators/HotReRAM-master/ReRAM-Example/HotReRAM_Stats/X264_final/llc_rram_X264_FailureRate.txt") or die "couldn't open the file, $!";
open(DATA30, ">>", "/home/shounak/tools_Simulators/HotReRAM-master/ReRAM-Example/HotReRAM_Stats/X264_final/llc_rram_X264_RetTime.txt") or die "couldn't open the file, $!";
open(DATA40, ">>", "/home/shounak/tools_Simulators/HotReRAM-master/ReRAM-Example/HotReRAM_Stats/X264_final/llc_rram_X264_WrLatency.txt") or die "couldn't open the file, $!";
#open(DATA50, ">>", "/home/shounak/tools_Simulators/HotReRAM-master/ReRAM-Example/HotReRAM_Stats/X264_final/llc_rram_X264_RdDisturbance.txt") or die "couldn't open the file, $!";

$line_no = $ARGV[0];
$const=100;		# Ea/kb : Ea is the energy barrier and kb is the Boltzman's constant
$ret0=20; 		# initial retention time of the ReRAM in ns
$sigma0=15; 		# initial conductivity of the ReRAM
$m=100;			# number of devices

$Ron=1.4;
$Roff=150;
$Rpdcol=15;

$r1=$Ron/$Roff;
$r2=$Rpdcol/$Ron;
$xf=1;
$x0=0;

$c=0;
# read from perl stdin
while (<DATA00>)
{
  @string=split("\n",$_);
  if($c==$line_no){
    @string1=split(" ",$_);
    for ($i=0;$i<64;$i++){
      $temp=$string1[$i];
      $temperature[$c][$i]=$temp;

      $delta[$c][$i]=$const/$temp;

      $delta_exp[$c][$i] = exp $delta[$c][$i]; 			# Thermal Stability
      print DATA10 "$delta_exp[$c][$i]\t";
      
      $delta_exp_neg[$c][$i]= exp ($delta[$c][$i]*(-1));	

      $retention_time[$c][$i] = $ret0 * $delta_exp[$c][$i];	# Retention Time
      print DATA30 "$retention_time[$c][$i]\t";

      $sigma[$c][$i] = $sigma0 * $delta_exp_neg[$c][$i];	# Conductivity

      $subexp_fail[$c][$i] = $m * (-1) * ($retention_time[$c][$i] / $ret0) * $delta_exp[$c][$i];
      $fail_rate[$c][$i] = 1 - exp $subexp_fail[$c][$i];	# Chip Failure rate
      print DATA20 "$fail_rate[$c][$i]\t";

      $muI_temp[$c][$i] = $delta_exp_neg[$c][$i]/((0.0000862) * $temp); # ion mobility at some certain temperature, considering qI, f, and a as constant (1). 

      $tw[$c][$i] = (1/$muI_temp[$c][$i]) * ((($r1 - 1)/2) * (($x0 * $x0) - ($xf * $xf))  + (($r1 + $r2) * ($xf - $x0))); # Write latency. Considered D and vw as constant (1)
      print DATA40 "$tw[$c][$i]\t";
      if ($i==63){
	print DATA10 "\n";
	print DATA20 "\n";
	print DATA30 "\n";
	print DATA40 "\n";
      }
    }
  }

  $c=$c+1;

}


close(DATA00) || die "couldn't close";
close(DATA10) || die "couldn't close";
close(DATA20) || die "couldn't close";
close(DATA30) || die "couldn't close";
close(DATA40) || die "couldn't close";
#close(DATA50) || die "couldn't close";
