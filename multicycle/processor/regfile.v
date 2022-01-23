//-----------------------------------------------------
// This is the register file
// Design Name : regfile
// File Name : regfile.v
// Function : This module models the register file
//-----------------------------------------------------
module regfile(input logic clk,
               input logic reset,
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
    always @(posedge clk, reset)
    begin
        rf[5'h0] <= 32'b0; 
        $display("Reg x5 value=%d and reg x9 value=%d", rf[5'h5], rf[5'h9]);
        if(reset)
        begin
            rf[5'h0] <= 32'b0;     

            //rf[5'h1] <= 32'b0;     rf[5'h2] <= 32'b0;     rf[5'h3] <= 32'b0;
            rf[5'h1] <= 5'h1;     rf[5'h2] <= 5'h2;     rf[5'h3] <= 5'h3; //initial value for testing purposes

            rf[5'h4] <= 32'b0;     rf[5'h5] <= 32'b0;     rf[5'h6] <= 32'b0;     rf[5'h7] <= 32'b0;
            rf[5'h8] <= 32'b0;     rf[5'h9] <= 32'b0;     rf[5'ha] <= 32'b0;     rf[5'hb] <= 32'b0;
            rf[5'hc] <= 32'b0;     rf[5'hd] <= 32'b0;     rf[5'he] <= 32'b0;     rf[5'hf] <= 32'b0;
            rf[5'h10] <= 32'b0;    rf[5'h11] <= 32'b0;    rf[5'h12] <= 32'b0;    rf[5'h13] <= 32'b0;
            rf[5'h14] <= 32'b0;    rf[5'h15] <= 32'b0;    rf[5'h16] <= 32'b0;    rf[5'h17] <= 32'b0;
            rf[5'h18] <= 32'b0;    rf[5'h19] <= 32'b0;    rf[5'h1a] <= 32'b0;    rf[5'h1b] <= 32'b0;
            rf[5'h1c] <= 32'b0;    rf[5'h1d] <= 32'b0;    rf[5'h1e] <= 32'b0;    rf[5'h1f] <= 32'b0;
        end
        if (!reset && we3) 
        begin
            rf[wa3] <= wd3;
            $display("+In regfile at %d output: in rf[%d]=%d", $time, wa3, wd3);
        end
    end

    assign rd1=(ra1!=0) ? rf[ra1] : 0;

    assign rd2=(ra2!=0) ? ((ra2!=1) ? rf[ra2] : 258)
                        : 0;
endmodule
