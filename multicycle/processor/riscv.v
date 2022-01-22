`include "controller.v"
`include "datapath.v"

module riscv(input clk, reset, pc_en, dhit,
             input [31:0] instr,
             input [31:0] ReadData,
             output [31:0] pc,
	     output LoadW,
             output [31:0] ALUOut,
             output [31:0] WriteData,
             output MemWrite);

wire RegWrite, LoadD, ByteD, ALUSrcE, ByteW, MemtoRegW;
wire [2:0] ALUControl;

controller c(clk, reset, pc_en, dhit, instr[6:0], instr[14:12], instr[31:25], RegWrite, MemWrite, LoadD, ByteD, ALUSrcE, LoadW, ByteW, MemtoRegW, ALUControl);

datapath dp(clk, reset, pc_en, dhit, instr, RegWrite, LoadD, ALUControl, ReadData, ByteD, ALUSrcE, ByteW, MemtoRegW, pc, ALUOut, WriteData);   

always @ (negedge clk)
    if(MemWrite)
        $display("In top at %d: MemWrite=%b, ALUOut=%d, WriteData=%d", $time, MemWrite, ALUOut, WriteData); 


endmodule             
