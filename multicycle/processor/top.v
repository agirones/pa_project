`include "icache.v"
`include "dcache.v"
`include "riscv.v"

module top(input clk, reset,
           output [31:0] WriteData, ALUOut,
           output MemWrite);

wire [31:0] instr, ReadData, pc;

riscv riscv(clk, reset, ihit, dhit, instr, ReadData, pc, LoadW, ALUOut, WriteData, MemWrite);
dcache dcache(clk, MemWrite, LoadW, ALUOut, WriteData, dhit, ReadData);
icache icache(clk, pc, ihit, instr);

endmodule
