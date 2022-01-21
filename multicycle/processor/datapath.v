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
`include "areg.v"
`include "alu.v"
`include "alureg.v"
`include "rdreg.v"

module datapath(input logic clk, reset, pc_en,
                input logic [31:0] ri,
                input logic RegWriteW,
                input logic LoadD,
                input logic [2:0] AluControlE,
                input logic [31:0] ReadData,
                input logic ByteD,
                input logic ALUSrcE,
                input logic ByteW,
                input logic MemtoRegW,
                output wire [31:0] pcf,
                output wire [31:0] ALUOutM,
                output wire [31:0] WriteDataM);

wire [31:0]  pc_;
wire [31:0]  instr;
wire [4:0]   WriteRegW;
wire [31:0]  rd1, rd2;
wire [11:0]  Imm;
wire [31:0]  SignImmD, ByteStoreExt, StoreDataD;
wire [31:0]  SrcAE, SrcBE, WriteDataE, SignImmE, rd2E, aluresult;
wire [4:0]  WriteRegE;
wire [4:0]  WriteRegM;
wire [31:0]  ResultW, ExtByteResultW, WriteDataRFW, ALUOutW, ReadDataW;
wire [7:0]  ByteResultW;

// fetch
pc              pc(clk, reset, (pc_en & dhit), pc_, pcf);
pc_plus4        pc_plus4(pcf, pc_);
instreg         instreg(clk, dhit, ri, instr);

// register file logic
regfile         regfile(clk, reset, RegWriteW, instr[19:15], instr[24:20], WriteRegW, ResultW, rd1, rd2);
signext  #(8)   extrd2(rd2[7:0], ByteStoreExt);
mux2     #(32)  muxStoreData(ByteD, rd2, ByteStoreExt, StoreDataD);
mux2     #(12)  muxImm(LoadD, {instr[31:25], instr[11:7]}, instr[31:20], Imm);
signext  #(12)  signext(Imm, SignImmD);
areg            areg(clk, dhit, rd1, StoreDataD, instr[11:7], SignImmD, SrcAE, rd2E, WriteRegE, WriteDataE, SignImmE);

// execute
mux2     #(32)  muxALUSrcBE(ALUSrcE, rd2E, SignImmE, SrcBE);
alu             alu(SrcAE, SrcBE, AluControlE, aluresult);
alureg          alureg(clk, dhit, aluresult, WriteDataE, WriteRegE, ALUOutM, WriteDataM, WriteRegM);

// memory
rdreg           rdreg(clk, dhit, ReadData, WriteRegM, ALUOutM, ReadDataW, WriteRegW, ALUOutW);

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
