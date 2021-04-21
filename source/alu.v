`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/10 11:06:13
// Design Name: 
// Module Name: alu
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


module alu(
    input [2:0] ctrl,
    input [31:0] _inum1,
    input [31:0] _inum2,
    output [31:0] ans,
    output overflow
    );
    
    wire [32:0] inum1;
    wire [32:0] inum2;
    wire [32:0] add_ans;
    wire [31:0] lui_ans;
    
    //加法
    assign inum1 = {_inum1[31],_inum1};
    assign inum2 = {_inum2[31],_inum2};
    assign add_ans = inum1 + inum2;
    assign overflow = (add_ans[32] ^ add_ans[31]) && ctrl[2];    //溢出检测 add检测 addiu不检测
    
    //lui
    assign lui_ans = {_inum2[15:0],16'b0};
    
    //结果选择
    assign ans = (ctrl[2] || ctrl[1]) ? add_ans[31:0]:
                 (ctrl[0]) ? lui_ans : 32'b0;

endmodule
