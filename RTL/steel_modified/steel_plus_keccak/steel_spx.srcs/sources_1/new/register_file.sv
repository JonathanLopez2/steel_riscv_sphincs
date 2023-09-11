`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.05.2023 19:17:06
// Design Name: 
// Module Name: register_file
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


module register_file(
  
  input wire            clock,
 
  //FPU
  input wire FPU,
  input wire store_fpu,
  
  // Signals used in pipeline stage 2
  input wire    [4:0]   rs1_addr,
  input wire    [4:0]   rs2_addr,    
  output logic   [31:0]  rs1_data,
  output logic   [31:0]  rs2_data,
  
  // Signals used in pipeline stage 3
  input wire    [4:0]   rd_addr,
  input wire            write_enable,
  input wire    [31:0]  rd_data,
  
  // Ports used by HASHES
  // Keccak
  input  logic [1023:0]   wdata_hash_i_vector,
  input  logic [31:0] we_hash_i,
  output logic [1023:0] rdata_hash_o_vector,

  input  logic [575:0]   wdata_hash_gp_i_vector,
  input  logic [17:0] we_hash_gp_i,
  output logic [575:0] rdata_hash_gp_o_vector
  
//  //Haraka
//  input  logic [255:0] new_block_1,
//  input  logic [255:0] new_block_2,
//  input  logic [31:0]   we_haraka,
  
//  output logic [255:0] block_top_1,
//  output logic [255:0] block_top_2
  );
  
  //Integer register  
  reg [31:0] Q [31:1];
  // FP register
  reg [31:0] Q_fp [31:0];
  
//  // write enable signals for all registers
  logic [31:0]  we_dec;
  
  
  logic [31:0] wdata_hash_gp [31:0];
  logic [31:0] we_hash_gp;
 
  assign wdata_hash_gp[0] = '0;
  assign wdata_hash_gp[1] = '0;
  assign wdata_hash_gp[2] = '0;
  assign wdata_hash_gp[3] = '0;
  assign wdata_hash_gp[4] = '0;
  assign wdata_hash_gp[5] = wdata_hash_gp_i_vector[31:0   ];
  assign wdata_hash_gp[6] = wdata_hash_gp_i_vector[63:32  ];
  assign wdata_hash_gp[7] = wdata_hash_gp_i_vector[95:64  ];
  assign wdata_hash_gp[8] = '0;
  assign wdata_hash_gp[9] = wdata_hash_gp_i_vector[127:96 ];
  assign wdata_hash_gp[10] = '0;
  assign wdata_hash_gp[11] = '0;
  assign wdata_hash_gp[12] = '0;
  assign wdata_hash_gp[13] = '0;
  assign wdata_hash_gp[14] = '0;
  assign wdata_hash_gp[15] = '0;
  assign wdata_hash_gp[16] = '0;
  assign wdata_hash_gp[17] = '0;
  assign wdata_hash_gp[18] = wdata_hash_gp_i_vector[159:128];
  assign wdata_hash_gp[19] = wdata_hash_gp_i_vector[191:160];
  assign wdata_hash_gp[20] = wdata_hash_gp_i_vector[223:192];
  assign wdata_hash_gp[21] = wdata_hash_gp_i_vector[255:224];
  assign wdata_hash_gp[22] = wdata_hash_gp_i_vector[287:256];
  assign wdata_hash_gp[23] = wdata_hash_gp_i_vector[319:288];
  assign wdata_hash_gp[24] = wdata_hash_gp_i_vector[351:320];
  assign wdata_hash_gp[25] = wdata_hash_gp_i_vector[383:352];
  assign wdata_hash_gp[26] = wdata_hash_gp_i_vector[415:384];
  assign wdata_hash_gp[27] = wdata_hash_gp_i_vector[447:416];
  assign wdata_hash_gp[28] = wdata_hash_gp_i_vector[479:448];
  assign wdata_hash_gp[29] = wdata_hash_gp_i_vector[511:480];
  assign wdata_hash_gp[30] = wdata_hash_gp_i_vector[543:512];
  assign wdata_hash_gp[31] = wdata_hash_gp_i_vector[575:544];

  assign we_hash_gp[0] = '0;
  assign we_hash_gp[1] = '0;
  assign we_hash_gp[2] = '0;
  assign we_hash_gp[3] = '0;
  assign we_hash_gp[4] = '0;
  assign we_hash_gp[5] = we_hash_gp_i[0];
  assign we_hash_gp[6] = we_hash_gp_i[1];
  assign we_hash_gp[7] = we_hash_gp_i[2];
  assign we_hash_gp[8] = '0;
  assign we_hash_gp[9] = we_hash_gp_i[3];
  assign we_hash_gp[10] = '0;
  assign we_hash_gp[11] = '0;
  assign we_hash_gp[12] = '0;
  assign we_hash_gp[13] = '0;
  assign we_hash_gp[14] = '0;
  assign we_hash_gp[15] = '0;
  assign we_hash_gp[16] = '0;
  assign we_hash_gp[17] = '0;
  assign we_hash_gp[18] = we_hash_gp_i[4];
  assign we_hash_gp[19] = we_hash_gp_i[5];
  assign we_hash_gp[20] = we_hash_gp_i[6];
  assign we_hash_gp[21] = we_hash_gp_i[7];
  assign we_hash_gp[22] = we_hash_gp_i[8];
  assign we_hash_gp[23] = we_hash_gp_i[9];
  assign we_hash_gp[24] = we_hash_gp_i[10];
  assign we_hash_gp[25] = we_hash_gp_i[11];
  assign we_hash_gp[26] = we_hash_gp_i[12];
  assign we_hash_gp[27] = we_hash_gp_i[13];
  assign we_hash_gp[28] = we_hash_gp_i[14];
  assign we_hash_gp[29] = we_hash_gp_i[15];
  assign we_hash_gp[30] = we_hash_gp_i[16];
  assign we_hash_gp[31] = we_hash_gp_i[17];
  
//  //group vector into matrix
  logic [31:0] wdata_hash_i [31:0];
  
  assign wdata_hash_i[0]  = wdata_hash_i_vector[31:0];    
  assign wdata_hash_i[1]  = wdata_hash_i_vector[63:32];   
  assign wdata_hash_i[2]  = wdata_hash_i_vector[95:64];   
  assign wdata_hash_i[3]  = wdata_hash_i_vector[127:96];  
  assign wdata_hash_i[4]  = wdata_hash_i_vector[159:128]; 
  assign wdata_hash_i[5]  = wdata_hash_i_vector[191:160]; 
  assign wdata_hash_i[6]  = wdata_hash_i_vector[223:192]; 
  assign wdata_hash_i[7]  = wdata_hash_i_vector[255:224]; 
  assign wdata_hash_i[8]  = wdata_hash_i_vector[287:256]; 
  assign wdata_hash_i[9]  = wdata_hash_i_vector[319:288]; 
  assign wdata_hash_i[10] = wdata_hash_i_vector[351:320]; 
  assign wdata_hash_i[11] = wdata_hash_i_vector[383:352]; 
  assign wdata_hash_i[12] = wdata_hash_i_vector[415:384]; 
  assign wdata_hash_i[13] = wdata_hash_i_vector[447:416]; 
  assign wdata_hash_i[14] = wdata_hash_i_vector[479:448]; 
  assign wdata_hash_i[15] = wdata_hash_i_vector[511:480]; 
  assign wdata_hash_i[16] = wdata_hash_i_vector[543:512]; 
  assign wdata_hash_i[17] = wdata_hash_i_vector[575:544]; 
  assign wdata_hash_i[18] = wdata_hash_i_vector[607:576]; 
  assign wdata_hash_i[19] = wdata_hash_i_vector[639:608]; 
  assign wdata_hash_i[20] = wdata_hash_i_vector[671:640]; 
  assign wdata_hash_i[21] = wdata_hash_i_vector[703:672]; 
  assign wdata_hash_i[22] = wdata_hash_i_vector[735:704]; 
  assign wdata_hash_i[23] = wdata_hash_i_vector[767:736]; 
  assign wdata_hash_i[24] = wdata_hash_i_vector[799:768]; 
  assign wdata_hash_i[25] = wdata_hash_i_vector[831:800]; 
  assign wdata_hash_i[26] = wdata_hash_i_vector[863:832]; 
  assign wdata_hash_i[27] = wdata_hash_i_vector[895:864]; 
  assign wdata_hash_i[28] = wdata_hash_i_vector[927:896]; 
  assign wdata_hash_i[29] = wdata_hash_i_vector[959:928]; 
  assign wdata_hash_i[30] = wdata_hash_i_vector[991:960]; 
  assign wdata_hash_i[31] = wdata_hash_i_vector[1023:992];
  
//  //group vector into matrix Haraka
//  logic [31:0] wdata_haraka_i [31:0];
  
//  assign wdata_haraka_i[0]  = new_block_2[31:0   ];  
//  assign wdata_haraka_i[1]  = new_block_2[63:32  ];
//  assign wdata_haraka_i[2]  = new_block_2[95:64  ];
//  assign wdata_haraka_i[3]  = new_block_2[127:96 ];
//  assign wdata_haraka_i[4]  = new_block_2[159:128];
//  assign wdata_haraka_i[5]  = new_block_2[191:160];
//  assign wdata_haraka_i[6]  = new_block_2[223:192];
//  assign wdata_haraka_i[7]  = new_block_2[255:224];
//  assign wdata_haraka_i[8]  = new_block_1[31:0   ];
//  assign wdata_haraka_i[9]  = new_block_1[63:32  ];
//  assign wdata_haraka_i[10] = new_block_1[95:64  ];
//  assign wdata_haraka_i[11] = new_block_1[127:96 ];
//  assign wdata_haraka_i[12] = new_block_1[159:128];
//  assign wdata_haraka_i[13] = new_block_1[191:160];
//  assign wdata_haraka_i[14] = new_block_1[223:192];
//  assign wdata_haraka_i[15] = new_block_1[255:224];
  
//  assign wdata_haraka_i[16] = '0;
//  assign wdata_haraka_i[17] = '0;
//  assign wdata_haraka_i[18] = '0;
//  assign wdata_haraka_i[19] = '0;
//  assign wdata_haraka_i[20] = '0;
//  assign wdata_haraka_i[21] = '0;
//  assign wdata_haraka_i[22] = '0;
//  assign wdata_haraka_i[23] = '0;
//  assign wdata_haraka_i[24] = '0;
//  assign wdata_haraka_i[25] = '0;
//  assign wdata_haraka_i[26] = '0;
//  assign wdata_haraka_i[27] = '0;
//  assign wdata_haraka_i[28] = '0;
//  assign wdata_haraka_i[29] = '0;
//  assign wdata_haraka_i[30] = '0;
//  assign wdata_haraka_i[31] = '0;
  
  
  
  
  
   //-----------------------------------------------------------------------------
   //-- READ : Read address decoder RAD
   //-----------------------------------------------------------------------------
   
   always_comb
   begin
     rs1_data = rs1_addr == 5'b00000 ? 32'h00000000 : rs1_addr == rd_addr && write_enable == 1'b1 ?  rd_data : Q[rs1_addr];       
     rs2_data = store_fpu == 1'b1 ? Q_fp[rs2_addr] :rs2_addr == 5'b00000 ? 32'h00000000 : rs2_addr == rd_addr && write_enable == 1'b1 ?  rd_data : Q[rs2_addr];
   end
   
  //-----------------------------------------------------------------------------
  //-- WRITE : Write Address Decoder (WAD), combinatorial process
  //-----------------------------------------------------------------------------
  always_comb
  begin : we_decoder
    for (int i = 0; i < 32; i++) begin
      if (rd_addr == i)
        we_dec[i] = (write_enable | FPU);
      else
        we_dec[i] = 1'b0;
    end
  end

//   //-----------------------------------------------------------------------------
//   //-- WRITE : Write operation
//   //-----------------------------------------------------------------------------
    
   initial
    for (int i=1; i <= 31; i=i+1)
      Q[i] <= 32'h00000000;
   
   initial
    for (int i=0; i <= 31; i=i+1)
      Q_fp[i] <= 32'h00000000;
   
   genvar i,j;
   generate
   
   for (i = 1; i < 32; i++)
    begin : integer_register
      always_ff @(posedge clock)
      begin : register_write_behavioral
          if(we_dec[i] == 1'b1 && FPU == 1'b0)
            Q[i] <= rd_data;
          else if (we_hash_gp[i] == 1'b1)
            Q[i] <= wdata_hash_gp[i];
       end
    end
    
    for (j = 0; j < 32; j++)
    begin 
      always_ff @(posedge clock)
      begin : fp_registers
          if(we_dec[j] == 1'b1 && FPU == 1'b1)
            Q_fp[j] <= rd_data;
          else if (we_hash_i[j] == 1'b1)
            Q_fp[j] <= wdata_hash_i[j];
//          else if (we_haraka[j] == 1'b1)
//            Q_fp[j] <= wdata_haraka_i[j];
       end
    end
    endgenerate
  
  // PQ Read
  // Keccak
    assign rdata_hash_o_vector[31:0]    = Q_fp[0];
    assign rdata_hash_o_vector[63:32  ] = Q_fp[1] ;
    assign rdata_hash_o_vector[95:64  ] = Q_fp[2] ;
    assign rdata_hash_o_vector[127:96 ] = Q_fp[3] ;
    assign rdata_hash_o_vector[159:128] = Q_fp[4] ;
    assign rdata_hash_o_vector[191:160] = Q_fp[5] ;
    assign rdata_hash_o_vector[223:192] = Q_fp[6] ;
    assign rdata_hash_o_vector[255:224] = Q_fp[7] ;
    assign rdata_hash_o_vector[287:256] = Q_fp[8] ;
    assign rdata_hash_o_vector[319:288] = Q_fp[9] ;
    assign rdata_hash_o_vector[351:320] = Q_fp[10];
    assign rdata_hash_o_vector[383:352] = Q_fp[11];
    assign rdata_hash_o_vector[415:384] = Q_fp[12];
    assign rdata_hash_o_vector[447:416] = Q_fp[13];
    assign rdata_hash_o_vector[479:448] = Q_fp[14];
    assign rdata_hash_o_vector[511:480] = Q_fp[15];
    assign rdata_hash_o_vector[543:512] = Q_fp[16];
    assign rdata_hash_o_vector[575:544] = Q_fp[17];
    assign rdata_hash_o_vector[607:576] = Q_fp[18];
    assign rdata_hash_o_vector[639:608] = Q_fp[19];
    assign rdata_hash_o_vector[671:640] = Q_fp[20];
    assign rdata_hash_o_vector[703:672] = Q_fp[21];
    assign rdata_hash_o_vector[735:704] = Q_fp[22];
    assign rdata_hash_o_vector[767:736] = Q_fp[23];
    assign rdata_hash_o_vector[799:768] = Q_fp[24];
    assign rdata_hash_o_vector[831:800] = Q_fp[25];
    assign rdata_hash_o_vector[863:832] = Q_fp[26];
    assign rdata_hash_o_vector[895:864] = Q_fp[27];
    assign rdata_hash_o_vector[927:896] = Q_fp[28];
    assign rdata_hash_o_vector[959:928] = Q_fp[29];
    assign rdata_hash_o_vector[991:960] = Q_fp[30];
    assign rdata_hash_o_vector[1023:992]= Q_fp[31];
    
    assign rdata_hash_gp_o_vector[31:0   ] = Q[5];
    assign rdata_hash_gp_o_vector[63:32  ] = Q[6];
    assign rdata_hash_gp_o_vector[95:64  ] = Q[7];
    assign rdata_hash_gp_o_vector[127:96 ] = Q[9];
    assign rdata_hash_gp_o_vector[159:128] = Q[18];
    assign rdata_hash_gp_o_vector[191:160] = Q[19];
    assign rdata_hash_gp_o_vector[223:192] = Q[20];
    assign rdata_hash_gp_o_vector[255:224] = Q[21];
    assign rdata_hash_gp_o_vector[287:256] = Q[22];
    assign rdata_hash_gp_o_vector[319:288] = Q[23];
    assign rdata_hash_gp_o_vector[351:320] = Q[24];
    assign rdata_hash_gp_o_vector[383:352] = Q[25];
    assign rdata_hash_gp_o_vector[415:384] = Q[26];
    assign rdata_hash_gp_o_vector[447:416] = Q[27];
    assign rdata_hash_gp_o_vector[479:448] = Q[28];
    assign rdata_hash_gp_o_vector[511:480] = Q[29];
    assign rdata_hash_gp_o_vector[543:512] = Q[30];
    assign rdata_hash_gp_o_vector[575:544] = Q[31];
    
//    //Haraka
//    assign block_top_1[255:224] = Q_fp[15] ;
//    assign block_top_1[223:192] = Q_fp[14] ;
//    assign block_top_1[191:160] = Q_fp[13] ;
//    assign block_top_1[159:128] = Q_fp[12] ;
//    assign block_top_1[127:96 ] = Q_fp[11] ;
//    assign block_top_1[95:64  ] = Q_fp[10] ;
//    assign block_top_1[63:32  ] = Q_fp[9] ;
//    assign block_top_1[31:0   ] = Q_fp[8] ;
    
//    assign block_top_2[255:224] = Q_fp[7] ;
//    assign block_top_2[223:192] = Q_fp[6] ;
//    assign block_top_2[191:160] = Q_fp[5];
//    assign block_top_2[159:128] = Q_fp[4];
//    assign block_top_2[127:96 ] = Q_fp[3];
//    assign block_top_2[95:64  ] = Q_fp[2];
//    assign block_top_2[63:32  ] = Q_fp[1];
//    assign block_top_2[31:0   ] = Q_fp[0];

endmodule


