`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2023 05:59:53 PM
// Design Name: 
// Module Name: hashes
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


module hashes(
    //memory
    input  logic            clock,
    input  logic            we,   
        
    // Haraka_operations
    input  logic [255:0]  block_top_1,
    input  logic [255:0]  block_top_2,
    input  logic [3:0]    round,       
    input  logic [1:0]    round_aes,   
    input  logic          hara_c,      
    input  logic          haraka_start,
    input  logic          end_round,
    output logic [255:0]  new_block_1,
    output logic [255:0]  new_block_2,
    output logic [31:0]   we_haraka, 
    
    // Keccak operations
    input  logic keccak_f_start,
    input  logic [4:0] keccak_round,
    input  logic keccak_rst,
        
    // Ports used by HASHES
    output logic [1023:0]   wdata_hash_o_vector,
    output logic [31:0] we_hash_o,
    input  logic [1023:0] rdata_hash_i_vector,
    
    output logic [575:0]   wdata_hash_gp_o_vector,
    output logic [17:0] we_hash_gp_o,
    input  logic [575:0] rdata_hash_gp_i_vector
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
     wire [255:0] w_block;
    sub_bytes sbytes_inst(.sboxw(block_top_1),.new_sboxw(w_block));
    
    haraka_core haraka_core_intance(.hara_c(hara_c), .block_top_1(w_block),.block_top_2(block_top_2),.round(round),.round_aes(round_aes), .new_block_1(mix_1),.new_block_2(mix_2));
    
    mix256 mix256_inst(.block(mix_1), .out_mix(o_mix_256));
    
    wire [511:0] mix512_sel;
    mix512 mix512_inst(.block({mix_1,mix_2}), .out_mix(mix512_sel));
    
    assign o_mix_512 = (round_aes[0] == 1'b1) ? mix512_sel : {mix_1,mix_2} ;
    
    f_forward f_forward_instance(.block(o_mix_256), .msg(rs1_data), .out_forward(o_forward_256));
    
    f_forward_512 f_forward_512_instance(.block(o_mix_512), .msg({rs1_data,rs2_data}), .out_forward(o_forward_512));
    
    //assign forward_sel = hara_c  ? o_forward_256 :o_mix_256;
    
    assign new_block_1 = end_round? (hara_c == 1'b1)? o_forward_512[511:256]:o_forward_256   :  (hara_c == 1'b1)? o_mix_512[511:256]:o_mix_256 ;
    assign new_block_2 = end_round? (hara_c == 1'b1)? o_forward_512[255:0]  : 256'b0         :  (hara_c == 1'b1)? o_mix_512[255:0]  : 256'b0 ;
  
  // Instace keccack
    logic [31:0] output_state [49:0];
  
  // vector to matrix inputs 
    logic [31:0] input_state [49:0];
    
    assign input_state[0]  = rdata_hash_i_vector[31:0];
    assign input_state[1]  = rdata_hash_i_vector[63:32];
    assign input_state[2]  = rdata_hash_i_vector[95:64];
    assign input_state[3]  = rdata_hash_i_vector[127:96];
    assign input_state[4]  = rdata_hash_i_vector[159:128];
    assign input_state[5]  = rdata_hash_i_vector[191:160];
    assign input_state[6]  = rdata_hash_i_vector[223:192];
    assign input_state[7]  = rdata_hash_i_vector[255:224];
    assign input_state[8]  = rdata_hash_i_vector[287:256];
    assign input_state[9]  = rdata_hash_i_vector[319:288];
    assign input_state[10] = rdata_hash_i_vector[351:320];
    assign input_state[11] = rdata_hash_i_vector[383:352];
    assign input_state[12] = rdata_hash_i_vector[415:384];
    assign input_state[13] = rdata_hash_i_vector[447:416];
    assign input_state[14] = rdata_hash_i_vector[479:448];
    assign input_state[15] = rdata_hash_i_vector[511:480];
    assign input_state[16] = rdata_hash_i_vector[543:512];
    assign input_state[17] = rdata_hash_i_vector[575:544];
    assign input_state[18] = rdata_hash_i_vector[607:576];
    assign input_state[19] = rdata_hash_i_vector[639:608];
    assign input_state[20] = rdata_hash_i_vector[671:640];
    assign input_state[21] = rdata_hash_i_vector[703:672];
    assign input_state[22] = rdata_hash_i_vector[735:704];
    assign input_state[23] = rdata_hash_i_vector[767:736];
    assign input_state[24] = rdata_hash_i_vector[799:768];
    assign input_state[25] = rdata_hash_i_vector[831:800];
    assign input_state[26] = rdata_hash_i_vector[863:832];
    assign input_state[27] = rdata_hash_i_vector[895:864];
    assign input_state[28] = rdata_hash_i_vector[927:896];
    assign input_state[29] = rdata_hash_i_vector[959:928];
    assign input_state[30] = rdata_hash_i_vector[991:960];
    assign input_state[31] = rdata_hash_i_vector[1023:992];
    
    assign input_state[32] = rdata_hash_gp_i_vector[31:0   ];
    assign input_state[33] = rdata_hash_gp_i_vector[63:32  ];
    assign input_state[34] = rdata_hash_gp_i_vector[95:64  ];
    assign input_state[35] = rdata_hash_gp_i_vector[127:96 ];
    assign input_state[36] = rdata_hash_gp_i_vector[159:128];
    assign input_state[37] = rdata_hash_gp_i_vector[191:160];
    assign input_state[38] = rdata_hash_gp_i_vector[223:192];
    assign input_state[39] = rdata_hash_gp_i_vector[255:224];
    assign input_state[40] = rdata_hash_gp_i_vector[287:256];
    assign input_state[41] = rdata_hash_gp_i_vector[319:288];
    assign input_state[42] = rdata_hash_gp_i_vector[351:320];
    assign input_state[43] = rdata_hash_gp_i_vector[383:352];
    assign input_state[44] = rdata_hash_gp_i_vector[415:384];
    assign input_state[45] = rdata_hash_gp_i_vector[447:416];
    assign input_state[46] = rdata_hash_gp_i_vector[479:448];
    assign input_state[47] = rdata_hash_gp_i_vector[511:480];
    assign input_state[48] = rdata_hash_gp_i_vector[543:512];
    assign input_state[49] = rdata_hash_gp_i_vector[575:544];
    
    
    
    
  
  // Keccak module 
    keccak_f keccak_f_instace 
    (
      .input_state(input_state),
      .round(keccak_round),
      .rst(keccak_rst),
      .output_state(output_state)
    );
    
    // write enable assignment
    assign we_hash_o = (keccak_f_start == 1'b1) ? 32'hffffffff : 32'h00000000;
    assign we_hash_gp_o = (keccak_f_start == 1'b1) ? 18'h3ffff : 18'h00000;
    assign we_haraka = (haraka_start == 1'b1) ? (hara_c == 1'b1)? 32'h0000ffff:32'h0000ff00: 32'h00000000;
    
    //output assignment
    //assign wdata_hash_o = output_state[31:0];
    //assign wdata_hash_gp_o = output_state[49:32];
    
    // vector to matrix output 
    
    assign wdata_hash_o_vector[31:0   ] = output_state[0] ;
    assign wdata_hash_o_vector[63:32  ] = output_state[1] ;
    assign wdata_hash_o_vector[95:64  ] = output_state[2] ;
    assign wdata_hash_o_vector[127:96 ] = output_state[3] ;
    assign wdata_hash_o_vector[159:128] = output_state[4] ;
    assign wdata_hash_o_vector[191:160] = output_state[5] ;
    assign wdata_hash_o_vector[223:192] = output_state[6] ;
    assign wdata_hash_o_vector[255:224] = output_state[7] ;
    assign wdata_hash_o_vector[287:256] = output_state[8] ;
    assign wdata_hash_o_vector[319:288] = output_state[9] ;
    assign wdata_hash_o_vector[351:320] = output_state[10];
    assign wdata_hash_o_vector[383:352] = output_state[11];
    assign wdata_hash_o_vector[415:384] = output_state[12];
    assign wdata_hash_o_vector[447:416] = output_state[13];
    assign wdata_hash_o_vector[479:448] = output_state[14];
    assign wdata_hash_o_vector[511:480] = output_state[15];
    assign wdata_hash_o_vector[543:512] = output_state[16];
    assign wdata_hash_o_vector[575:544] = output_state[17];
    assign wdata_hash_o_vector[607:576] = output_state[18];
    assign wdata_hash_o_vector[639:608] = output_state[19];
    assign wdata_hash_o_vector[671:640] = output_state[20];
    assign wdata_hash_o_vector[703:672] = output_state[21];
    assign wdata_hash_o_vector[735:704] = output_state[22];
    assign wdata_hash_o_vector[767:736] = output_state[23];
    assign wdata_hash_o_vector[799:768] = output_state[24];
    assign wdata_hash_o_vector[831:800] = output_state[25];
    assign wdata_hash_o_vector[863:832] = output_state[26];
    assign wdata_hash_o_vector[895:864] = output_state[27];
    assign wdata_hash_o_vector[927:896] = output_state[28];
    assign wdata_hash_o_vector[959:928] = output_state[29];
    assign wdata_hash_o_vector[991:960] = output_state[30];
    assign wdata_hash_o_vector[1023:992]= output_state[31];


    assign wdata_hash_gp_o_vector [31:0   ] = output_state[32];
    assign wdata_hash_gp_o_vector [63:32  ] = output_state[33];
    assign wdata_hash_gp_o_vector [95:64  ] = output_state[34];
    assign wdata_hash_gp_o_vector [127:96 ] = output_state[35];
    assign wdata_hash_gp_o_vector [159:128] = output_state[36];
    assign wdata_hash_gp_o_vector [191:160] = output_state[37];
    assign wdata_hash_gp_o_vector [223:192] = output_state[38];
    assign wdata_hash_gp_o_vector [255:224] = output_state[39];
    assign wdata_hash_gp_o_vector [287:256] = output_state[40];
    assign wdata_hash_gp_o_vector [319:288] = output_state[41];
    assign wdata_hash_gp_o_vector [351:320] = output_state[42];
    assign wdata_hash_gp_o_vector [383:352] = output_state[43];
    assign wdata_hash_gp_o_vector [415:384] = output_state[44];
    assign wdata_hash_gp_o_vector [447:416] = output_state[45];
    assign wdata_hash_gp_o_vector [479:448] = output_state[46];
    assign wdata_hash_gp_o_vector [511:480] = output_state[47];
    assign wdata_hash_gp_o_vector [543:512] = output_state[48];
    assign wdata_hash_gp_o_vector [575:544] = output_state[49];
    
endmodule
