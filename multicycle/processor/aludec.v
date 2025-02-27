module aludec(input clk, reset, dhit, alu_busy,
              input [6:0] funct7,
              input [1:0] aluop,
              input sendNop,
              output [2:0] alucontrolE);

reg  [2:0] alucontrolF;  
wire [2:0] alucontrolD;  

always @(*)
    if(~reset)
        case(aluop)
            2'b00: alucontrolF <= 3'b010; // add
            2'b01: alucontrolF <= 3'b110; // sub
            default: case(funct7)
                7'b0000000: alucontrolF <= 3'b010; // AEE
                7'b0100000: alucontrolF <= 3'b110; // SUB
                7'b0000001: alucontrolF <= 3'b011; // MUL
                default:    alucontrolF <= 3'bxxx; // ??
            endcase
        endcase

creg #(3) cregD(clk, (dhit & ~alu_busy), sendNop, alucontrolF, alucontrolD);
creg #(3) cregE(clk, (dhit & ~alu_busy), sendNop, alucontrolD, alucontrolE);

endmodule
