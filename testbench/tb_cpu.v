`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/11 22:16:10
// Design Name: 
// Module Name: tb_cpu
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


module tb_cpu();
    reg clk;
    reg rst;
    always #1 clk = ~clk;
    singleCycleCPU cpu(
        .clk (clk),
        .resetn (~rst)
        );
    initial begin
        clk = 0;
        rst = 1;
        #3
        rst = 0;
    end
endmodule
