#!/usr/bin/perl
#
# purpose: this is a perl program that demonstrates
#          how to read file contents from STDIN (perl stdin),
#          use the perl split function to split each line in 
#          the file into a list of words, and then print each word.
#
# usage:   perl this-program.pl < input-file

#use strict;
#use warnings;

open(DATA10, "</home/shounak/tools_Simulators/HotReRAM-master/ReRAM-Example/HotReRAM_Stats/X264_final/x264_RDCount64.txt") or die "Couldn't open the file, $!";
open(DATA20, "</home/shounak/tools_Simulators/HotReRAM-master/ReRAM-Example/HotReRAM_Stats/X264_final/x264_WBCount64.txt") or die "Couldn't open the file, $!";
open(DATA30, "</home/shounak/tools_Simulators/HotReRAM-master/ReRAM-Example/HotReRAM_Stats/X264_final/x264_WRCount64.txt") or die "Couldn't open the file, $!";

open(DATA00, ">/home/shounak/tools_Simulators/HotReRAM-master/ReRAM-Example/HotReRAM_Stats/X264_final/DynamicPower65nm_X264.txt") or die "couldn't open the file, $!";


# following values are technology and parameter dependent, and hence should be updated with the user's configuration
$rd_dynPow = 207.612; 
$wr_dynPow = 909.462;
$wa_dynPow = 1212.661;


$c = 0;
# read from perl stdin
while (<DATA10>)
{
  @string=split("\n",$_);
  if($c<100){
    @string1=split(" ",$_);
    for ($i=0;$i<64;$i++){
      $temp=$string1[$i];
      $rd_ctr[$c][$i]=$temp * $rd_dynPow * 10**(-10) / 0.002;
    }
  }
  $c=$c+1;
}


$c = 0;
# read from perl stdin
while (<DATA20>)
{
  @string=split("\n",$_);
  if($c<100){
    @string1=split(" ",$_);
    for ($i=0;$i<64;$i++){
      $temp=$string1[$i];
      $wr_ctr[$c][$i]=$temp * $wr_dynPow * 10**(-12) / 0.002;
#      $wr_ctr[$c][$i]=$temp * $wr_dynPow * 10**(-12) / 0.00002;
    }
  }
  $c=$c+1;
}


$c = 0;
# read from perl stdin
while (<DATA30>)
{
  @string=split("\n",$_);
  #print "line no. $c\n";
  if($c<100){
    @string1=split(" ",$_);
    for ($i=0;$i<64;$i++){
      $temp=$string1[$i];
      $wa_ctr[$c][$i]=$temp * $wa_dynPow * 10**(-12) / 0.002;
#      $wa_ctr[$c][$i]=$temp * $wa_dynPow * 10**(-12) / 0.00002;
    }
  }
  $c=$c+1;
}


$c = 0;
while($c<100){
  for ($i=0;$i<64;$i++){
    $tot_Dyn_power[$c][$i] = $rd_ctr[$c][$i] + $wr_ctr[$c][$i] + $wa_ctr[$c][$i]; 
    print DATA00 "$tot_Dyn_power[$c][$i]\t";
  }
  print DATA00 "\n";
  $c = $c + 1;
}



#################################### end of Dynamic power calculation ###############################

close(DATA00) || die "couldn't close";
close(DATA10) || die "couldn't close";
close(DATA20) || die "couldn't close";
close(DATA30) || die "couldn't close";


