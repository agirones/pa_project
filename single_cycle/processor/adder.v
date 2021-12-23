//-----------------------------------------------------
// This is the adder
// Design Name : adder
// File Name : adder.v
// Function : This module adds two 32-bits input
//-----------------------------------------------------
module adder(input [31:0] a, b,
             output [31:0] y);
    assign y = a + b;
endmodule
