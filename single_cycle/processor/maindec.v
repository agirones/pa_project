//-----------------------------------------------------
// This is the main decoder
// Design Name : maindec
// File Name : maindec.v
// Function : This module is the main decoder
//-----------------------------------------------------
module maindec(input    [5:0] op,
               output         memtoreg, memwrite,
               output         branch, alusrc,
               output         regdst, regwrite,
               output         jump,
               output   [1:0] aluop);

  reg [8:0] controls;
  assign {regwrite, regdst, alusrc,
          branch, memwrite,
          memtoreg, jump, aluop} = controls;
  always @(*)
      case(op)
          6'b000000: controls <= 9'b110000010; //Rtyp
          6'b000011: controls <= 9'b101001000; //LW
          6'b101011: controls <= 9'b001010010; //SW
          6'b000100: controls <= 9'b000100001; //BEQ
          6'b001000: controls <= 9'b101000000; //ADDI
          default:   controls <= 9'bxxxxxxxxx; //???
      endcase
endmodule

