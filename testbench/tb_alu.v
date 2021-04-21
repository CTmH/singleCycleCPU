`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/11 16:11:43
// Design Name: 
// Module Name: tb_alu
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


module tb_alu();
reg [2:0] cA;
reg [31:0] inum1;
reg [31:0] inum2;
wire [31:0] ans;
wire overflow;
alu alu_unit(
        .ctrl (cA),
        ._inum1 (inum1),
        ._inum2 (inum2),
        .ans (ans),
        .overflow (overflow)
        );
initial begin
        inum1 = 35;
        inum2 = 20;
        cA <= 3'b010;
        #5
        cA <= 3'b100;
        #5
        cA <= 3'b001;
        #5
        cA <= 3'b000;
    end
endmodule
