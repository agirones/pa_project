module alureg(input clk, en,
              input [31:0] pcDE,
              input [31:0] aluresult,
              input zero_flag,
              input [31:0] bj_alu_result,
              input [31:0] WriteDataE,
              input [4:0] writereg_,
              output reg [31:0] aluout,
              output reg zero_flagM,
              output reg bj_alu_result_,
              output reg [31:0] WriteDataM,
              output reg [4:0] writereg,
              output reg [31:0] pcEM);

always @ (posedge clk)
if(en)
begin
    aluout <= aluresult;
    zero_flagM <= zero_flag;
    bj_alu_result_ <= bj_alu_result;
    WriteDataM <= WriteDataE;
    writereg <= writereg_;
    pcEM <= pcDE;
end

endmodule
