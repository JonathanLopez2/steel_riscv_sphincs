set_property SRC_FILE_INFO {cfile:D:/Users/Jonathan/Documents/sphincsplus-steel/RTL/Vivado/steel_sphincs_plus/files/software_steel_arty_a7_constraints.xdc rfile:../../../files/software_steel_arty_a7_constraints.xdc id:1} [current_design]
set_property src_info {type:XDC file:1 line:5 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN R2    IOSTANDARD SSTL135 } [get_ports { clock }]; #IO_L12P_T1_MRCC_34 Sch=ddr3_clk[200]
set_property src_info {type:XDC file:1 line:9 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN R12   IOSTANDARD LVCMOS33 } [get_ports { uart_tx }]; #IO_25_14 Sch=uart_rxd_out
set_property src_info {type:XDC file:1 line:10 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN V12   IOSTANDARD LVCMOS33 } [get_ports { uart_rx }]; #IO_L24N_T3_A00_D16_14 Sch=uart_txd_in
set_property src_info {type:XDC file:1 line:13 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN K16   IOSTANDARD LVCMOS33 } [get_ports { reset }]; #IO_L19P_T3_A22_15 Sch=btn[1]
