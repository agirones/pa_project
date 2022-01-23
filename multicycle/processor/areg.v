module areg(input clk, en,
            input [31:0] pcFD,
            input [31:0] rd1, rd2,
            input [4:0] rd,
            input [31:0] SignImm_,
            input sendNop,
            output reg [31:0] SrcAE, SrcBE,
            output reg [4:0] WriteRegE,
            output reg [31:0] WriteDataE,
            output reg [31:0] SignImm,
            output reg [31:0] pcDE);

always @ (posedge clk)
if(en) begin
    if(sendNop) begin
        SrcAE <= 0;
        SrcBE <= 0;
        WriteRegE <= 0;
        WriteDataE <= 0;
        SignImm <= 0;
        pcDE <= pcFD; 
    end
    else begin
        SrcAE <= rd1;
        SrcBE <= rd2;
        WriteRegE <= rd;
        WriteDataE <= rd2;
        SignImm <= SignImm_;
        pcDE <= pcFD;        
    end
end

endmodule
