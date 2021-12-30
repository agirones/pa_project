//-----------------------------------------------------
// This is the register file
// Design Name : regfile
// File Name : regfile.v
// Function : This module models the register file
//-----------------------------------------------------
module regfile(input logic clk,
               input logic we3,
               input logic [4:0] ra1, ra2, wa3,
               input logic [31:0] wd3,
               output wire [31:0] rd1, rd2);

    logic [31:0] rf[31:0];

    // three ported register file
    // read two ports combinationally
    // write third port on rising edge of clk
    // register 0 hardwired to 0
    // note: for pipelined processor, write third port
    // on falling edge of clk
    always @(posedge clk)
    begin
        if (we3) 
        begin
            rf[wa3] <= wd3;
            $display("+In regfile at %d output: in rf[%d]=%d", $time, wa3, wd3);
        end
    end

    assign rd1=(ra1!=0) ? rf[ra1] : 0;

    assign rd2=(ra2!=0) ? ((ra2!=1) ? rf[ra2] : 258)
                        : 0;
endmodule
