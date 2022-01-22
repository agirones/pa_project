module dmem(input logic clk, we,
            input logic [31:0] a, wd,
            output wire [31:0] rd);

logic [31:0] RAM[63:0];

initial
    RAM[0] = 32'd7;

assign rd = RAM[a[31:2]]; // word aligned

always @(posedge clk)
    if (we & (a!==0)) RAM[a[31:2]] <= wd;

always @(negedge clk)
    if (we) $display("-in memory at %d: in %d, it is writen: %d", $time, a, wd);

endmodule
