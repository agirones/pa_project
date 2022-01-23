//-----------------------------------------------------
// This is the multiplexer
// Design Name : mux2
// File Name : mux2.v
//-----------------------------------------------------
module mux4Full #(parameter WIDTH=32)
             (input logic [1:0] s,
              input logic [WIDTH-1:0] d3, d2, d1, d0,
              output wire [WIDTH-1:0] y);

    wire [WIDTH-1:0] i0, i1;

    mux2 #(32) mux0(s[1], d0, d2, i0);
    mux2 #(32) mux1(s[1], d1, d3, i1);
    mux2 #(32) mux2(s[0], i0, i1, y);

    always@(*)
        $display("In mux4 at %d: d0=%d d1=%d d2=%d d3=%d y=%d, s=%b", $time, d0, d1, d2, d3, y, s);

endmodule
