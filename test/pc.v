//-----------------------------------------------------
// This is the PC incrementer
// Design Name : pc
// File Name : pc.v
// Function : This module adds N to a 32 bits input
//-----------------------------------------------------
module pc(clk, reset, a, y);

input clk;
input reset;
input [31:0] a;
// N value is assigned here
localparam [2:0] N=4;

output [31:0] y;

wire clk;
wire reset;
wire a;

reg [31:0] y;

always @(posedge clk, reset) begin
	if (reset) begin
		y <= 8'h0;
	end
	else begin
		y <= a + N;
	end
end
endmodule
