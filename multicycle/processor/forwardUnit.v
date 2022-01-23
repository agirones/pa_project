
module forwardUnit(input wire [31:0] r1A,
                   input wire [31:0] r1B,
                   input wire [31:0] rD_M,
                   input wire isLoadM,
                   input wire isStoreM,
                   input wire [31:0] rD_WB,
                   input wire isLoadWB, 
                   output wire[1:0] selectorRd1,
                   output wire[1:0] selectorRd2);
    

    always @(*) begin
        if(r1A == rD_M && ~load) begin 
            assign selectorRd1 = 2'b10;
        end
        else if(r1A == rD_WB && ) begin
            
        end
    end

endmodule
