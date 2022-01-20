`include "imem.v"

typedef struct packed {
	logic valid;
	logic [27:0] tag;
	logic [127:0] data;
} cache_entry;

module icache(input clk,
	      input logic [31:0] a,
	      output reg hit,
              output reg [31:0] rd);

    imem imem (a, instr);
    cache_entry icache [4];

    always @ (posedge clk)
	    case(a[5:4]):
		    2'b00: begin
			   if(a[27:0] == icache[0][155:128] && icache[0][156])
			   begin
				   hit <= 1;
				   case(a[3:2]):
					   2'b00: rd <= icache[0][31:0];
					   2'b01: rd <= icache[0][63:32];
					   2'b10: rd <= icache[0][95:64];
					   2'b11: rd <= icache[0][127:96];
				   endcase
			   end
			   else
			   begin
				   hit <= 0;
				   icache[0][156] <= 1;
				   icache[0][155:128] <= a[27:0];
				   repeat (10) @ (posedge clk);
				   icache[0][127:0] <= instr;
			   end
		    2'b01:
			   if(a[27:0] == icache[1][155:128] && icache[1][156])
			   begin
				   hit <= 1;
				   case(a[3:2]):
					   2'b00: rd <= icache[1][31:0];
					   2'b01: rd <= icache[1][63:32];
					   2'b10: rd <= icache[1][95:64];
					   2'b11: rd <= icache[1][127:96];
				   endcase
			   end
			   else
			   begin
				   hit <= 0;
				   icache[1][156] <= 1;
				   icache[1][155:128] <= a[27:0];
				   repeat (10) @ (posedge clk);
				   icache[1][127:0] <= instr;
			   end
		   2'b10: begin
			   if(a[27:0] == icache[2][155:128] && icache[2][156])
			   begin
				   hit <= 1;
				   case(a[3:2]):
					   2'b00: rd <= icache[2][31:0];
					   2'b01: rd <= icache[2][63:32];
					   2'b10: rd <= icache[2][95:64];
					   2'b11: rd <= icache[2][127:96];
				   endcase
			   end
			   else
			   begin
				   hit <= 0;
				   icache[2][156] <= 1;
				   icache[2][155:128] <= a[27:0];
				   repeat (10) @ (posedge clk);
				   icache[2][127:0] <= instr;
			   end
		   2'b11: begin
			   if(a[27:0] == icache[3][155:128] && icache[3][156])
			   begin
				   hit <= 1;
				   case(a[3:2]):
					   2'b00: rd <= icache[3][31:0];
					   2'b01: rd <= icache[3][63:32];
					   2'b10: rd <= icache[3][95:64];
					   2'b11: rd <= icache[3][127:96];
				   endcase
			   end
			   else
			   begin
				   hit <= 0;
				   icache[3][156] <= 1;
				   icache[3][155:128] <= a[27:0];
				   repeat (10) @ (posedge clk);
				   icache[3][127:0] <= instr;
			   end
		    endcase

endmodule
