`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2022 08:00:50 PM
// Design Name: 
// Module Name: sub_bytes
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

//module sub_bytes(   input wire clk,  
//                    input wire [7 : 0]  addr_1,
//                    input wire [7 : 0]  addr_2,
//                    input wire [7 : 0]  addr_3,
//                    input wire [7 : 0]  addr_4,
//                    input wire [7 : 0]  addr_5,
//                    input wire [7 : 0]  addr_6,
//                    input wire [7 : 0]  addr_7,
//                    input wire [7 : 0]  addr_8,
//                    input wire [7 : 0]  addr_9,
//                    input wire [7 : 0]  addr_10,
//                    input wire [7 : 0]  addr_11,
//                    input wire [7 : 0]  addr_12,
//                    input wire [7 : 0]  addr_13,
//                    input wire [7 : 0]  addr_14,
//                    input wire [7 : 0]  addr_15,
//                    input wire [7 : 0]  addr_16,
//                    output wire [127 : 0] new_block_sb

//    );


//ROM_IP gen_sbox_1(.clka(clk), .clkb(clk), .addra(addr_1), .addrb(addr_2), .douta(new_block_sb[127:120]),.doutb(new_block_sb[119:112]));
////ROM_dual gen_sbox_2(.clk(clk), .addr_1(addr_3), .addr_2(addr_4), .data_out_1(new_block_sb[111:104]),.data_out_2(new_block_sb[103:96]));
////ROM_dual gen_sbox_3(.clk(clk), .addr_1(addr_5), .addr_2(addr_6), .data_out_1(new_block_sb[95:88]),.data_out_2(new_block_sb[87:80]));
////ROM_dual gen_sbox_4(.clk(clk), .addr_1(addr_7), .addr_2(addr_8), .data_out_1(new_block_sb[79:72]),.data_out_2(new_block_sb[71:64]));

////ROM_dual gen_sbox_5(.clk(clk), .addr_1(addr_9), .addr_2(addr_10), .data_out_1(new_block_sb[63:56]),.data_out_2(new_block_sb[55:48]));
////ROM_dual gen_sbox_6(.clk(clk), .addr_1(addr_11), .addr_2(addr_12), .data_out_1(new_block_sb[47:40]),.data_out_2(new_block_sb[39:32]));
////ROM_dual gen_sbox_7(.clk(clk), .addr_1(addr_13), .addr_2(addr_14), .data_out_1(new_block_sb[31:24]),.data_out_2(new_block_sb[23:16]));
////ROM_dual gen_sbox_8(.clk(clk), .addr_1(addr_15), .addr_2(addr_16), .data_out_1(new_block_sb[15:8]),.data_out_2(new_block_sb[7:0]));

 
//endmodule


module sub_bytes(  
             input wire [255 : 0]  sboxw,
             output wire [255 : 0] new_sboxw
    );
    
wire [7 : 0] sbox [0 : 255];

  assign new_sboxw[255 : 248] = sbox[sboxw[255 : 248]];
  assign new_sboxw[247 : 240] = sbox[sboxw[247 : 240]];
  assign new_sboxw[239 : 232] = sbox[sboxw[239 : 232]];
  assign new_sboxw[231 : 224] = sbox[sboxw[231 : 224]];
  assign new_sboxw[223 : 216] = sbox[sboxw[223 : 216]];
  assign new_sboxw[215 : 208] = sbox[sboxw[215 : 208]];
  assign new_sboxw[207 : 200] = sbox[sboxw[207 : 200]];
  assign new_sboxw[199 : 192] = sbox[sboxw[199 : 192]];
  assign new_sboxw[191 : 184] = sbox[sboxw[191 : 184]];
  assign new_sboxw[183 : 176] = sbox[sboxw[183 : 176]];
  assign new_sboxw[175 : 168] = sbox[sboxw[175 : 168]];
  assign new_sboxw[167 : 160] = sbox[sboxw[167 : 160]];
  assign new_sboxw[159 : 152] = sbox[sboxw[159 : 152]];
  assign new_sboxw[151 : 144] = sbox[sboxw[151 : 144]];
  assign new_sboxw[143 : 136] = sbox[sboxw[143 : 136]];
  assign new_sboxw[135 : 128] = sbox[sboxw[135 : 128]];
  
  
  assign new_sboxw[127 : 120] = sbox[sboxw[127 : 120]];
  assign new_sboxw[119 : 112] = sbox[sboxw[119 : 112]];
  assign new_sboxw[111 : 104] = sbox[sboxw[111 : 104]];
  assign new_sboxw[103 : 96]  = sbox[sboxw[103 : 96] ];
  assign new_sboxw[95 : 88]   = sbox[sboxw[95 : 88]  ];
  assign new_sboxw[87 : 80]   = sbox[sboxw[87 : 80]  ];
  assign new_sboxw[79 : 72]   = sbox[sboxw[79 : 72]  ];
  assign new_sboxw[71 : 64]   = sbox[sboxw[71 : 64]  ];
  assign new_sboxw[63 : 56]   = sbox[sboxw[63 : 56]  ];
  assign new_sboxw[55 : 48]   = sbox[sboxw[55 : 48]  ];
  assign new_sboxw[47 : 40]   = sbox[sboxw[47 : 40]  ];
  assign new_sboxw[39 : 32]   = sbox[sboxw[39 : 32]  ];
  assign new_sboxw[31 : 24]   = sbox[sboxw[31 : 24]  ];
  assign new_sboxw[23 : 16]   = sbox[sboxw[23 : 16]  ];
  assign new_sboxw[15 : 8]    = sbox[sboxw[15 : 8]   ];
  assign new_sboxw[7 : 0]     = sbox[sboxw[7 : 0]    ];


  //----------------------------------------------------------------
  // Creating the sbox array contents.
  //----------------------------------------------------------------
  assign sbox[8'h00] = 8'h63;
  assign sbox[8'h01] = 8'h7c;
  assign sbox[8'h02] = 8'h77;
  assign sbox[8'h03] = 8'h7b;
  assign sbox[8'h04] = 8'hf2;
  assign sbox[8'h05] = 8'h6b;
  assign sbox[8'h06] = 8'h6f;
  assign sbox[8'h07] = 8'hc5;
  assign sbox[8'h08] = 8'h30;
  assign sbox[8'h09] = 8'h01;
  assign sbox[8'h0a] = 8'h67;
  assign sbox[8'h0b] = 8'h2b;
  assign sbox[8'h0c] = 8'hfe;
  assign sbox[8'h0d] = 8'hd7;
  assign sbox[8'h0e] = 8'hab;
  assign sbox[8'h0f] = 8'h76;
  assign sbox[8'h10] = 8'hca;
  assign sbox[8'h11] = 8'h82;
  assign sbox[8'h12] = 8'hc9;
  assign sbox[8'h13] = 8'h7d;
  assign sbox[8'h14] = 8'hfa;
  assign sbox[8'h15] = 8'h59;
  assign sbox[8'h16] = 8'h47;
  assign sbox[8'h17] = 8'hf0;
  assign sbox[8'h18] = 8'had;
  assign sbox[8'h19] = 8'hd4;
  assign sbox[8'h1a] = 8'ha2;
  assign sbox[8'h1b] = 8'haf;
  assign sbox[8'h1c] = 8'h9c;
  assign sbox[8'h1d] = 8'ha4;
  assign sbox[8'h1e] = 8'h72;
  assign sbox[8'h1f] = 8'hc0;
  assign sbox[8'h20] = 8'hb7;
  assign sbox[8'h21] = 8'hfd;
  assign sbox[8'h22] = 8'h93;
  assign sbox[8'h23] = 8'h26;
  assign sbox[8'h24] = 8'h36;
  assign sbox[8'h25] = 8'h3f;
  assign sbox[8'h26] = 8'hf7;
  assign sbox[8'h27] = 8'hcc;
  assign sbox[8'h28] = 8'h34;
  assign sbox[8'h29] = 8'ha5;
  assign sbox[8'h2a] = 8'he5;
  assign sbox[8'h2b] = 8'hf1;
  assign sbox[8'h2c] = 8'h71;
  assign sbox[8'h2d] = 8'hd8;
  assign sbox[8'h2e] = 8'h31;
  assign sbox[8'h2f] = 8'h15;
  assign sbox[8'h30] = 8'h04;
  assign sbox[8'h31] = 8'hc7;
  assign sbox[8'h32] = 8'h23;
  assign sbox[8'h33] = 8'hc3;
  assign sbox[8'h34] = 8'h18;
  assign sbox[8'h35] = 8'h96;
  assign sbox[8'h36] = 8'h05;
  assign sbox[8'h37] = 8'h9a;
  assign sbox[8'h38] = 8'h07;
  assign sbox[8'h39] = 8'h12;
  assign sbox[8'h3a] = 8'h80;
  assign sbox[8'h3b] = 8'he2;
  assign sbox[8'h3c] = 8'heb;
  assign sbox[8'h3d] = 8'h27;
  assign sbox[8'h3e] = 8'hb2;
  assign sbox[8'h3f] = 8'h75;
  assign sbox[8'h40] = 8'h09;
  assign sbox[8'h41] = 8'h83;
  assign sbox[8'h42] = 8'h2c;
  assign sbox[8'h43] = 8'h1a;
  assign sbox[8'h44] = 8'h1b;
  assign sbox[8'h45] = 8'h6e;
  assign sbox[8'h46] = 8'h5a;
  assign sbox[8'h47] = 8'ha0;
  assign sbox[8'h48] = 8'h52;
  assign sbox[8'h49] = 8'h3b;
  assign sbox[8'h4a] = 8'hd6;
  assign sbox[8'h4b] = 8'hb3;
  assign sbox[8'h4c] = 8'h29;
  assign sbox[8'h4d] = 8'he3;
  assign sbox[8'h4e] = 8'h2f;
  assign sbox[8'h4f] = 8'h84;
  assign sbox[8'h50] = 8'h53;
  assign sbox[8'h51] = 8'hd1;
  assign sbox[8'h52] = 8'h00;
  assign sbox[8'h53] = 8'hed;
  assign sbox[8'h54] = 8'h20;
  assign sbox[8'h55] = 8'hfc;
  assign sbox[8'h56] = 8'hb1;
  assign sbox[8'h57] = 8'h5b;
  assign sbox[8'h58] = 8'h6a;
  assign sbox[8'h59] = 8'hcb;
  assign sbox[8'h5a] = 8'hbe;
  assign sbox[8'h5b] = 8'h39;
  assign sbox[8'h5c] = 8'h4a;
  assign sbox[8'h5d] = 8'h4c;
  assign sbox[8'h5e] = 8'h58;
  assign sbox[8'h5f] = 8'hcf;
  assign sbox[8'h60] = 8'hd0;
  assign sbox[8'h61] = 8'hef;
  assign sbox[8'h62] = 8'haa;
  assign sbox[8'h63] = 8'hfb;
  assign sbox[8'h64] = 8'h43;
  assign sbox[8'h65] = 8'h4d;
  assign sbox[8'h66] = 8'h33;
  assign sbox[8'h67] = 8'h85;
  assign sbox[8'h68] = 8'h45;
  assign sbox[8'h69] = 8'hf9;
  assign sbox[8'h6a] = 8'h02;
  assign sbox[8'h6b] = 8'h7f;
  assign sbox[8'h6c] = 8'h50;
  assign sbox[8'h6d] = 8'h3c;
  assign sbox[8'h6e] = 8'h9f;
  assign sbox[8'h6f] = 8'ha8;
  assign sbox[8'h70] = 8'h51;
  assign sbox[8'h71] = 8'ha3;
  assign sbox[8'h72] = 8'h40;
  assign sbox[8'h73] = 8'h8f;
  assign sbox[8'h74] = 8'h92;
  assign sbox[8'h75] = 8'h9d;
  assign sbox[8'h76] = 8'h38;
  assign sbox[8'h77] = 8'hf5;
  assign sbox[8'h78] = 8'hbc;
  assign sbox[8'h79] = 8'hb6;
  assign sbox[8'h7a] = 8'hda;
  assign sbox[8'h7b] = 8'h21;
  assign sbox[8'h7c] = 8'h10;
  assign sbox[8'h7d] = 8'hff;
  assign sbox[8'h7e] = 8'hf3;
  assign sbox[8'h7f] = 8'hd2;
  assign sbox[8'h80] = 8'hcd;
  assign sbox[8'h81] = 8'h0c;
  assign sbox[8'h82] = 8'h13;
  assign sbox[8'h83] = 8'hec;
  assign sbox[8'h84] = 8'h5f;
  assign sbox[8'h85] = 8'h97;
  assign sbox[8'h86] = 8'h44;
  assign sbox[8'h87] = 8'h17;
  assign sbox[8'h88] = 8'hc4;
  assign sbox[8'h89] = 8'ha7;
  assign sbox[8'h8a] = 8'h7e;
  assign sbox[8'h8b] = 8'h3d;
  assign sbox[8'h8c] = 8'h64;
  assign sbox[8'h8d] = 8'h5d;
  assign sbox[8'h8e] = 8'h19;
  assign sbox[8'h8f] = 8'h73;
  assign sbox[8'h90] = 8'h60;
  assign sbox[8'h91] = 8'h81;
  assign sbox[8'h92] = 8'h4f;
  assign sbox[8'h93] = 8'hdc;
  assign sbox[8'h94] = 8'h22;
  assign sbox[8'h95] = 8'h2a;
  assign sbox[8'h96] = 8'h90;
  assign sbox[8'h97] = 8'h88;
  assign sbox[8'h98] = 8'h46;
  assign sbox[8'h99] = 8'hee;
  assign sbox[8'h9a] = 8'hb8;
  assign sbox[8'h9b] = 8'h14;
  assign sbox[8'h9c] = 8'hde;
  assign sbox[8'h9d] = 8'h5e;
  assign sbox[8'h9e] = 8'h0b;
  assign sbox[8'h9f] = 8'hdb;
  assign sbox[8'ha0] = 8'he0;
  assign sbox[8'ha1] = 8'h32;
  assign sbox[8'ha2] = 8'h3a;
  assign sbox[8'ha3] = 8'h0a;
  assign sbox[8'ha4] = 8'h49;
  assign sbox[8'ha5] = 8'h06;
  assign sbox[8'ha6] = 8'h24;
  assign sbox[8'ha7] = 8'h5c;
  assign sbox[8'ha8] = 8'hc2;
  assign sbox[8'ha9] = 8'hd3;
  assign sbox[8'haa] = 8'hac;
  assign sbox[8'hab] = 8'h62;
  assign sbox[8'hac] = 8'h91;
  assign sbox[8'had] = 8'h95;
  assign sbox[8'hae] = 8'he4;
  assign sbox[8'haf] = 8'h79;
  assign sbox[8'hb0] = 8'he7;
  assign sbox[8'hb1] = 8'hc8;
  assign sbox[8'hb2] = 8'h37;
  assign sbox[8'hb3] = 8'h6d;
  assign sbox[8'hb4] = 8'h8d;
  assign sbox[8'hb5] = 8'hd5;
  assign sbox[8'hb6] = 8'h4e;
  assign sbox[8'hb7] = 8'ha9;
  assign sbox[8'hb8] = 8'h6c;
  assign sbox[8'hb9] = 8'h56;
  assign sbox[8'hba] = 8'hf4;
  assign sbox[8'hbb] = 8'hea;
  assign sbox[8'hbc] = 8'h65;
  assign sbox[8'hbd] = 8'h7a;
  assign sbox[8'hbe] = 8'hae;
  assign sbox[8'hbf] = 8'h08;
  assign sbox[8'hc0] = 8'hba;
  assign sbox[8'hc1] = 8'h78;
  assign sbox[8'hc2] = 8'h25;
  assign sbox[8'hc3] = 8'h2e;
  assign sbox[8'hc4] = 8'h1c;
  assign sbox[8'hc5] = 8'ha6;
  assign sbox[8'hc6] = 8'hb4;
  assign sbox[8'hc7] = 8'hc6;
  assign sbox[8'hc8] = 8'he8;
  assign sbox[8'hc9] = 8'hdd;
  assign sbox[8'hca] = 8'h74;
  assign sbox[8'hcb] = 8'h1f;
  assign sbox[8'hcc] = 8'h4b;
  assign sbox[8'hcd] = 8'hbd;
  assign sbox[8'hce] = 8'h8b;
  assign sbox[8'hcf] = 8'h8a;
  assign sbox[8'hd0] = 8'h70;
  assign sbox[8'hd1] = 8'h3e;
  assign sbox[8'hd2] = 8'hb5;
  assign sbox[8'hd3] = 8'h66;
  assign sbox[8'hd4] = 8'h48;
  assign sbox[8'hd5] = 8'h03;
  assign sbox[8'hd6] = 8'hf6;
  assign sbox[8'hd7] = 8'h0e;
  assign sbox[8'hd8] = 8'h61;
  assign sbox[8'hd9] = 8'h35;
  assign sbox[8'hda] = 8'h57;
  assign sbox[8'hdb] = 8'hb9;
  assign sbox[8'hdc] = 8'h86;
  assign sbox[8'hdd] = 8'hc1;
  assign sbox[8'hde] = 8'h1d;
  assign sbox[8'hdf] = 8'h9e;
  assign sbox[8'he0] = 8'he1;
  assign sbox[8'he1] = 8'hf8;
  assign sbox[8'he2] = 8'h98;
  assign sbox[8'he3] = 8'h11;
  assign sbox[8'he4] = 8'h69;
  assign sbox[8'he5] = 8'hd9;
  assign sbox[8'he6] = 8'h8e;
  assign sbox[8'he7] = 8'h94;
  assign sbox[8'he8] = 8'h9b;
  assign sbox[8'he9] = 8'h1e;
  assign sbox[8'hea] = 8'h87;
  assign sbox[8'heb] = 8'he9;
  assign sbox[8'hec] = 8'hce;
  assign sbox[8'hed] = 8'h55;
  assign sbox[8'hee] = 8'h28;
  assign sbox[8'hef] = 8'hdf;
  assign sbox[8'hf0] = 8'h8c;
  assign sbox[8'hf1] = 8'ha1;
  assign sbox[8'hf2] = 8'h89;
  assign sbox[8'hf3] = 8'h0d;
  assign sbox[8'hf4] = 8'hbf;
  assign sbox[8'hf5] = 8'he6;
  assign sbox[8'hf6] = 8'h42;
  assign sbox[8'hf7] = 8'h68;
  assign sbox[8'hf8] = 8'h41;
  assign sbox[8'hf9] = 8'h99;
  assign sbox[8'hfa] = 8'h2d;
  assign sbox[8'hfb] = 8'h0f;
  assign sbox[8'hfc] = 8'hb0;
  assign sbox[8'hfd] = 8'h54;
  assign sbox[8'hfe] = 8'hbb;
  assign sbox[8'hff] = 8'h16;
  
  
endmodule        
//     input wire [7 : 0]  addr_1,
//     input wire [7 : 0]  addr_2,
//     input wire [7 : 0]  addr_3,
//     input wire [7 : 0]  addr_4,
//     input wire [7 : 0]  addr_5,
//     input wire [7 : 0]  addr_6,
//     input wire [7 : 0]  addr_7,
//     input wire [7 : 0]  addr_8,
//     input wire [7 : 0]  addr_9,
//     input wire [7 : 0]  addr_10,
//     input wire [7 : 0]  addr_11,
//     input wire [7 : 0]  addr_12,
//     input wire [7 : 0]  addr_13,
//     input wire [7 : 0]  addr_14,
//     input wire [7 : 0]  addr_15,
//     input wire [7 : 0]  addr_16,
//     output wire [127 : 0] new_block_sb

//    );


//ROM_dual gen_sbox_1(.addr_1(addr_1), .addr_2(addr_2), .data_out_1(new_block_sb[127:120]),.data_out_2(new_block_sb[119:112]));
//ROM_dual gen_sbox_2(.addr_1(addr_3), .addr_2(addr_4), .data_out_1(new_block_sb[111:104]),.data_out_2(new_block_sb[103:96]));
//ROM_dual gen_sbox_3(.addr_1(addr_5), .addr_2(addr_6), .data_out_1(new_block_sb[95:88]),.data_out_2(new_block_sb[87:80]));
//ROM_dual gen_sbox_4(.addr_1(addr_7), .addr_2(addr_8), .data_out_1(new_block_sb[79:72]),.data_out_2(new_block_sb[71:64]));

//ROM_dual gen_sbox_5(.addr_1(addr_9), .addr_2(addr_10), .data_out_1(new_block_sb[63:56]),.data_out_2(new_block_sb[55:48]));
//ROM_dual gen_sbox_6(.addr_1(addr_11), .addr_2(addr_12), .data_out_1(new_block_sb[47:40]),.data_out_2(new_block_sb[39:32]));
//ROM_dual gen_sbox_7(.addr_1(addr_13), .addr_2(addr_14), .data_out_1(new_block_sb[31:24]),.data_out_2(new_block_sb[23:16]));
//ROM_dual gen_sbox_8(.addr_1(addr_15), .addr_2(addr_16), .data_out_1(new_block_sb[15:8]),.data_out_2(new_block_sb[7:0]));

 
//endmodule


//module sub_bytes(   input wire [127 : 0]  block_sb,
//                    output wire [127 : 0] new_block_sb

//    );

//sbox gen_sbox(.sboxw(block_sb[127:0]), .new_sboxw(new_block_sb[127:0]));


//// Genera 16 sbox
////genvar i;
////generate 
////    for  (i=0; i<16; i = i+1)begin
////    sbox gen_sbox(.sboxw(block_sb[(i+1)*8-1 : i*8]), .new_sboxw(new_block_sb[(i+1)*8-1 : i*8]));
////    end

////endgenerate 
 
//endmodule
