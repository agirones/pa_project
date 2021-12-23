module insreg(input clk, input irwrite, input [31:0] rd, output reg [31:0] instr);

always @ (posedge clk)
begin
    if(irwrite) begin
        instr <= rd;
        $display("irwrite: %b, instr: %h, rd: %h", irwrite, instr, rd);
    end
end
endmodule
