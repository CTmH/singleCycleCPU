`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: CTmH
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


module singleCycleCPU(
    input       clk,
    input       resetn
);
    reg reset;
    always @(posedge clk) reset <= ~resetn;
    
    wire [31:0] ins;
    wire c1;
    wire c2;
    wire c3;
    wire c4;
    wire [2:0] cA;
    wire [1:0] cB;
    wire [1:0] cmul;
    wire dmem_we;
    wire reg_we;
    wire branch;
    wire [31:0] offset;
    wire jump;
    wire [31:0] target;
    wire [31:0] ins_addr;
    wire [31:0] rd1;
    wire [31:0] rd2;
    wire [31:0] wd;
    wire [4:0] wa;
    wire [31:0] inum1;
    wire [31:0] inum2;
    wire [31:0] ans;
    wire [31:0] imm;
    wire overflow;
    reg rof;    //register overflow
    wire [31:0] dmem_rd;
    wire [31:0] hi;
    wire [31:0] lo;
    wire div_zero;
    reg rdz;    //register div zero
    
    control ctrl_unit(
        .opcode (ins[31:26]),
        .func (ins[5:0]),
        .c1 (c1),
        .c2 (c2),
        .c3 (c3),
        .c4 (c4),
        .cA (cA),
        .cB (cB),
        .cmul (cmul),
        .dmen_we (dmem_we),
        .reg_we (reg_we)
        );
    
    iMem imem(
        .clk (clk),
        .reset (reset),
        ._addr (ins_addr),
        .ins (ins)
        );
    
    pc pcount(
        .branch (branch),
        .offset (offset),
        .jump (jump),
        .target (target),
        .clk (clk),
        .reset (reset),
        .ins_addr (ins_addr)
        );
    
    brUnit br_unit(
        .ctrl (cB),
        .pc_h4 (ins_addr[31:28]),
        .im_offset (ins[15:0]),
        .instr_index (ins[25:0]),
        .inum1 (rd1),
        .inum2 (rd2),
        .clk (clk),
        .reset (reset),
        ._branch (branch),
        ._offset (offset),
        ._jump (jump),
        ._target (target)
        );
    
    regArray reg_array(
        .clk (clk),
        .raddr1 (ins[25:21]),
        .rdata1 (rd1),
        .raddr2 (ins[20:16]),
        .rdata2 (rd2),
        .we (reg_we),
        .waddr(wa),
        .wdata(wd)
        );
    
    assign imm = {16'b0,ins[15:0]};
    assign inum1 = c3 ? imm : rd1;
    assign inum2 = c1 ? imm : rd2;
    assign wa = c2 ? ins[15:11] : ins[20:16];
    
    alu alu_unit(
        .ctrl (cA),
        ._inum1 (inum1),
        ._inum2 (inum2),
        .ans (ans),
        .overflow (overflow)
        );
    always @(posedge clk) begin
        rof <= overflow;
    end

    dMem dmem(
        .clk (clk),
        .reset (reset),
        ._addr (ans),
        .rdata (dmem_rd),
        .we (dmem_we),
        .wdata (rd2)
        );

    assign wd = c4 ? dmem_rd : ans;
    
    mul mul_unit(
        .clk (clk),
        .reset (reset),
        .ctrl (cmul),
        .inum1 (inum1),
        .inum2 (inum2),
        ._lo (lo),
        ._hi (hi),
        .div_zero (div_zero)
        );
        
    always @(posedge clk) begin
        rdz <= div_zero;
    end
    
endmodule