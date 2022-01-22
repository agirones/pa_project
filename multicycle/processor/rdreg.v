module rdreg(input clk, en, input [31:0] rd, input [4:0] wrE, input [31:0] ALUOutM, output reg [31:0] result, output reg [4:0] wrW, output reg [31:0] ALUOutW);

always @ (posedge clk)
if(en)
begin
    result <= rd;
    wrW <= wrE;
    ALUOutW <= ALUOutM;
end

endmodule
