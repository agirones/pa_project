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
               output reg [31:0] y);
    
    reg [11:0] tempBranch;
    reg [11:0] tempStore;
    assign {instr[31], instr[7], instr[30:25], instr[11:8]} = tempBranch; 
    assign {instr[31:25], instr[11:7]} = tempStore;

    always @(*) begin
        if(isLoad) begin //load        
          y <= {{20{instr[31]}}, instr[31:20]};
        end
        else if(isStore) begin //store        
            y <= {{20{instr[31]}}, tempStore};
        end
        else if(isBranch) begin //branch        
            y <= {{20{instr[31]}}, tempBranch};
        end
        else if(isJump) begin //jump        
            y <= {{20{instr[31]}}, instr[31:20]};
        end
    end

endmodule
