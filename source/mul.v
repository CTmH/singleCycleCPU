`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/10 19:42:21
// Design Name: 
// Module Name: mul
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


module mul(
    input clk,
    input reset,
    input [1:0] ctrl,   //mul=1,div=2
    input [31:0] inum1,
    input [31:0] inum2,
    output [31:0] _hi,
    output [31:0] _lo,
    output div_zero
    );
    
    wire [31:0] hi;
    wire [31:0] lo;
    wire [63:0] ans;
    reg [31:0] rhi;
    reg [31:0] rlo;
    
    //div
    assign div_zero = (inum2 == 32'b0) && (ctrl == 2);
    assign hi = inum1 % inum2;
    assign lo = inum1 / inum2;
    
    //mul
    assign ans = inum1 * inum2;
    
    assign _hi = rhi;
    assign _lo = rlo;
    
    always @(posedge clk) begin
        if(reset) begin
            rhi <= 32'b0;
            rlo <= 32'b0;
        end
        else if(ctrl == 1) begin
            rhi <= ans[63:32];
            rlo <= ans[31:0];
        end
        else if(ctrl == 2) begin
            rhi <= hi;
            rlo <= lo;
        end
    end
    
endmodule
