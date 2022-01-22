//-----------------------------------------------------
// This is the sign extension
// Design Name : signext
// File Name : signext.v
//-----------------------------------------------------
module signextD(input wire [31:0] instr,
               input wire isLoad,
               input wire isStore,
               input wire isBranch,
               input wire isJump,
               output reg [63:0] y);
    
    assign {instr[31], instr[7], instr[30:25], instr[11:8]} = tempBranch; 
    assign {instr[31:25], instr[11:7]} = tempStore;

    always @(*) begin
        if(isLoad) begin //load        
          assign y = $signed(instr[31:20]);
        end
        else if(isStore) begin //store        
            assign y = $signed(tempStore);
        end
        else if(isBranch) begin //branch        
            assign y = $signed(tempBranch);
        end
        else if(isJump) begin //jump        
            assign y = $signed(instr[31:20]);
        end
        else begin
            assign y = 0;
        end
    end

endmodule
