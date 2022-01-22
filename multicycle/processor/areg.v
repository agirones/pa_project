module areg(input clk, en,
            input [31:0] pcFD,
            input [31:0] rd1, rd2,
            input [4:0] rd,
            input [31:0] SignImm_,
            output reg [31:0] SrcAE, SrcBE,
            output reg [4:0] WriteRegE,
            output reg [31:0] WriteDataE,
            output reg [31:0] SignImm,
            output reg [31:0] pcDE);

always @ (posedge clk)
if(en)
begin
    SrcAE <= rd1;
    SrcBE <= rd2;
    WriteRegE <= rd;
    WriteDataE <= rd2;
    SignImm <= SignImm_;
    pcDE <= pcFD;
end

endmodule
