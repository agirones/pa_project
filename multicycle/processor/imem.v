module imem(input clk, input logic [31:0] a,
            output reg [31:0] rd);

    logic [31:0] RAM[63:0];

    initial
        $readmemh("memfile.dat", RAM);

    always @ (posedge clk)
    begin
        rd <= RAM[a]; // word aligned
        #1;$display("a= %d, rd= %h", a, rd);
    end

endmodule
