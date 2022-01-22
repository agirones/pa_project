//-----------------------------------------------------
// This is the sign extension
// Design Name : signext
// File Name : signext.v
//-----------------------------------------------------
module signext #(parameter WIDTH=12)
              (input logic [WIDTH-1:0] a,
               output wire [31:0] y);

    assign y ={{WIDTH{a[WIDTH-1]}}, a};

endmodule
