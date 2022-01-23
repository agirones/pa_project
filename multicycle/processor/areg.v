module areg(input clk, en,
            input [31:0] pcFD,
            input [31:0] rd1, rd2,
            input [4:0] rd,
            input [31:0] SignImm_,
            input sendNop,
            input [4:0] ra1,
            input [4:0] ra2,
            output reg [31:0] SrcAE, SrcBE,
            output reg [4:0] WriteRegE,
            output reg [31:0] WriteDataE,
            output reg [31:0] SignImm,
            output reg [31:0] pcDE,
            output reg [4:0] ra1_out,
            output reg [4:0] ra2_out);

always @ (posedge clk)
if(en) begin
    if(sendNop) begin
        SrcAE <= 0;
        SrcBE <= 0;
        WriteRegE <= 0;
        WriteDataE <= 0;
        SignImm <= 0;
        pcDE <= pcFD; 
        ra1_out <= 0;
        ra2_out <= 0;
    end
    else begin
        SrcAE <= rd1;
        SrcBE <= rd2;
        WriteRegE <= rd;
        WriteDataE <= rd2;
        SignImm <= SignImm_;
        pcDE <= pcFD;        
        ra1_out <= ra1;
        ra2_out <= ra2;
    end
end

endmodule
