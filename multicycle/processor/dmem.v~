module dmem(input logic clk, we,
            input logic [31:0] a, wd,
            output reg [127:0] rd);

logic [31:0] RAM[63:0];
reg [31:0] add0, add1, add2, add3;

initial
    RAM[0] = 32'd7;

always @ (*)
begin
    add0 = (a>>4)<<2;
    add1 = add0 + 32'h1;
    add2 = add0 + 32'h2;
    add3 = add0 + 32'h3;

    rd = {RAM[add3], RAM[add2], RAM[add1], RAM[add0]};
end

always @(posedge clk)
    if (we & (a!==0)) RAM[a[31:2]] <= wd;

always @(negedge clk)
    if (we) $display("-in memory at %d: in %d, it is writen: %d", $time, a, wd);

endmodule
