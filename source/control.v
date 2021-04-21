`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/10 22:32:15
// Design Name: 
// Module Name: control
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


module control(
    input [5:0] opcode,
    input [5:0] func,
    output c1,
    output c2,
    output c3,
    output c4,
    output [2:0] cA,
    output [1:0] cB,
    output [1:0] cmul,
    output dmen_we,
    output reg_we
    );
    
    wire [3:0] instr_type; //0-lui,1-addiu,2-add,3-lw,4-sw,5-beq,6-j,7-multu,8-div,9-reserved
     
    assign instr_type = (opcode == 6'b001111) ? 0 :
                         (opcode == 6'b001001) ? 1 :
                         (opcode == 6'b100011) ? 3 :
                         (opcode == 6'b101011) ? 4 :
                         (opcode == 6'b000100) ? 5 :
                         (opcode == 6'b000010) ? 6 :
                         (opcode == 6'b000000) ? (
                             (func == 6'b100000) ? 2 :            
                             (func == 6'b011001) ? 7 : 
                             (func == 6'b011011) ? 8 : 9) : 9;
    
    assign c1 = (instr_type == 0 || instr_type == 1 || instr_type == 3 || instr_type == 4) ? 1 :0;
    assign c2 = (instr_type == 2) ? 1 : 0;
    assign c3 = (instr_type == 0) ? 1 : 0;
    assign c4 = (instr_type == 3) ? 1 : 0;
    assign cA = (instr_type == 1 || instr_type == 3 || instr_type == 4) ? 3'b010 :  //add
                (instr_type == 0) ? 3'b001 :    //lui
                (instr_type == 2) ? 3'b100 : 3'b000;    //addiu | null
    assign cB = (instr_type == 5) ? 2'b01 :
                (instr_type == 6) ? 2'b10 : 2'b00;
    assign dmen_we = (instr_type == 4) ? 1 : 0;
    assign reg_we = (instr_type == 0 ||instr_type == 1 || instr_type == 2 || instr_type == 3) ? 1 : 0;                         
    assign cmul = (instr_type == 7) ? 1 : 
                  (instr_type == 8) ? 2 : 0;

endmodule
