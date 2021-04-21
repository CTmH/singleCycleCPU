`timescale 1ns / 100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/11 16:11:43
// Design Name: 
// Module Name: tb_pc
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


module tb_pc();
reg branch;
reg [31:0] offset;
reg jump;
reg [31:0] target;
reg clk;
reg reset;
reg [31:0] count;
wire [31:0] addr;
pc pcount(
        .branch (branch),
        .offset (offset),
        .jump (jump),
        .target (target),
        .clk (clk),
        .reset (reset),
        .ins_addr (addr)
        );
initial begin  
        branch = 0;
        offset = 0;
        jump = 0;
        target = 0;
        clk = 0;
        reset = 0;
        pcount.pc = 32'b0;
        count = 0;
end
always #1 clk = !clk;
always @(posedge clk) begin
    if(reset == 0 && count == 8) begin
        reset = 1;
        count = 0;
    end
    else if(reset == 1 && count == 2) begin
        reset = 0;
        count = 0;
    end
    else count = count + 1;
    if(count == 3 && branch == 0) begin
        branch = 1;
        offset = 3;
    end
    else if(branch == 1) branch = 0;
    if(count == 5 && jump == 0) begin
        jump = 1;
        target = 16;
    end
    else if(jump == 1) jump = 0;
end
endmodule
