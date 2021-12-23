//-----------------------------------------------------
// Design Name : mips
// File Name : mips.v
// Function : This module simulates a mips single-cycle processor
//-----------------------------------------------------
`include "controller.v"
`include "datapath.v"

module mips (input         clk, reset,
             output [31:0] pc,
             input  [31:0] instr,
             output        memwrite,
             output [31:0] alout, writedata,
             input  [31:0] readdata);
wire        memtoreg, branch,
            alusrc, regdst, regwrite, jump;
wire [2:0]  alucontrol;
controller c(instr[31:26], instr[5:0], zero,
             memtoreg, memwrite, pcsrc,
             alusrc, regdst, regwrite, jump,
             alucontrol);
datapath dp(clk, reset, memtoreg, pcsrc,
            alusrc, regdst, regwrite, jump,
            alucontrol,
            zero, pc, instr,
            aluout, writedata, readdata);
endmodule
