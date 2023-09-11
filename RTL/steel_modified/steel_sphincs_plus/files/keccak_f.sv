//////////////////////////////////////////////////////////////////////////////////
// Company: Technical University of Munich
// Engineer: Tim Fritzmann
// 
// Create Date: 01/27/2020
// Module Name: keccak_f
// Project Name: Post-Quantum Cryptography
// 
//////////////////////////////////////////////////////////////////////////////////
//module sponge(
//  input logic [31:0] input_state [49:0],
//  input logic [4:0] round,
//  input logic rst,
//  output logic [31:0] output_state [49:0]);
  
//  logic [31:0]buffer[49:0];
  
//  //Absorb data(fixed lenght)
  
//  //PAD
//  assign buffer[0]   = 32'b0 ^ input_state[0];
//  assign buffer[1]   = 32'h0000001f;
//  assign buffer[2]   = 32'b0;
//  assign buffer[3]   = 32'b0;
//  assign buffer[4]   = 32'b0;
//  assign buffer[5]   = 32'b0;
//  assign buffer[6]   = 32'b0;
//  assign buffer[7]   = 32'b0;
//  assign buffer[8]   = 32'b0;
//  assign buffer[9]   = 32'b0;
//  assign buffer[10]  = 32'b0;
//  assign buffer[11]  = 32'b0;
//  assign buffer[12]  = 32'b0;
//  assign buffer[13]  = 32'b0;
//  assign buffer[14]  = 32'b0;
//  assign buffer[15]  = 32'b0;
//  assign buffer[16]  = 32'b0;
//  assign buffer[17]  = 32'b0;
//  assign buffer[18]  = 32'b0;
//  assign buffer[19]  = 32'b0;
//  assign buffer[20]  = 32'b0;
//  assign buffer[21]  = 32'b0;
//  assign buffer[22]  = 32'b0;
//  assign buffer[23]  = 32'b0;
//  assign buffer[24]  = 32'b0;
//  assign buffer[25]  = 32'b0;
//  assign buffer[26]  = 32'b0;
//  assign buffer[27]  = 32'b0;
//  assign buffer[28]  = 32'b0;
//  assign buffer[29]  = 32'b0;
//  assign buffer[30]  = 32'b0;
//  assign buffer[31]  = 32'b0;
//  assign buffer[32]  = 32'b0;
//  assign buffer[33]  = 32'h80000000;
//  assign buffer[34]  = 32'b0;
//  assign buffer[35]  = 32'b0;
//  assign buffer[36]  = 32'b0;
//  assign buffer[37]  = 32'b0;
//  assign buffer[38]  = 32'b0;
//  assign buffer[39]  = 32'b0;
//  assign buffer[40]  = 32'b0;
//  assign buffer[41]  = 32'b0;
//  assign buffer[42]  = 32'b0;
//  assign buffer[43]  = 32'b0;
//  assign buffer[44]  = 32'b0;
//  assign buffer[45]  = 32'b0;
//  assign buffer[46]  = 32'b0;
//  assign buffer[47]  = 32'b0;
//  assign buffer[48]  = 32'b0;
//  assign buffer[49]  = 32'b0;
  
  
//  logic [31:0]output_state0[49:0];
//  parameter round2 = 5'b00001;
//  //Instace keccak f.1600
//  keccak_f round_1(.input_state(buffer)  ,  .round(round),  .rst(rst), .output_state(output_state0));
//  keccak_f round_2(.input_state(output_state0)  ,  .round(round2),  .rst(rst), .output_state(output_state));

//endmodule



module keccak_f(
  input logic [31:0] input_state [49:0],
  input logic [4:0] round,
  input logic rst,
  output logic [31:0] output_state [49:0]
);
  // Theta function
  logic [31:0] output_state_theta [49:0];
  logic [63:0] parity [4:0];
  
  assign parity[0] = {input_state[0] ^ input_state[10] ^ input_state[20] ^ input_state[30] ^ input_state[40], input_state[1] ^ input_state[11] ^ input_state[21] ^ input_state[31] ^ input_state[41]};
  assign parity[1] = {input_state[2] ^ input_state[12] ^ input_state[22] ^ input_state[32] ^ input_state[42], input_state[3] ^ input_state[13] ^ input_state[23] ^ input_state[33] ^ input_state[43]};
  assign parity[2] = {input_state[4] ^ input_state[14] ^ input_state[24] ^ input_state[34] ^ input_state[44], input_state[5] ^ input_state[15] ^ input_state[25] ^ input_state[35] ^ input_state[45]};
  assign parity[3] = {input_state[6] ^ input_state[16] ^ input_state[26] ^ input_state[36] ^ input_state[46], input_state[7] ^ input_state[17] ^ input_state[27] ^ input_state[37] ^ input_state[47]};
  assign parity[4] = {input_state[8] ^ input_state[18] ^ input_state[28] ^ input_state[38] ^ input_state[48], input_state[9] ^ input_state[19] ^ input_state[29] ^ input_state[39] ^ input_state[49]};

  assign output_state_theta[0] = input_state[0] ^ parity[4][63:32] ^ parity[1][62:31];
  assign output_state_theta[1] = input_state[1] ^ parity[4][31:0] ^ {parity[1][30:0],parity[1][63]};
  assign output_state_theta[2] = input_state[2] ^ parity[0][63:32] ^ parity[2][62:31];
  assign output_state_theta[3] = input_state[3] ^ parity[0][31:0] ^ {parity[2][30:0],parity[2][63]};
  assign output_state_theta[4] = input_state[4] ^ parity[1][63:32] ^ parity[3][62:31];
  assign output_state_theta[5] = input_state[5] ^ parity[1][31:0] ^ {parity[3][30:0],parity[3][63]};
  assign output_state_theta[6] = input_state[6] ^ parity[2][63:32] ^ parity[4][62:31];
  assign output_state_theta[7] = input_state[7] ^ parity[2][31:0] ^ {parity[4][30:0],parity[4][63]};
  assign output_state_theta[8] = input_state[8] ^ parity[3][63:32] ^ parity[0][62:31];
  assign output_state_theta[9] = input_state[9] ^ parity[3][31:0] ^ {parity[0][30:0],parity[0][63]};
  assign output_state_theta[10] = input_state[10] ^ parity[4][63:32] ^ parity[1][62:31];
  assign output_state_theta[11] = input_state[11] ^ parity[4][31:0] ^ {parity[1][30:0],parity[1][63]};
  assign output_state_theta[12] = input_state[12] ^ parity[0][63:32] ^ parity[2][62:31];
  assign output_state_theta[13] = input_state[13] ^ parity[0][31:0] ^ {parity[2][30:0],parity[2][63]};
  assign output_state_theta[14] = input_state[14] ^ parity[1][63:32] ^ parity[3][62:31];
  assign output_state_theta[15] = input_state[15] ^ parity[1][31:0] ^ {parity[3][30:0],parity[3][63]};
  assign output_state_theta[16] = input_state[16] ^ parity[2][63:32] ^ parity[4][62:31];
  assign output_state_theta[17] = input_state[17] ^ parity[2][31:0] ^ {parity[4][30:0],parity[4][63]};
  assign output_state_theta[18] = input_state[18] ^ parity[3][63:32] ^ parity[0][62:31];
  assign output_state_theta[19] = input_state[19] ^ parity[3][31:0] ^ {parity[0][30:0],parity[0][63]};
  assign output_state_theta[20] = input_state[20] ^ parity[4][63:32] ^ parity[1][62:31];
  assign output_state_theta[21] = input_state[21] ^ parity[4][31:0] ^ {parity[1][30:0],parity[1][63]};
  assign output_state_theta[22] = input_state[22] ^ parity[0][63:32] ^ parity[2][62:31];
  assign output_state_theta[23] = input_state[23] ^ parity[0][31:0] ^ {parity[2][30:0],parity[2][63]};
  assign output_state_theta[24] = input_state[24] ^ parity[1][63:32] ^ parity[3][62:31];
  assign output_state_theta[25] = input_state[25] ^ parity[1][31:0] ^ {parity[3][30:0],parity[3][63]};
  assign output_state_theta[26] = input_state[26] ^ parity[2][63:32] ^ parity[4][62:31];
  assign output_state_theta[27] = input_state[27] ^ parity[2][31:0] ^ {parity[4][30:0],parity[4][63]};
  assign output_state_theta[28] = input_state[28] ^ parity[3][63:32] ^ parity[0][62:31];
  assign output_state_theta[29] = input_state[29] ^ parity[3][31:0] ^ {parity[0][30:0],parity[0][63]};
  assign output_state_theta[30] = input_state[30] ^ parity[4][63:32] ^ parity[1][62:31];
  assign output_state_theta[31] = input_state[31] ^ parity[4][31:0] ^ {parity[1][30:0],parity[1][63]};
  assign output_state_theta[32] = input_state[32] ^ parity[0][63:32] ^ parity[2][62:31];
  assign output_state_theta[33] = input_state[33] ^ parity[0][31:0] ^ {parity[2][30:0],parity[2][63]};
  assign output_state_theta[34] = input_state[34] ^ parity[1][63:32] ^ parity[3][62:31];
  assign output_state_theta[35] = input_state[35] ^ parity[1][31:0] ^ {parity[3][30:0],parity[3][63]};
  assign output_state_theta[36] = input_state[36] ^ parity[2][63:32] ^ parity[4][62:31];
  assign output_state_theta[37] = input_state[37] ^ parity[2][31:0] ^ {parity[4][30:0],parity[4][63]};
  assign output_state_theta[38] = input_state[38] ^ parity[3][63:32] ^ parity[0][62:31];
  assign output_state_theta[39] = input_state[39] ^ parity[3][31:0] ^ {parity[0][30:0],parity[0][63]};
  assign output_state_theta[40] = input_state[40] ^ parity[4][63:32] ^ parity[1][62:31];
  assign output_state_theta[41] = input_state[41] ^ parity[4][31:0] ^ {parity[1][30:0],parity[1][63]};
  assign output_state_theta[42] = input_state[42] ^ parity[0][63:32] ^ parity[2][62:31];
  assign output_state_theta[43] = input_state[43] ^ parity[0][31:0] ^ {parity[2][30:0],parity[2][63]};
  assign output_state_theta[44] = input_state[44] ^ parity[1][63:32] ^ parity[3][62:31];
  assign output_state_theta[45] = input_state[45] ^ parity[1][31:0] ^ {parity[3][30:0],parity[3][63]};
  assign output_state_theta[46] = input_state[46] ^ parity[2][63:32] ^ parity[4][62:31];
  assign output_state_theta[47] = input_state[47] ^ parity[2][31:0] ^ {parity[4][30:0],parity[4][63]};
  assign output_state_theta[48] = input_state[48] ^ parity[3][63:32] ^ parity[0][62:31];
  assign output_state_theta[49] = input_state[49] ^ parity[3][31:0] ^ {parity[0][30:0],parity[0][63]};
  
  // Rho/Pi function
  logic [31:0] input_state_rho [49:0];
  logic [31:0] output_state_pi [49:0];
  
  
  // A[0,0], offset 0
  assign output_state_pi[0] = output_state_theta[0][31:0];
  assign output_state_pi[1] = output_state_theta[1][31:0];
  
  // A[1,0], offset 1
  assign output_state_pi[20] = {output_state_theta[2][30:0],output_state_theta[3][31]};
  assign output_state_pi[21] = {output_state_theta[3][30:0],output_state_theta[2][31]};
  
  // A[2,0], offset 62
  assign output_state_pi[40] = {output_state_theta[5][1:0],output_state_theta[4][31:2]};
  assign output_state_pi[41] = {output_state_theta[4][1:0],output_state_theta[5][31:2]};
  
  // A[3,0], offset 28
  assign output_state_pi[10] = {output_state_theta[6][3:0],output_state_theta[7][31:4]};
  assign output_state_pi[11] = {output_state_theta[7][3:0],output_state_theta[6][31:4]};
  
  // A[4,0], offset 27
  assign output_state_pi[30] = {output_state_theta[8][4:0],output_state_theta[9][31:5]};
  assign output_state_pi[31] = {output_state_theta[9][4:0],output_state_theta[8][31:5]};
  
  // A[0,1], offset 36
  assign output_state_pi[32] = {output_state_theta[11][27:0],output_state_theta[10][31:28]};
  assign output_state_pi[33] = {output_state_theta[10][27:0],output_state_theta[11][31:28]};
  
  // A[1,1], offset 44
  assign output_state_pi[2] = {output_state_theta[13][19:0],output_state_theta[12][31:20]};
  assign output_state_pi[3] = {output_state_theta[12][19:0],output_state_theta[13][31:20]};
  
  // A[2,1], offset 6
  assign output_state_pi[22] = {output_state_theta[14][25:0],output_state_theta[15][31:26]};
  assign output_state_pi[23] = {output_state_theta[15][25:0],output_state_theta[14][31:26]};
  
  // A[3,1], offset 55
  assign output_state_pi[42] = {output_state_theta[17][8:0],output_state_theta[16][31:9]};
  assign output_state_pi[43] = {output_state_theta[16][8:0],output_state_theta[17][31:9]};
  
  // A[4,1], offset 20
  assign output_state_pi[12] = {output_state_theta[18][11:0],output_state_theta[19][31:12]};
  assign output_state_pi[13] = {output_state_theta[19][11:0],output_state_theta[18][31:12]};
  
  // A[0,2], offset 3
  assign output_state_pi[14] = {output_state_theta[20][28:0],output_state_theta[21][31:29]};
  assign output_state_pi[15] = {output_state_theta[21][28:0],output_state_theta[20][31:29]};
  
  // A[1,2], offset 10
  assign output_state_pi[34] = {output_state_theta[22][21:0],output_state_theta[23][31:22]};
  assign output_state_pi[35] = {output_state_theta[23][21:0],output_state_theta[22][31:22]};
  
  // A[2,2], offset 43
  assign output_state_pi[4] = {output_state_theta[25][20:0],output_state_theta[24][31:21]};
  assign output_state_pi[5] = {output_state_theta[24][20:0],output_state_theta[25][31:21]};
  
  // A[3,2], offset 25
  assign output_state_pi[24] = {output_state_theta[26][6:0],output_state_theta[27][31:7]};
  assign output_state_pi[25] = {output_state_theta[27][6:0],output_state_theta[26][31:7]};
  
  // A[4,2], offset 39    
  assign output_state_pi[44] = {output_state_theta[29][24:0],output_state_theta[28][31:25]};
  assign output_state_pi[45] = {output_state_theta[28][24:0],output_state_theta[29][31:25]};
  
  // A[0,3], offset 41
  assign output_state_pi[46] = {output_state_theta[31][22:0],output_state_theta[30][31:23]};
  assign output_state_pi[47] = {output_state_theta[30][22:0],output_state_theta[31][31:23]};
  
  // A[1,3], offset 45
  assign output_state_pi[16] = {output_state_theta[33][18:0],output_state_theta[32][31:19]};
  assign output_state_pi[17] = {output_state_theta[32][18:0],output_state_theta[33][31:19]};
  
  // A[2,3], offset 15
  assign output_state_pi[36] = {output_state_theta[34][16:0],output_state_theta[35][31:17]};
  assign output_state_pi[37] = {output_state_theta[35][16:0],output_state_theta[34][31:17]};
  
  // A[3,3], offset 21
  assign output_state_pi[6] = {output_state_theta[36][10:0],output_state_theta[37][31:11]};
  assign output_state_pi[7] = {output_state_theta[37][10:0],output_state_theta[36][31:11]};
  
  // A[4,3], offset 8
  assign output_state_pi[26] = {output_state_theta[38][23:0],output_state_theta[39][31:24]};
  assign output_state_pi[27] = {output_state_theta[39][23:0],output_state_theta[38][31:24]};
  
  // A[0,4], offset 18
  assign output_state_pi[28] = {output_state_theta[40][13:0],output_state_theta[41][31:14]};
  assign output_state_pi[29] = {output_state_theta[41][13:0],output_state_theta[40][31:14]};
  
  // A[1,4], offset 2
  assign output_state_pi[48] = {output_state_theta[42][29:0],output_state_theta[43][31:30]};
  assign output_state_pi[49] = {output_state_theta[43][29:0],output_state_theta[42][31:30]};
  
  // A(2,4), offset 61
  assign output_state_pi[18] = {output_state_theta[45][2:0],output_state_theta[44][31:3]};
  assign output_state_pi[19] = {output_state_theta[44][2:0],output_state_theta[45][31:3]};
  
  // A(3,4), offset 56
  assign output_state_pi[38] = {output_state_theta[47][7:0],output_state_theta[46][31:8]};
  assign output_state_pi[39] = {output_state_theta[46][7:0],output_state_theta[47][31:8]};
  
  // A(4,4), offset 14
  assign output_state_pi[8] = {output_state_theta[48][17:0],output_state_theta[49][31:18]};
  assign output_state_pi[9] = {output_state_theta[49][17:0],output_state_theta[48][31:18]};
  
  // Chi/Iota function
  logic [31:0] round_constant [47:0];
  logic [31:0] input_state_chi [49:0];
  logic [31:0] output_state_iota [49:0];

  logic [31:0] zero_state [49:0];
  always_comb
  begin
    for (integer i=0; i<50; i++)
    begin
      zero_state[i] = 2'b00;
    end
  end
  
  assign input_state_chi = output_state_pi;
  assign output_state = (rst == 1'b0) ? output_state_iota : zero_state;
  
  assign round_constant[0] = 32'h00000001;
  assign round_constant[1] = 32'h00000000;
  assign round_constant[2] = 32'h00008082;
  assign round_constant[3] = 32'h00000000;
  assign round_constant[4] = 32'h0000808A;
  assign round_constant[5] = 32'h80000000;
  assign round_constant[6] = 32'h80008000;
  assign round_constant[7] = 32'h80000000;
  assign round_constant[8] = 32'h0000808B;
  assign round_constant[9] = 32'h00000000;
  assign round_constant[10] = 32'h80000001;
  assign round_constant[11] = 32'h00000000;
  assign round_constant[12] = 32'h80008081;
  assign round_constant[13] = 32'h80000000;
  assign round_constant[14] = 32'h00008009;
  assign round_constant[15] = 32'h80000000;
  assign round_constant[16] = 32'h0000008A;
  assign round_constant[17] = 32'h00000000;
  assign round_constant[18] = 32'h00000088;
  assign round_constant[19] = 32'h00000000;
  assign round_constant[20] = 32'h80008009;
  assign round_constant[21] = 32'h00000000;
  assign round_constant[22] = 32'h8000000A;
  assign round_constant[23] = 32'h00000000;
  assign round_constant[24] = 32'h8000808B;
  assign round_constant[25] = 32'h00000000;
  assign round_constant[26] = 32'h0000008B;
  assign round_constant[27] = 32'h80000000;
  assign round_constant[28] = 32'h00008089;
  assign round_constant[29] = 32'h80000000;
  assign round_constant[30] = 32'h00008003;
  assign round_constant[31] = 32'h80000000;
  assign round_constant[32] = 32'h00008002;
  assign round_constant[33] = 32'h80000000;
  assign round_constant[34] = 32'h00000080;
  assign round_constant[35] = 32'h80000000;
  assign round_constant[36] = 32'h0000800A;
  assign round_constant[37] = 32'h00000000;
  assign round_constant[38] = 32'h8000000A;
  assign round_constant[39] = 32'h80000000;
  assign round_constant[40] = 32'h80008081;
  assign round_constant[41] = 32'h80000000;
  assign round_constant[42] = 32'h00008080;
  assign round_constant[43] = 32'h80000000;
  assign round_constant[44] = 32'h80000001;
  assign round_constant[45] = 32'h00000000;
  assign round_constant[46] = 32'h80008008;
  assign round_constant[47] = 32'h80000000;
  
  assign output_state_iota[0] = (input_state_chi[0] ^ (~input_state_chi[2] & input_state_chi[4])) ^ round_constant[2*round];
  assign output_state_iota[1] = (input_state_chi[1] ^ (~input_state_chi[3] & input_state_chi[5])) ^ round_constant[2*round+1];
  assign output_state_iota[2] = (input_state_chi[2] ^ (~input_state_chi[4] & input_state_chi[6]));
  assign output_state_iota[3] = (input_state_chi[3] ^ (~input_state_chi[5] & input_state_chi[7]));
  assign output_state_iota[4] = (input_state_chi[4] ^ (~input_state_chi[6] & input_state_chi[8]));
  assign output_state_iota[5] = (input_state_chi[5] ^ (~input_state_chi[7] & input_state_chi[9]));
  
  genvar i,j;
  generate
    for (j=1; j<5; j++) begin
      for (i=0; i < 6; i=i+2) begin
        assign output_state_iota[10*j+i] = (input_state_chi[10*j+i] ^ (~input_state_chi[10*j+i+2] & input_state_chi[10*j+i+4]));
        assign output_state_iota[10*j+i+1] = (input_state_chi[10*j+i+1] ^ (~input_state_chi[10*j+i+3] & input_state_chi[10*j+i+5]));
      end
    end
    
    for (j=0; j<5; j++) begin
        assign output_state_iota[10*j+6] = (input_state_chi[10*j+6] ^ (~input_state_chi[10*j+8] & input_state_chi[10*j]));
        assign output_state_iota[10*j+7] = (input_state_chi[10*j+7] ^ (~input_state_chi[10*j+9] & input_state_chi[10*j+1]));
    end
    
    for (j=0; j<5; j++) begin
        assign output_state_iota[10*j+8] = (input_state_chi[10*j+8] ^ (~input_state_chi[10*j+0] & input_state_chi[10*j+2]));
        assign output_state_iota[10*j+9] = (input_state_chi[10*j+9] ^ (~input_state_chi[10*j+1] & input_state_chi[10*j+3]));
    end
  endgenerate  
			
endmodule
