## This file is a general .xdc for the Nexys4 DDR Rev. C
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

## Clock signal
set_property -dict { PACKAGE_PIN E3    IOSTANDARD LVCMOS33 } [get_ports { clock }]; #IO_L12P_T1_MRCC_35 Sch=clk100mhz

create_clock -period 10.000 -name clock -waveform {0.000 5.000} [get_ports clock]
set_input_delay -clock [get_clocks clock] -min -add_delay 1.500 [get_ports reset]
set_input_delay -clock [get_clocks clock] -max -add_delay 5.200 [get_ports reset]
##Switches

#set_property -dict { PACKAGE_PIN J15   IOSTANDARD LVCMOS33 } [get_ports { clock }]; #IO_L24N_T3_RS0_15 Sch=sw[0]
set_property -dict { PACKAGE_PIN L16   IOSTANDARD LVCMOS33 } [get_ports { reset }]; #IO_L3N_T0_DQS_EMCCLK_14 Sch=sw[1]



