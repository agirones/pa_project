module instreg(input clk, input [31:0] rd, output reg [31:0] instr);

always @ (posedge clk)
    instr <= rd;

endmodule
