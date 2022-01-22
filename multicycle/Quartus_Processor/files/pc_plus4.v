module pc_plus4(input logic [31:0] pc, output logic [31:0] pc_);

always @ (*)
    pc_ <= pc + 4;

endmodule
