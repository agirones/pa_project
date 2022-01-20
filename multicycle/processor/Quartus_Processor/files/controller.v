
module controller(input clk, reset,
                  input [6:0] opcode,
                  input [2:0] funct3,
                  input [6:0] funct7,
                  output RegWrite, MemWrite, LoadD, ByteD, ALUSrcE, ByteW, MemtoRegW,
                  output [2:0] ALUControl);

wire [1:0] aluop;

maindec maindec(clk, reset, opcode, funct3, RegWrite, MemWrite, LoadD, ByteD, ALUSrcE, ByteW, MemtoRegW, aluop);

aludec aludec(clk, reset, funct7, aluop, ALUControl);

always @(negedge clk)
begin
    $display("At %d:", $time);
    $display("CONTROLLER: funct3=%b, funct7=%b, opcode=%b, RegWrite=%b, MemWrite=%b, LoadD=%b, ByteD=%b, ALUSrcE=%b, ByteW=%b, MemtoRegW=%b, aluop=%b, ALUControl=%b"
             , funct3, funct7, opcode, RegWrite, MemWrite, LoadD, ByteD, ALUSrcE, ByteW, MemtoRegW, aluop, ALUControl);
    $display("------------------------------------------------------------------------------------------------------------------");

end

endmodule
