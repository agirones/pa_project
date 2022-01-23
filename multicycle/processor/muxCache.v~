//-----------------------------------------------------
// This is the multiplexer
// Design Name : mux2
// File Name : mux2.v
//-----------------------------------------------------
module muxCache #(parameter WIDTH =64)
                 (input logic s,
                  input logic [WIDTH-1:0] d0, d1,
                  output wire [WIDTH/2-1:0] a,
                  output wire [WIDTH/2-1:0] data);

    assign a    = s ? d1[63:32] : d0[63:32];
    assign data = s ? d1[31:0] : d0[31:0];

endmodule
