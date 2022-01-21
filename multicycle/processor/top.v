`include "icache.v"
`include "dmem.v"
`include "riscv.v"

module top(input clk, reset,
           output [31:0] WriteData, ALUOut,
           output MemWrite);

wire [31:0] instr, ReadData, pc;
wire dhit;
dhit = 1;

riscv riscv(clk, reset, ihit, dhit, instr, ReadData, pc, ALUOut, WriteData, MemWrite);
dmem dmem(clk, MemWrite, ALUOut, WriteData, ReadData);
icache icache(clk, pc, ihit, instr);

endmodule
