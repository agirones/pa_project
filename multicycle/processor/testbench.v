`include "pc.v"
`include "imem.v"
`include "pc_plus4.v"
`include "regfile.v"
`include "instreg.v"

module testbench();
  reg           clk, reset;
  reg  [31:0]   yexpected;
  wire [31:0]   pcf, pc_, y;
  reg  [31:0]   vectornum, errors;
  reg  [31:0]   testvectors [10000:0];
  reg  [31:0]   RAM [10000:0];

  pc pc(clk, reset, pc_, pcf);
  imem imem(pcf, y);
  pc_plus4 dut(pcf, pc_);

  always
  begin
      clk = 1; #5; clk = 0; #5;
  end

  initial
  begin
      $readmemb("testbench.dat", testvectors);
      $readmemh("memfile.dat", RAM);
      vectornum = 0; errors = 0;
      yexpected = RAM[0];
      reset = 1; #1; reset = 0;
  end

  always @ (posedge clk, posedge reset)
  begin
      if(reset)
          yexpected <= RAM[0];
      else
          yexpected <= RAM[pc_/4];
  end

  always @(negedge clk)
  begin
      if (~reset) begin
          if ( y !== yexpected) begin
              $display("Error in: iteration=%d, time=%d, clk=%b, reset=%b. inputs: pc_= %d pcf= %d", vectornum, $time, clk, reset, pc_, pcf);
              $display("outputs = %h (%h expected)", y, yexpected);
              //$display("Error: inputs = %d", a);
              //$display("outputs = %h (%h expected)", y, yexpected);
              errors = errors + 1;
          end
          vectornum = vectornum + 1;
          if (testvectors[vectornum] === 32'bx) begin
              $display ("%d tests completed with %d errors", vectornum, errors);
              $finish;
          end
      end
  end
endmodule
