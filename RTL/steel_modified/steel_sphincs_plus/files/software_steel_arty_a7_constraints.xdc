set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]

#clock
set_property -dict { PACKAGE_PIN R2    IOSTANDARD SSTL135 } [get_ports { clock }]; #IO_L12P_T1_MRCC_34 Sch=ddr3_clk[200]
create_clock -add -name sys_clk_pin -period 10.000 -waveform {0 5.000}  [get_ports { clock }];

## USB-UART Interface
set_property -dict { PACKAGE_PIN R12   IOSTANDARD LVCMOS33 } [get_ports { uart_tx }]; #IO_25_14 Sch=uart_rxd_out
set_property -dict { PACKAGE_PIN V12   IOSTANDARD LVCMOS33 } [get_ports { uart_rx }]; #IO_L24N_T3_A00_D16_14 Sch=uart_txd_in

#button
set_property -dict { PACKAGE_PIN K16   IOSTANDARD LVCMOS33 } [get_ports { reset }]; #IO_L19P_T3_A22_15 Sch=btn[1]