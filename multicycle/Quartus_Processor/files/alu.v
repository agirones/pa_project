//-----------------------------------------------------
// This is the ALU
// Design Name : alu
// File Name : alu.v
//-----------------------------------------------------
module alu(input        [31:0]  A, B,
           input  logic [2:0]   F,
           output reg   [31:0]  Y);

wire [31:0] S, Bout;

assign Bout = F[2] ? ~B : B;
assign S = A + Bout + F[2];
assign M = A * B;

always @ (*)
    casez(F)
        3'b?00: Y <= A & Bout;
        3'b?01: Y <= A | Bout;
        3'b?10: Y <= S;
        3'b011: Y <= A * B;
        3'b111: Y <= S[31];
    endcase

endmodule
