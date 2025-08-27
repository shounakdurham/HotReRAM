# Description

To get familiar with the technicalities of HotReRAM, please go through our technical report (TechnicalReport_HotreRAM.pdf). This file contains what we have done on top of HotSpot simulator. The power model we have used is primarily from NVSim simulator, however, we have verified the power values and its relation with the temperature with VTEAM circuit simulation model. The proposed thermal model is illustrated in Figure 3 of the Technical Report. 

Execution:
1. get the periodic traces from gem5 simulator.
2. execute HotReRAM_Stats_PARSEC/retrieve.sh script to generate the relevant performance traces from gem5's output.
3. execute /HotReRAM-master/master_file_temperature.sh scipt to generate power, temperature and other relevant parameters of your ReRAM cache.

Note that, the power values in DynPowerCal.pl and LeakPowerCal.pl should be changed while changing your cache parameters/configurations. Additionally, the paths for different files also be correctly adjusted/modified while executing HotReRAM in your machine. Feel free to make any changes. 

Please do not forget to cite our paper: 
@ARTICLE{hotreram,
  author={Chakraborty, Shounak and Bunnam, Thanasin and Arunruerk, Jedsada and Agarwal, Sukarn and Yu, Shengqi and Shafik, Rishad and Själander, Magnus},
  journal={IEEE Transactions on Computer-Aided Design of Integrated Circuits and Systems}, 
  title={HotReRAM: A Performance-Power–Thermal Simulation Framework for ReRAM-Based Caches}, 
  year={2025},
  volume={44},
  number={9},
  pages={3363-3368},
  doi={10.1109/TCAD.2025.3546855}
}


