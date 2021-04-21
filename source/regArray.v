`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/09 20:10:52
// Design Name: 
// Module Name: regArray
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


module regArray(
    input clk,
    //2 read port
    input [4:0] raddr1,
    output [31:0] rdata1,
    input [4:0] raddr2,
    output [31:0] rdata2,
    //write port
    input we,           //write enable, HIGH valid
    input [4:0] waddr,
    input [31:0] wdata
    );
    
    reg [31:0] rf[31:0];

    //WRITE
    always @(posedge clk) begin
        if (we) rf[waddr]<= wdata;
    end
    
    //READ OUT 1
    assign rdata1 = (raddr1==5'b0) ? 32'b0 : rf[raddr1];
    
    //READ OUT 2
    assign rdata2 = (raddr2==5'b0) ? 32'b0 : rf[raddr2];

endmodule
