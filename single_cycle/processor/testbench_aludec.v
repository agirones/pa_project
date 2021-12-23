`include "aludec.v"

module testbench_aludec();
  reg           clk, reset;
  reg  [5:0]   a;
  reg  [1:0]   b;
  reg  [2:0]   yexpected;
  wire [2:0]   y;
  reg  [31:0]   vectornum, errors;
  reg  [10:0]   testvectors [10000:0];

  aludec dut(a, b, y);

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
      #1; a = testvectors[vectornum][10:5];
      b = testvectors[vectornum][4:3];
      yexpected = testvectors[vectornum][2:0];
  end

  always @(negedge clk)
      if (~reset) begin
          if ( y !== yexpected) begin
              $display("Error: inputs = %b, %b", a, b);
              $display("outputs = %b (%b expected)", y, yexpected);
              errors = errors + 1;
          end
          vectornum = vectornum + 1;
          if (testvectors[vectornum] === 11'bx) begin
              $display ("%d tests completed with %d errors", vectornum, errors);
              $finish;
          end
      end
endmodule
