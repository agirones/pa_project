module pc(input clk, input reset, input logic [31:0] pc_, output logic [31:0] pc);

always@(posedge clk, posedge reset)
begin
    if(reset)
        pc <= 32'b0;
    else
        pc <= pc_;
end

endmodule
