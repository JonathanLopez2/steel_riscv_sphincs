`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.06.2023 22:00:09
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


module haraka_core(   input     wire  [255 : 0]  block_1,
                      input     wire  [255 : 0]  block_2,
                      input     wire             hara_c,
                      input     wire    [3:0]    round,
                      input     wire    [1:0]    round_aes,
                      output    wire   [255:0]   new_block_1,
                      output    wire   [255:0]   new_block_2 
    );
    
  //Round constants
    wire [127:0] rc [0:39];
    wire [5:0] rc_index_1;
    wire [5:0] rc_index_2;
    wire [5:0] rc_index_3;
    wire [5:0] rc_index_4;
    
    wire [127:0] rc_1;
    wire [127:0] rc_2;
    wire [127:0] rc_3;
    wire [127:0] rc_4;
    
    parameter [1:0] AES_PER_ROUND = 2;
    
    assign rc_index_1 = hara_c?(4*AES_PER_ROUND*round) + (4*round_aes[0]):(2*AES_PER_ROUND*round) + (2*round_aes[0]);
    assign rc_index_2 = hara_c?(4*AES_PER_ROUND*round) + (4*round_aes[0])+1:(2*AES_PER_ROUND*round) + (2*round_aes[0])+1;
    assign rc_index_3 = hara_c?(4*AES_PER_ROUND*round) + (4*round_aes[0])+2:(2*AES_PER_ROUND*round) + (2*round_aes[1]);
    assign rc_index_4 = hara_c?(4*AES_PER_ROUND*round) + (4*round_aes[0])+3:(2*AES_PER_ROUND*round) + (2*round_aes[1])+1;
    
    assign rc_1[127:0] = rc[rc_index_1[5:0]];
    assign rc_2[127:0] = rc[rc_index_2[5:0]];
    assign rc_3[127:0] = rc[rc_index_3[5:0]];
    assign rc_4[127:0] = rc[rc_index_4[5:0]];
    
    assign rc[8'h00] = 128'h0684704ce620c00ab2c5fef075817b9d;
    assign rc[8'h01] = 128'h8b66b4e188f3a06b640f6ba42f08f717;
    assign rc[8'h02] = 128'h3402de2d53f28498cf029d609f029114;
    assign rc[8'h03] = 128'h0ed6eae62e7b4f08bbf3bcaffd5b4f79;
    assign rc[8'h04] = 128'hcbcfb0cb4872448b79eecd1cbe397044;
    assign rc[8'h05] = 128'h7eeacdee6e9032b78d5335ed2b8a057b;
    assign rc[8'h06] = 128'h67c28f435e2e7cd0e2412761da4fef1b;
    assign rc[8'h07] = 128'h2924d9b0afcacc07675ffde21fc70b3b;
    assign rc[8'h08] = 128'hab4d63f1e6867fe9ecdb8fcab9d465ee;
    assign rc[8'h09] = 128'h1c30bf84d4b7cd645b2a404fad037e33;
    assign rc[8'h0a] = 128'hb2cc0bb9941723bf69028b2e8df69800;
    assign rc[8'h0b] = 128'hfa0478a6de6f55724aaa9ec85c9d2d8a;
    assign rc[8'h0c] = 128'hdfb49f2b6b772a120efa4f2e29129fd4;
    assign rc[8'h0d] = 128'h1ea10344f449a23632d611aebb6a12ee;
    assign rc[8'h0e] = 128'haf0449884b0500845f9600c99ca8eca6;
    assign rc[8'h0f] = 128'h21025ed89d199c4f78a2c7e327e593ec;
    assign rc[8'h10] = 128'hbf3aaaf8a759c9b7b9282ecd82d40173;
    assign rc[8'h11] = 128'h6260700d6186b01737f2efd910307d6b;
    assign rc[8'h12] = 128'h5aca45c22130044381c29153f6fc9ac6;
    assign rc[8'h13] = 128'h9223973c226b68bb2caf92e836d1943a;
    assign rc[8'h14] = 128'hd3bf9238225886eb6cbab958e51071b4;
    assign rc[8'h15] = 128'hdb863ce5aef0c677933dfddd24e1128d;
    assign rc[8'h16] = 128'hbb606268ffeba09c83e48de3cb2212b1;
    assign rc[8'h17] = 128'h734bd3dce2e4d19c2db91a4ec72bf77d;
    assign rc[8'h18] = 128'h43bb47c361301b434b1415c42cb3924e;
    assign rc[8'h19] = 128'hdba775a8e707eff603b231dd16eb6899;
    assign rc[8'h1a] = 128'h6df3614b3c7559778e5e23027eca472c;
    assign rc[8'h1b] = 128'hcda75a17d6de7d776d1be5b9b88617f9;
    assign rc[8'h1c] = 128'hec6b43f06ba8e9aa9d6c069da946ee5d;
    assign rc[8'h1d] = 128'hcb1e6950f957332ba25311593bf327c1;
    assign rc[8'h1e] = 128'h2cee0c7500da619ce4ed0353600ed0d9;
    assign rc[8'h1f] = 128'hf0b1a5a196e90cab80bbbabc63a4a350;
    assign rc[8'h20] = 128'hae3db1025e962988ab0dde30938dca39;
    assign rc[8'h21] = 128'h17bb8f38d554a40b8814f3a82e75b442;
    assign rc[8'h22] = 128'h34bb8a5b5f427fd7aeb6b779360a16f6;
    assign rc[8'h23] = 128'h26f65241cbe5543843ce5918ffbaafde;
    assign rc[8'h24] = 128'h4ce99a54b9f3026aa2ca9cf7839ec978;
    assign rc[8'h25] = 128'hae51a51a1bdff7be40c06e2822901235;
    assign rc[8'h26] = 128'ha0c1613cba7ed22bc173bc0f48a659cf;
    assign rc[8'h27] = 128'h756acc03022882884ad6bdfde9c59da1;  
    
    
    
//----------------------------------------------------------------
  // Round functions with sub functions.
  //----------------------------------------------------------------
  
  function [7 : 0] gm2(input [7 : 0] op);
    begin
      gm2 = {op[6 : 0], 1'b0} ^ (8'h1b & {8{op[7]}});
    end
  endfunction // gm2

  function [7 : 0] gm3(input [7 : 0] op);
    begin
      gm3 = gm2(op) ^ op;
    end
  endfunction // gm3

  function [31 : 0] mixw(input [31 : 0] w);
    reg [7 : 0] b0, b1, b2, b3;
    reg [7 : 0] mb0, mb1, mb2, mb3;
    begin
      b0 = w[31 : 24];
      b1 = w[23 : 16];
      b2 = w[15 : 08];
      b3 = w[07 : 00];

      mb0 = gm2(b0) ^ gm3(b1) ^ b2      ^ b3;
      mb1 = b0      ^ gm2(b1) ^ gm3(b2) ^ b3;
      mb2 = b0      ^ b1      ^ gm2(b2) ^ gm3(b3);
      mb3 = gm3(b0) ^ b1      ^ b2      ^ gm2(b3);

      mixw = {mb0, mb1, mb2, mb3};
    end
  endfunction // mixw   

   // AES shiftrows second operation
  function [127 : 0] shiftrows(input [127 : 0] data);
    reg [31 : 0] w0, w1, w2, w3;
    reg [31 : 0] ws0, ws1, ws2, ws3;
    begin
      w0 = data[127 : 096];
      w1 = data[095 : 064];
      w2 = data[063 : 032];
      w3 = data[031 : 000];

      ws0 = {w0[31 : 24], w1[23 : 16], w2[15 : 08], w3[07 : 00]};
      ws1 = {w1[31 : 24], w2[23 : 16], w3[15 : 08], w0[07 : 00]};
      ws2 = {w2[31 : 24], w3[23 : 16], w0[15 : 08], w1[07 : 00]};
      ws3 = {w3[31 : 24], w0[23 : 16], w1[15 : 08], w2[07 : 00]};

      shiftrows = {ws0, ws1, ws2, ws3};
    end
  endfunction // end shiftrows
  
   //AES Mixcolumns third operation  
  function [127 : 0] mixcolumns(input [127 : 0] data);
    reg [31 : 0] w0, w1, w2, w3;
    reg [31 : 0] ws0, ws1, ws2, ws3;
    begin
      w0 = data[127 : 096];
      w1 = data[095 : 064];
      w2 = data[063 : 032];
      w3 = data[031 : 000];

      ws0 = mixw(w0);
      ws1 = mixw(w1);
      ws2 = mixw(w2);
      ws3 = mixw(w3);

      mixcolumns = {ws0, ws1, ws2, ws3};
    end
  endfunction // end mixcolumns

  //AES addroundkey cambiado por constate de ronda 4ta operación
  function [127 : 0] addroundkey(input [127 : 0] data, input [127:0] cround);
    begin
      addroundkey[127 : 120] = data[127 : 120]^cround[7 : 0]    ;
      addroundkey[119 : 112] = data[119 : 112]^cround[15 : 8]   ;
      addroundkey[111 : 104] = data[111 : 104]^cround[23 : 16]  ;
      addroundkey[103 : 96]  = data[103 : 96] ^cround[31 : 24]  ;
      addroundkey[95 : 88]   = data[95 : 88]  ^cround[39 : 32]  ;
      addroundkey[87 : 80]   = data[87 : 80]  ^cround[47 : 40]  ;
      addroundkey[79 : 72]   = data[79 : 72]  ^cround[55 : 48]  ;
      addroundkey[71 : 64]   = data[71 : 64]  ^cround[63 : 56]  ;
      addroundkey[63 : 56]   = data[63 : 56]  ^cround[71 : 64]  ;
      addroundkey[55 : 48]   = data[55 : 48]  ^cround[79 : 72]  ;
      addroundkey[47 : 40]   = data[47 : 40]  ^cround[87 : 80]  ;
      addroundkey[39 : 32]   = data[39 : 32]  ^cround[95 : 88]  ;
      addroundkey[31 : 24]   = data[31 : 24]  ^cround[103 : 96] ;
      addroundkey[23 : 16]   = data[23 : 16]  ^cround[111 : 104];
      addroundkey[15 : 8]    = data[15 : 8]   ^cround[119 : 112];
      addroundkey[7 : 0]     = data[7 : 0]    ^cround[127 : 120];
                                                           
    end
  endfunction // end addroundkey 
  
reg [127 : 0] old_block_1;
reg [127 : 0] old_block_2;

reg [127 : 0] old_block_3;
reg [127 : 0] old_block_4;

reg [255 : 0] band;
reg [255 : 0] band_2;
wire [255 : 0] new_b_wire;

// first sub_bytes
wire  [255 : 0]  block_1_sub;
sub_bytes sbytes_inst(.sboxw(block_1),.new_sboxw(block_1_sub));

sub_bytes sbytes_inst_2(.sboxw(hara_c == 1'b0 ? band : block_2),.new_sboxw(new_b_wire));

assign new_block_1 = (hara_c == 1'b0) ? band_2 : band;
assign new_block_2 = (hara_c == 1'b0) ? 256'b0 : band_2;


always @*
    begin : round_logic
        
        old_block_1 = shiftrows(block_1_sub[255:128]); 
        old_block_1 = mixcolumns(old_block_1);
        band[255:128] = addroundkey(old_block_1, rc_1);
        
        old_block_2 = shiftrows(block_1_sub[127:0]);
        old_block_2 = mixcolumns(old_block_2);
        band[127:0] = addroundkey(old_block_2, rc_2);
        
        //new_block = new_b_wire;

        old_block_3 = shiftrows(new_b_wire[255:128]);
        old_block_3 = mixcolumns(old_block_3);
        band_2[255:128] = addroundkey(old_block_3, rc_3);
        
        old_block_4 = shiftrows(new_b_wire[127:0]);
        old_block_4 = mixcolumns(old_block_4);
        band_2[127:0] = addroundkey(old_block_4, rc_4);
    end
    
endmodule

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

