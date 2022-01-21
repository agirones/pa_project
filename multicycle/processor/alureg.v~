module alureg(input clk, 
              input [31:0] aluresult,
              input [31:0] WriteDataE,
              input [4:0] writereg_,
              output reg [31:0] aluout,
              output reg [31:0] WriteDataM,
              output reg [4:0] writereg);

always @ (posedge clk)
begin
    aluout <= aluresult;
    WriteDataM <= WriteDataE;
    writereg <= writereg_;
end

endmodule
