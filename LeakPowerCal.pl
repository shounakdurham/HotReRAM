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



open(DATA00, "</home/shounak/tools_Simulators/HotReRAM-master/ReRAM-Example/HotReRAM_Stats/X264_final/DynamicPower65nm_X264.txt") or die "couldn't open the file, $!";
open(DATA40, "</home/shounak/tools_Simulators/HotReRAM-master/ReRAM-Example/HotReRAM_Stats/X264_final/llc_rram_X264.ttrace") or die "couldn't open the file, $!";
open(DATA50, ">>", "/home/shounak/tools_Simulators/HotReRAM-master/ReRAM-Example/HotReRAM_Stats/X264_final/llc_rram_X264.ptrace") or die "couldn't open the file, $!";

$line_no = $ARGV[0];

$c=0;
# read from perl stdin
while (<DATA40>)
{
  @string=split("\n",$_);
  if($c==$line_no){
    @string1=split(" ",$_);
    for ($i=0;$i<64;$i++){
      $temp=$string1[$i];
      $temperature[$c][$i]=$temp;
      $leakage[$c][$i]=($temperature[$c][$i] * 0.5854 - 94.048) / 1000.0; 
      #$leakage[$c][$i]=($temperature[$c][$i] * 0.5854) / 1000.0; 
    }
  }
  $c=$c+1;
}

$c=0;
while (<DATA00>)
{
  @string=split("\n",$_);
  if($c==$line_no - 1){
    @string2=split(" ",$_);
    for ($i=0;$i<64;$i++){
      $dyn=$string2[$i];
      $tot_power[$c][$i]=$dyn + $leakage[$c+1][$i];
      #$tot_power[$c][$i]=$dyn*3 + $leakage[$c+1][$i]*2;
      print DATA50 "$tot_power[$c][$i]\t";
    }
  }
  $c=$c+1;
}

print DATA50 "\n";

close(DATA00) || die "couldn't close";
close(DATA40) || die "couldn't close";
close(DATA50) || die "couldn't close";


