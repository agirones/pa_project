`include "pc.v"
module d_pc();

reg clk, reset;
reg [31:0] a;
wire [31:0] y;

initial begin
	$display ("time\t a\t\t y\t\t clk");
	$monitor ("%g\t %h\t %h\t %h", $time, a, y, clk);
	clk = 0;
	reset = 0;
	a = 8'h70;
	#5;
	a <= y;
	#5;
	a <= y;
	#5 $finish;
end
always begin
	#2 clk = ~clk;
end
pc a_pc(clk, reset, a, y);
endmodule
