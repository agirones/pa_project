module creg #(parameter WIDTH=2)
             (input clk, en, sendNop,
              input [WIDTH-1:0] controls_,
              output reg [WIDTH-1:0] controls);

always @(posedge clk)
if(en) begin
    if(sendNop) begin
        controls <= { 1'b0, {WIDTH-1{1'b0}} };
    end
    else
        controls <= controls_;    
end

endmodule
