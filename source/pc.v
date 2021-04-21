`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/09 19:09:15
// Design Name: 
// Module Name: pc
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


module pc(
    input           branch,  
    input   [31:0]  offset,
    input           jump,
    input   [31:0]  target,
    input           clk,
    input           reset,
    output  [31:0]  ins_addr
    );

    wire [31:0] nextpc;
    wire [31:0] real_offset;
    reg  [31:0] pc;
    
    assign real_offset = branch ? offset : 3'h4;
    assign nextpc = jump ? target : pc + real_offset;
    assign ins_addr = pc;

    always @(posedge clk) begin
        if (reset) pc <= 32'b0;
        else       pc <= nextpc;
    end
endmodule
