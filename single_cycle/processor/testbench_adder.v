`include "adder.v"

module testbench_adder();
  reg           clk, reset;
  reg  [31:0]   a, b, yexpected;
  wire [31:0]   y;
  reg  [31:0]   vectornum, errors;
  reg  [95:0]   testvectors [10000:0];

  adder dut(a, b, y);

  always
  begin
      clk = 1; #5; clk = 0; #5;
  end

  initial
  begin
    $readmemb("testbench.dat", testvectors);
    vectornum = 0; errors = 0;
    /*reset = 1; #27;*/ reset = 0;
  end

always @ (posedge clk)
begin
    #1; a = testvectors[vectornum][95:64];
    b = testvectors[vectornum][63:32];
    yexpected = testvectors[vectornum][31:0];
end

always @(negedge clk)
    if (~reset) begin
        if ( y !== yexpected) begin
            $display("Error: inputs = %h, %h", a, b);
            $display("outputs = %h (%h expected)", y, yexpected);
            errors = errors + 1;
        end
        vectornum = vectornum + 1;
        if (testvectors[vectornum] === 96'bx) begin
            $display ("%d tests completed with %d errors", vectornum, errors);
            $finish;
        end
    end
endmodule
