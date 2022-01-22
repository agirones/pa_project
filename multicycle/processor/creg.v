module creg #(parameter WIDTH=2)
             (input clk, en,
              input [WIDTH-1:0] controls_,
              output reg [WIDTH-1:0] controls);

always @(posedge clk)
if(en)
    controls <= controls_;

endmodule
