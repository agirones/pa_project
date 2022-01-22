module rdreg(input clk, input [31:0] rd, input [4:0] wrE, input [31:0] ALUOutM, output reg [31:0] result, output reg [4:0] wrW, output reg [31:0] ALUOutW);

always @ (posedge clk)
begin
    result <= rd;
    wrW <= wrE;
    ALUOutW <= ALUOutM;
end

endmodule
