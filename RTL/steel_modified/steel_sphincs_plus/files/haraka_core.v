`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/16/2023 09:59:12 AM
// Design Name: 
// Module Name: haraka_core
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


module haraka_core(
      input     wire          hara_c,    
      input     wire [255:0]  block_top_1,
      input     wire [255:0]  block_top_2,
      input     wire [3:0]    round,
      input     wire [1:0]    round_aes,
      output    wire [255:0]  new_block_1,
      output    wire [255:0]  new_block_2

    );
    
 wire [127:0]    rc_1;
 wire [127:0]    rc_2;
 wire [127:0]    rc_3;
 wire [127:0]    rc_4;

//instancias
//sub_bytes sbytes_inst(.sboxw(block_top_1),.new_sboxw(w_block));

round_c rc_inst(.hara_c(hara_c),.round(round),.round_aes(round_aes),.rc_out0_1(rc_1),.rc_out0_2(rc_2), .rc_out1_1(rc_3),.rc_out1_2(rc_4));

haraka_1round haraka_round_inst(.block_1(block_top_1),.hara_c(hara_c), .block_2(block_top_2) , .rc_1(rc_1),.rc_2(rc_2),.rc_3(rc_3),.rc_4(rc_4), .new_block_1(new_block_1) ,.new_block_2(new_block_2) );
//haraka_1round haraka_round_inst(.block_1(w_block),.hara_c(hara_c), .block_2(block_top_2) , .rc_1(block_top_1[255:128]),.rc_2(block_top_1[127:0]),.rc_3(block_top_2[255:128]),.rc_4(block_top_2[127:0]), .new_block_1(new_block_1) ,.new_block_2(new_block_2) );

//assign new_block_1 = block_top_1 ;
//assign new_block_2 = block_top_2 ;
                          
endmodule

module mix256(input  wire [255:0] block,
              output wire [255:0] out_mix);
              
 wire [31:0] band1, band2, band3, band4, band5, band6, band7, band8;
 
 assign band1 = block[255:224];
 assign band2 = block[223:192];
 assign band3 = block[191:160];
 assign band4 = block[159:128];
 assign band5 = block[127:96];
 assign band6 = block[95:64];
 assign band7 = block[63:32];
 assign band8 = block[31:0];
 
 assign out_mix = {band1, band5, band2, band6, band3, band7, band4, band8};

endmodule

module mix512(input  wire [511:0] block,
              output wire [511:0] out_mix);
              
 wire [31:0] band1, band2, band3, band4, band5, band6, band7, band8, band9, band10, band11, band12, band13, band14, band15, band16;
 
 assign band1 = block[511:480];
 assign band2 = block[479:448];
 assign band3 = block[447:416];
 assign band4 = block[415:384];
 assign band5 = block[383:352];
 assign band6 = block[351:320];
 assign band7 = block[319:288];
 assign band8 = block[287:256];

 assign band9 = block[255:224];
 assign band10 = block[223:192];
 assign band11 = block[191:160];
 assign band12 = block[159:128];
 assign band13 = block[127:96];
 assign band14 = block[95:64];
 assign band15 = block[63:32];
 assign band16 = block[31:0];
 
 assign out_mix = {band4, band12, band8, band16, band9, band1, band13, band5, band10, band2, band14, band6, band3, band11, band7, band15};

endmodule

module f_forward(input  wire [255:0] block,
                 input  wire [255:0] msg,
                 output wire [255:0] out_forward);
 
 assign out_forward = block ^ msg;

endmodule

module f_forward_512(input  wire [511:0] block,
                     input  wire [511:0] msg,
                     output wire [511:0] out_forward);
 
 assign out_forward = block ^ msg;

endmodule


