`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.05.2023 11:51:33
// Design Name: 
// Module Name: test_spx
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module test_spx( 
  input   wire clock,
  input   wire reset,
  // Steel Core (instruction interface) <=> RAM (device #0, port #0) and output 
  output  wire [31:0] instruction_in,
  output  wire [31:0] instruction_address,
  output  wire [31:0] bus_data_rdata
  );
    
  reg clk50mhz = 1'b0;
  always @(posedge clock) clk50mhz <= !clk50mhz;

  
  // Steel Core (data interface)
  wire [31:0] bus_data_rw_address;
  wire [31:0] bus_data_wdata;
  wire [3:0 ] bus_data_write_mask;
  wire        bus_data_write_request;
  
  riscv_steel_core riscv_steel_core_instance (

    // Basic system signals
    .clock                        (clk50mhz                     ),
    .reset                        (reset                        ),
    .boot_address                 (32'h0000002780               ),

    // Instruction fetch interface
    .instruction_address          (instruction_address          ),
    .instruction_in               (instruction_in               ),

    // Data fetch/write interface
    .data_rw_address              (bus_data_rw_address          ),
    .data_out                     (bus_data_wdata               ),
    .data_write_request           (bus_data_write_request       ),
    .data_write_mask              (bus_data_write_mask          ),
    .data_in                      (bus_data_rdata               ),

    // Interrupt signals (hardwire to zero if unused)
    .interrupt_request_external   (1'b0), // unused
    .interrupt_request_timer      (1'b0), // unused
    .interrupt_request_software   (1'b0), // unused

    // Real Time Counter (hardwire to zero if unused)
    .real_time                    (64'h0000000000000000)  // unused

  );
  
  // Instace RAM
  dual_port_ram dual_port_ram_instance    (
    .clock                  (clk50mhz                        ),
    .reset                  (reset                           ),
    .port0_address          (instruction_address             ),
    .port0_data_out         (instruction_in                  ),
    .port1_address          (bus_data_rw_address             ),
    .port1_data_out         (bus_data_rdata                  ),
    .port1_data_in          (bus_data_wdata                  ),
    .port1_write_mask       (bus_data_write_mask             ),
    .port1_write_enable     (bus_data_write_request          )
  );
  
endmodule
