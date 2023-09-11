`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.06.2023 23:11:37
// Design Name: 
// Module Name: module_haraka
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


module module_haraka(
    
    //memory
    input  wire            clock,
    input  wire            we,   
        
    // Haraka_operations
    input  wire[255:0]  block_top_1,
    input  wire[255:0]  block_top_2,
    input  wire[3:0]    round,       
    input  wire[1:0]    round_aes,   
    input  wire         hara_c,      
    input  wire         haraka_start,
    input  wire         end_round,
    output wire[255:0]  new_block_1,
    output wire[255:0]  new_block_2,
    output wire[31:0]   we_haraka

    );
    
     //Memoria
 reg [255:0]forward_1;
 reg [255:0]forward_2;
 
 wire [255:0]rs1_data;
 wire [255:0]rs2_data;
 
    always @(posedge clock)
    begin
        if (we)
        begin
         forward_1 <= block_top_1;
         forward_2 <= block_top_2;
         end
    end
    
    assign rs1_data = forward_1;
    assign rs2_data = forward_2;
            
    wire [255:0] mix_1;
    wire [255:0] mix_2;
    wire [255:0] o_mix_256;
    wire [511:0] o_mix_512;
    wire [255:0] o_forward_256; 
    wire [511:0] o_forward_512;
    
    //wire [255:0] forward_sel;
    //wire [255:0] mix_sel;
    
           
  //Instance Haraka
    
    haraka_core haraka_core_intance(.block_1(block_top_1), .block_2(block_top_2), .hara_c(hara_c),.round(round),.round_aes(round_aes), .new_block_1(mix_1), .new_block_2(mix_2));
    
    mix256 mix256_inst(.block(mix_1), .out_mix(o_mix_256));
    
    wire [511:0] mix512_sel;
    mix512 mix512_inst(.block({mix_1,mix_2}), .out_mix(mix512_sel));
    
    assign o_mix_512 = (round_aes[0] == 1'b1) ? mix512_sel : {mix_1,mix_2} ;
    
    f_forward f_forward_instance(.block(o_mix_256), .msg(rs1_data), .out_forward(o_forward_256));
    
    f_forward_512 f_forward_512_instance(.block(o_mix_512), .msg({rs1_data,rs2_data}), .out_forward(o_forward_512));
    
    //assign forward_sel = hara_c  ? o_forward_256 :o_mix_256;
    
    assign new_block_1 = end_round? (hara_c == 1'b1)? o_forward_512[511:256]:o_forward_256   :  (hara_c == 1'b1)? o_mix_512[511:256]:o_mix_256 ;
    assign new_block_2 = end_round? (hara_c == 1'b1)? o_forward_512[255:0]  : 256'b0         :  (hara_c == 1'b1)? o_mix_512[255:0]  : 256'b0 ;
    
    
    assign we_haraka = (haraka_start == 1'b1) ? (hara_c == 1'b1)? 32'h0000ffff:32'h0000ff00: 32'h00000000;
    
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
