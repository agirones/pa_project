module instreg(input clk, input [31:0] pc, input [31:0] rd, output reg [31:0] instr, output reg [31:0] pcFD);

always @ (posedge clk) begin
    instr <= rd;
    pcFD <= pc;
end

endmodule
