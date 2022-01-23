//-----------------------------------------------------
// This is the multiplexer
// Design Name : mux2
// File Name : mux2.v
//-----------------------------------------------------
module mux4Full #(parameter WIDTH=32)
             (input logic [1:0] s,
              input logic [WIDTH-1:0] d3, d2, d1, d0,
              output reg [WIDTH-1:0] Y);


    always@(*)
        case(s)
            2'b00: Y <= d0;
            2'b01: Y <= d1;
            2'b10: Y <= d2;
            default: Y <= d3;
        endcase
endmodule
