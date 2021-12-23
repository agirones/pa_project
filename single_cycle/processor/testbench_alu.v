`include "alu.v"

module testbench_alu();
  reg           clk, reset;
  reg  [31:0]   a;
  reg  [31:0]   b;
  reg  [2:0]    f;
  reg  [31:0]   yexpected;
  wire [31:0]   y;
  reg  [31:0]   vectornum, errors;
  reg  [34:0]   testvectors [10000:0];

  alu dut(a, b, f, y);

  always
  begin
      clk = 1; #5; clk = 0; #5;
  end

  initial
  begin
    $readmemb("testbench.dat", testvectors);
    vectornum = 0; errors = 0;
    /*reset = 1; #27;*/ reset = 0;
    a = 32'd32;
    b = 32'd96;
  end

  always @ (posedge clk)
  begin
      f = testvectors[vectornum][34:32];
      yexpected = testvectors[vectornum][31:0];
  end

  always @(negedge clk)
      if (~reset) begin
          if ( y !== yexpected) begin
              $display("Error: inputs = %b, %b, %b", a, b, f);
              $display("outputs = %b (%b expected)", y, yexpected);
              errors = errors + 1;
          end
          vectornum = vectornum + 1;
          if (testvectors[vectornum] === 35'bx) begin
              $display ("%d tests completed with %d errors", vectornum, errors);
              $finish;
          end
      end
endmodule
