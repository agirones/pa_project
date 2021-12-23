module imem(input logic [31:0] a,
            output reg [31:0] rd);

    logic [31:0] RAM[63:0];

    initial
        $readmemh("memfile.dat", RAM);

    always @ (*)
        rd <= RAM[a/4];

endmodule
