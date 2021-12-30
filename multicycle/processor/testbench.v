`include "top.v"

module testbench();
  reg           clk, reset;
  wire [31:0] writedata, dataadr;
  wire memwrite;

  top dut(clk, reset, writedata, dataadr, memwrite); 
  
  initial
  begin
      reset = 1; #11; reset = 0;
  end

  always
  begin
      clk = 1; #5; clk = 0; #5;
  end

  always @(negedge clk)
  begin
      if (memwrite) begin
          if (dataadr === 40 & writedata === 49) begin
              $display("simulation succeeded at %d", $time);
              $finish;
          end
//          else if (dataadr !== 84) begin
//              $display("simulation failed");
//              $display("time=%d, memwrite=%b, dataadr=%h, writedata=%h", $time, memwrite, dataadr, writedata);
//              $finish;
//          end
      end
      else if ($time > 300)
          $finish;
  end
endmodule
