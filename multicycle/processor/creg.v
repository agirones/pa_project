module creg #(parameter WIDTH=2)
             (input clk,
              input [WIDTH-1:0] controls_,
              output reg [WIDTH-1:0] controls);

always @(posedge clk)
    controls <= controls_;

endmodule
