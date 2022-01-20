`include "imem.v"
`include "dmem.v"
`include "riscv.v"

module top(input clk, reset,
           output [31:0] WriteData, ALUOut,
           output MemWrite);

wire [31:0] instr, ReadData, pc;

riscv riscv(clk, reset, instr, ReadData, pc, ALUOut, WriteData, MemWrite);
dmem dmem(clk, MemWrite, ALUOut, WriteData, ReadData);
imem imem(pc, instr);

endmodule
