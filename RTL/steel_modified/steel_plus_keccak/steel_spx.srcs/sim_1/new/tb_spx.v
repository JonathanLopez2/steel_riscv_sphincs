`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.05.2023 11:54:01
// Design Name: 
// Module Name: tb_spx
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


module tb_spx();
   reg clock;
   reg reset;
   wire [31:0] instruction_in;
   wire [31:0] instruction_address;
   wire [31:0] bus_data_rdata;
   
   test_spx dut (
       .clock                   (clock         ),
       .reset                   (reset         ),
       .instruction_in          (instruction_in),
       .instruction_address     (instruction_address),
       .bus_data_rdata          (bus_data_rdata)
       );
   
   always #10 clock = !clock;
   
   integer j;
   
   initial 
   begin
     reset = 1'b1;        
     clock = 1'b0;
   end
   
   initial 
   begin
   #20 reset = 1'b0;
   
   // Execution is aborted if j reaches 500000 cycles (~1ms)
   for(j = 0; j < 20000; j=j+1) begin
     #20; 
     
   end
   
   end

endmodule
