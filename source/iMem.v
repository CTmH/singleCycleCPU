`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/09 19:49:46
// Design Name: 
// Module Name: imem
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


module iMem(
    input           clk,
    input           reset,
    input   [31:0]  _addr,
    output  [31:0]  ins
    );
    
    reg [7:0] imem [255:0];
    
    //load instructions
    initial $readmemb("C:/Users/Eziok/Projects/singleCycleCPU/asm/code.txt",imem);
    
    wire [7:0] addr = _addr[7:0];
    assign ins = {imem[addr+3],imem[addr+2],imem[addr+1],imem[addr]};
    
endmodule