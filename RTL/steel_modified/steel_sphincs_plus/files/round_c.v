`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2022 06:15:06 PM
// Design Name: 
// Module Name: round_constants
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


module round_c(
        input wire  hara_c,
        input wire [3:0] round,
        input wire [1:0]round_aes,
        output wire [127:0] rc_out0_1,
        output wire [127:0] rc_out0_2,
        output wire [127:0] rc_out1_1,
        output wire [127:0] rc_out1_2
    );
    
    wire [127:0] rc [0:39];
    wire [5:0] rc_index_1;
    wire [5:0] rc_index_2;
    wire [5:0] rc_index_3;
    wire [5:0] rc_index_4;
    
    parameter [1:0] AES_PER_ROUND = 2;
    
    
    assign rc_index_1 = hara_c?(4*AES_PER_ROUND*round) + (4*round_aes[0]):(2*AES_PER_ROUND*round) + (2*round_aes[0]);
    assign rc_index_2 = hara_c?(4*AES_PER_ROUND*round) + (4*round_aes[0])+1:(2*AES_PER_ROUND*round) + (2*round_aes[0])+1;
    assign rc_index_3 = hara_c?(4*AES_PER_ROUND*round) + (4*round_aes[0])+2:(2*AES_PER_ROUND*round) + (2*round_aes[1]);
    assign rc_index_4 = hara_c?(4*AES_PER_ROUND*round) + (4*round_aes[0])+3:(2*AES_PER_ROUND*round) + (2*round_aes[1])+1;
    
    assign rc_out0_1[127:0] = rc[rc_index_1[5:0]];
    assign rc_out0_2[127:0] = rc[rc_index_2[5:0]];
    assign rc_out1_1[127:0] = rc[rc_index_3[5:0]];
    assign rc_out1_2[127:0] = rc[rc_index_4[5:0]];
    
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

    
endmodule
