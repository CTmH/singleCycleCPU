`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/09 20:51:20
// Design Name: 
// Module Name: dMem
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


module dMem(
    input clk,
    input reset,
    input [31:0] _addr,
    output [31:0] rdata,
    input we,
    input [31:0] wdata
    );
    
    reg [7:0] dmem [255:0];
    
    //load data
    initial $readmemb("C:/Users/Eziok/Projects/singleCycleCPU/asm/data.txt",dmem);
    
    wire [7:0] addr = _addr[7:0];
    assign rdata = {dmem[addr+3],dmem[addr+2],dmem[addr+1],dmem[addr]};
    
    always @(posedge clk) begin
        if(we) begin
            dmem[addr] <= wdata[7:0];
            dmem[addr+1] <= wdata[15:8];
            dmem[addr+2] <= wdata[23:16];
            dmem[addr+3] <= wdata[31:24];
        end
    end

endmodule
