
#!/bin/sh

perl DynPowerCal.pl

# 2 to 101 for leakage calculation

for k in {2..80}
do
  perl LeakPowerCal.pl $k
  ./hotspot -c ReRAM-Example/example.config -f ReRAM-Example/ev6.flp -p ReRAM-Example/HotReRAM_Stats/X264_final/llc_rram_X264.ptrace -o ReRAM-Example/HotReRAM_Stats/X264_final/llc_rram_X264.ttrace -steady_file ReRAM-Example/HotReRAM_Stats/X264_final/llc_rram_X264.steady
  cp ReRAM-Example/HotReRAM_Stats/X264_final/llc_rram_X264.steady ReRAM-Example/HotReRAM_Stats/X264_final/llc_rram_X264.init
  ./hotspot -c ReRAM-Example/example.config -init_file ReRAM-Example/HotReRAM_Stats/X264_final/llc_rram_X264.init -f ReRAM-Example/ev6.flp -p ReRAM-Example/HotReRAM_Stats/X264_final/llc_rram_X264.ptrace -o ReRAM-Example/HotReRAM_Stats/X264_final/llc_rram_X264.ttrace
done

for k in {2..80}
do
  perl NVM_Properties.pl $k
done
