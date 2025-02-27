module aluPC(input wire    [31:0]  PC,
            input  wire [31:0]   imm,
            output reg [31:0]  b_alu_result);

always @ (*)
    b_alu_result <= PC + (imm << 1 );


endmodule
