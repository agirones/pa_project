
module forwardUnit(input wire [4:0] r1A,
                   input wire [4:0] r1B,
                   input wire regWriteM,
                   input wire regWriteW,
                   input wire [4:0] rd_M,
                   input wire [4:0] rd_W,
                   output wire[1:0] ForwardA,
                   output wire[1:0] ForwardB);
    
    reg[1:0] solA, solB;


    always @(*) begin
        if(regWriteM == 1 && rd_M == r1A) solA = 2'b10; 
        else if (regWriteW == 1 && rd_W == r1A)  solA = 2'b01; 
        else solA = 2'b00; 

        if(regWriteM == 1 && rd_M == r1B) solB = 2'b10; 
        else if (regWriteW == 1 && rd_W == r1B) solB = 2'b01; 
        else solB = 2'b00; 
    end

    assign ForwardA = solA;
    assign ForwardB = solB;

endmodule
