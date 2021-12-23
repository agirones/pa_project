module pc(input clk, input [31:0] pc_, output reg [31:0] pc);

always@(posedge clk)
begin
    pc <= pc_;
    #1;$display("pc_= %d, pc= %d", pc_, pc);
end

endmodule
