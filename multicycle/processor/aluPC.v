module aluPC(input wire    [31:0]  PC,
            input  wire [31:0]   imm,
            output reg [31:0]  bj_alu_result);

always @ (*)
    bj_alu_result <= PC + (imm << 1 );


endmodule
