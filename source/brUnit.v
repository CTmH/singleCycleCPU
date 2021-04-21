`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/10 15:01:55
// Design Name: 
// Module Name: brUnit
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


module brUnit(
    input [1:0] ctrl,   //flow=0,beq=1,j=2
    input [3:0] pc_h4,
    input [15:0] im_offset,
    input [25:0] instr_index,
    input [31:0] inum1,
    input [31:0] inum2,
    input clk,
    input reset,
    output _branch,
    output [31:0] _offset,
    output _jump,
    output [31:0] _target
    );
    
    reg rbranch;
    reg [31:0] roffset;
    reg rjump;
    reg [31:0] rtarget;
    wire branch;
    wire [31:0] offset;
    wire jump;
    wire [31:0] target;
    
    
    assign _branch = rbranch;
    assign _offset = roffset;
    assign _jump = rjump;
    assign _target = rtarget;
    
    //beq
    assign branch  = (ctrl==1) ? (inum1 == inum2) : 0;
    assign offset = {{14{im_offset[15]}}, im_offset, 2'b0};
    
    //jump
    assign jump = (ctrl==2);
    assign target = {pc_h4, instr_index, 2'b0};
    
    always @(posedge clk) begin
        if (reset) begin
                rbranch <= 1'b0;
                rjump <= 1'b0;
        end
        else begin
                rbranch <= branch;
                rjump <= jump;
        end
        rtarget <= target;
        roffset <= offset;
    end

endmodule
