module instreg(input clk, dhit, input [31:0] rd, output reg [31:0] instr);

always @ (posedge clk)
    if(dhit)
	instr <= rd;

endmodule
