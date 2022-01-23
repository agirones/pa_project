`include "creg.v"

module maindec(input clk, reset, ihit, dhit, alu_busy,
               input [6:0] opcode,
               input [2:0] funct,
			   input sendNop,
               output RegWriteW, RegWriteM, MemWriteM, MemWriteD, LoadD, BranchD, JumpD, ByteD, ALUSrcE, BranchM, JumpM, LoadM, ByteW, MemtoRegW, 
               output [1:0] aluop);

reg [9:0] controls;
wire RegWriteF, MemWriteF, LoadF, BranchF, JumpF, ByteF, ALUSrcF, MemtoRegF;
wire RegWriteD, BranchD, JumpD, ALUSrcD, MemtoRegD;
wire RegWriteE, LoadE, BranchE, JumpE, ByteE, MemtoRegE;
wire ByteM, MemtoRegM;

	assign {RegWriteF, MemWriteF, LoadF, BranchF, JumpF, ByteF, ALUSrcF, MemtoRegF, aluop} = controls;

initial begin
    controls <= 10'b0000000000;
end


always @(*)
    if(~reset)
	    if (ihit)
		case(opcode)
		    7'b0000011: case(funct)
				    3'b000:  controls <= 10'b1010011100; //LB
				    3'b010:  controls <= 10'b1010001100; //LW
				    default: controls <= 10'bxxxxxxxxxx;
				endcase
		    7'b0100011: case(funct)
				    3'b000:  controls <= 10'b0100011x00; //SB
				    3'b010:  controls <= 10'b0100001x00; //SW
				    default: controls <= 10'bxxxxxxxxxx;
				endcase
			7'b1100011: case(funct)
				    3'b000:  controls <= 10'b0001000000; //BEQ
				    default: controls <= 10'bxxxxxxxxxx;
				endcase
			7'b1100111: case(funct)
				    3'b000:  controls <= 10'b0000101000; //JALR
				    default: controls <= 10'bxxxxxxxxxx;
				endcase
		    7'b0110011: case(funct)
				    3'b000:  controls <= 10'b10x0000010; //ADD | SUB | MUL
				    default: controls <= 10'bxxxxxxxxxx;
				endcase
		    default:                 controls <= 10'bxxx00xxxxx;
		endcase
	    else
			controls <= 10'b0000000000; //NOP
	else
		controls <= 10'b0000000000;

creg #(8) cregF(clk, (dhit & ~alu_busy), sendNop, {RegWriteF, MemWriteF, LoadF, BranchF, JumpF, ByteF, ALUSrcF, MemtoRegF}, {RegWriteD, MemWriteD, LoadD, BranchD, JumpD, ByteD, ALUSrcD, MemtoRegD});
creg #(8) cregD(clk, (dhit & ~alu_busy), sendNop, {RegWriteD, MemWriteD, LoadD, BranchD, JumpD, ByteD, ALUSrcD, MemtoRegD}, {RegWriteE, MemWriteE, LoadE, BranchE, JumpE, ByteE, ALUSrcE, MemtoRegE});
creg #(7) cregE(clk, (dhit & ~alu_busy), sendNop, {RegWriteE, MemWriteE, LoadE, BranchE, JumpE, ByteE, MemtoRegE}, {RegWriteM, MemWriteM, LoadM, BranchM, JumpM, ByteM, MemtoRegM});
creg #(3) cregM(clk, (dhit & ~alu_busy), sendNop, {RegWriteM, ByteM, MemtoRegM}, {RegWriteW, ByteW, MemtoRegW});

endmodule
