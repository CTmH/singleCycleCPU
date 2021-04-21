`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/11 16:11:43
// Design Name: 
// Module Name: tb_br
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


module tb_br();
reg clk;
reg reset;
reg [1:0] cB;
reg [3:0] pc;
reg [15:0] im_offset;
reg [25:0] idx;
reg [31:0] rd1;
reg [31:0] rd2;
wire branch;
wire [31:0] offset;
wire jump;
wire [31:0] target;
reg [31:0] count;

brUnit br_unit(
        .ctrl (cB),
        .pc_h4 (pc),
        .im_offset (im_offset),
        .instr_index (idx),
        .inum1 (rd1),
        .inum2 (rd2),
        .clk (clk),
        .reset (reset),
        ._branch (branch),
        ._offset (offset),
        ._jump (jump),
        ._target (target)
        );

initial begin  
        cB = 0;
        pc = 0;
        im_offset = 0;
        idx = 0;
        rd1 = 0;
        rd2 = 0;
        clk = 0;
        reset = 0;
        count = 0;
end
always #1 clk = !clk;
always @(posedge clk) begin
    if(reset == 0 && count == 9) begin
        reset = 1;
        count = 0;
    end
    else if(reset == 1 && count == 1) begin
        reset = 0;
        count = 0;
    end
    else count = count + 1;
    
    if(count == 2) begin
        rd1 = 0;
        rd2 = 0;
        cB = 1;
        pc = 2;
        im_offset = -1;
    end
    else if(count == 4) begin
        rd1 = 1;
    end
    else if(count == 5) begin
        cB = 2;
        pc = 3;
        idx = 16;
    end
    else if(count > 5) cB = 0;
end

endmodule
