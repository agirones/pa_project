//-----------------------------------------------------
// This is the datapath of the mips processor
// Design Name : datapath
// File Name : datapath.v
// Function : This module models the datapath of the processor
//-----------------------------------------------------
`include "pc.v"
`include "pc_plus4.v"
`include "instreg.v"
`include "regfile.v"
`include "mux4.v"
`include "signext.v"
`include "signextD.v"
`include "areg.v"
`include "alu.v"
`include "alureg.v"
`include "rdreg.v"
`include "aluPC.v"
`include "forwardUnit.v"
`include "mux4Full.v"

module datapath(input logic clk, reset, pc_en, dhit,
                input logic [31:0] ri,
                input logic RegWriteW,
                input logic RegWriteM,
                input logic MemWriteD,
                input logic LoadD,
                input logic BranchD, 
                input logic JumpD, 
                input logic [2:0] AluControlE,
                input logic [31:0] ReadData,
                input logic ByteD,
                input logic ALUSrcE,
                input logic BranchM,
                input logic JumpM,
                input logic ByteW,
                input logic MemtoRegW,
                output wire [31:0] pcf,
		output wire        alu_busy,
                output wire [31:0] ALUOutM,
                output wire [31:0] WriteDataM,
                output wire sendNop);

wire [31:0]  pc_;
wire [31:0]  instr;
wire [4:0]   WriteRegW;
wire [4:0]  ra1, ra2;
wire [31:0]  rd1, rd2;
wire [11:0]  Imm;
wire [31:0]  SignImmD, ByteStoreExt, StoreDataD;
wire [31:0]  SrcAE, SrcBE, WriteDataE, SignImmE, rd2E, aluresult;
wire [4:0]  WriteRegE;
wire [4:0]  WriteRegM;
wire [31:0]  ResultW, ExtByteResultW, WriteDataRFW, ALUOutW, ReadDataW;
wire [7:0]  ByteResultW;
wire zero_;
wire [31:0]  b_alu_result, b_alu_result_, bMux_PC_output, finalPC;
wire [31:0] pcFD, pcDE, pcEM;
wire [1:0] forwardA, forwardB;
wire [31:0] fwAoutput, fwBoutput;
wire [4:0] ra1_out, ra2_out;


// fetch
pc              pc(clk, reset, (pc_en & dhit & ~alu_busy), finalPC, pcf);
mux2     #(32)  muxPCBranch((BranchM & zero_), pc_, b_alu_result_, bMux_PC_output);
mux2     #(32)  muxPCJump(JumpM, bMux_PC_output, ALUOutM, finalPC);
pc_plus4        pc_plus4(pcf, pc_);
instreg         instreg(clk, (dhit & ~alu_busy), pcf, ri, instr, pcFD);
assign sendNop = (((BranchM & zero_) || JumpM) == 1 ) ? 1 : 0;

// register file logic
assign ra1 = instr[19:15];
assign ra2 = instr[24:20];
regfile         regfile(clk, reset, RegWriteW, ra1, ra2, WriteRegW, ResultW, rd1, rd2);
signext  #(8)   extrd2(rd2[7:0], ByteStoreExt);
mux2     #(32)  muxStoreData(ByteD, rd2, ByteStoreExt, StoreDataD);
signextD        signImm(instr, LoadD, MemWriteD, BranchD, JumpD, SignImmD);
areg            areg(clk, (dhit & ~alu_busy), pcFD, rd1, StoreDataD, instr[11:7], SignImmD, sendNop, ra1, ra2,
                 SrcAE, rd2E, WriteRegE, WriteDataE, SignImmE, pcDE, ra1_out, ra2_out);

// execute
mux4Full     #(32)  fwA(forwardA, 32'd0, ALUOutM, ResultW, SrcAE, fwAoutput);
mux4Full     #(32)  fwB(forwardB, 32'd0, ALUOutM, ResultW, rd2E, fwBoutput);
mux2     #(32)  muxALUSrcBE(ALUSrcE, fwBoutput, SignImmE, SrcBE);
alu             alu(clk, fwAoutput, SrcBE, AluControlE, aluresult, zero_flag, alu_busy);
aluPC           aluPC(pcDE, SignImmE, b_alu_result);
alureg          alureg(clk, (dhit & ~alu_busy), pcDE, aluresult, zero_flag, b_alu_result, WriteDataE, WriteRegE, sendNop, 
                 ALUOutM, zero_, b_alu_result_, WriteDataM, WriteRegM, pcEM);
forwardUnit     forwardUnit(ra1_out, ra2_out, RegWriteM, RegWriteW, WriteRegM, WriteRegW, forwardA, forwardB);
//forwardUnit     forwardUnit(SrcAE, rd2E, aluout, xxx , xxx, ALUOutW, xxx);


// memory
rdreg           rdreg(clk, (dhit & ~alu_busy), ReadData, WriteRegM, ALUOutM, ReadDataW, WriteRegW, ALUOutW);

mux4     #(8)   muxbyte(ALUOutW[1:0], ReadDataW[31:24], ReadDataW[23:16], ReadDataW[15:8], ReadDataW[7:0], ByteResultW);
signext  #(8)   extbytewrite(ByteResultW, ExtByteResultW);
mux2     #(32)  muxbytewrite(ByteW, ResultW, ExtByteResultW, WriteDataRFW);

mux2     #(32)  muxMemToReg(MemtoRegW, ALUOutW, ReadDataW, ResultW);

always @(negedge clk)
begin
    #1;
    $display("At %d", $time);
    $display("INSTREG: instr=%h", instr);
    $display("AREG: SrcAE=%d, rd2E=%d, WriteRegE=%d, WriteDataE=%d, SignImmE=%d", SrcAE, rd2E, WriteRegE, WriteDataE, SignImmE);
    $display("ALU: SrcAE=%d, SrcBE=%d, AluControl=%b, aluresult=%d", SrcAE, SrcBE, AluControlE, aluresult); 
    $display("ALUREG: ALUOutM=%d, WriteDataM=%d, WriteRegM=%d", ALUOutM, WriteDataM, WriteRegM); 
    $display("RDREG: ReadDataW=%d, WriteRegW=%d, ALUOutW=%d", ReadDataW, WriteRegW, ALUOutW); 
    $display("======================================================================================================");
end

endmodule
