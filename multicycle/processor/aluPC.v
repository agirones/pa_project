module aluPC(input wire    [31:0]  PC,
            input  wire [31:0]   imm,
            output reg [31:0]  bj_alu_result);

always @ (*) begin
    bj_alu_result <= PC + imm;
end

endmodule
