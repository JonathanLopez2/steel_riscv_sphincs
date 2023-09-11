`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2022 06:03:29 PM
// Design Name: 
// Module Name: haraka_1round
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


module haraka_1round( input     wire  [255 : 0]  block_1,
                      input     wire  [255 : 0]  block_2,
                      input     wire            hara_c,
                      input     wire [127:0]    rc_1,
                      input     wire [127:0]    rc_2,
                      input     wire [127:0]    rc_3,
                      input     wire [127:0]    rc_4,
                      output    wire [255:0]    new_block_1,
                      output    wire [255:0]    new_block_2 
    );
    
    
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

  
 
   //AES Subbytes first operation 
   
   

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
sub_bytes sbytes_inst(.sboxw(hara_c == 1'b0 ? band : block_2),.new_sboxw(new_b_wire));

assign new_block_1 = (hara_c == 1'b0) ? band_2 : band;
assign new_block_2 = (hara_c == 1'b0) ? 256'b0 : band_2;


always @*
    begin : round_logic
        
        old_block_1 = shiftrows(block_1[255:128]); 
        old_block_1 = mixcolumns(old_block_1);
        band[255:128] = addroundkey(old_block_1, rc_1);
        
        old_block_2 = shiftrows(block_1[127:0]);
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

