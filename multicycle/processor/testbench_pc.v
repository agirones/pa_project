`include "pc.v"
`include "imem.v"
`include "instreg.v"
`include "sync.v"

module testbench_pc();
  reg           clk, reset;
  reg  [31:0]   a, yexpected;
  wire [31:0]   y;
  reg  [31:0]   vectornum, errors;
  reg  [63:0]   testvectors [10000:0];
  wire [31:0]   b, c;
  reg          irwrite;
  logic [31:0] RAM[63:0];

  pc dut(clk, a, b);
  imem dut2(clk, b, c); 
  insreg dut3(clk, irwrite, c, y); 

  always
  begin
      clk = 0; #5; clk = 1; #5;
  end

  initial
  begin
    $readmemb("testbench.dat", testvectors);
    vectornum = 0; errors = 0;
    /*reset = 1; #27;*/ reset = 0;
    irwrite = 1;
    $readmemh("memfile.dat", RAM);
  end

    always @ (posedge clk)
    begin
        #2; a = testvectors[vectornum][31:0];
        yexpected = RAM[a-2];
        $display("a: %d, yexpected: %h, y: %h", a, yexpected, y);
        $display("-------------------------");
    end

    always @(negedge clk)
        if (~reset) begin
            if (irwrite) begin
                if ( y !== yexpected) begin
                    $display("Error: inputs = %b", a);
                    $display("outputs = %h (%h expected)", y, yexpected);
                    errors = errors + 1;
                end
                vectornum = vectornum + 1;
                if (testvectors[vectornum] === 64'bx) begin
                    $display ("%d tests completed with %d errors", vectornum, errors);
                    $finish;
                end
            end
        end
endmodule
