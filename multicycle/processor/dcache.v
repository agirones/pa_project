`include "dmem.v"

typedef struct packed {
	logic valid;         // 154
	logic [25:0] tag;    // 153:128
	logic [127:0] data;  // 127:0
} d_cache_entry;

module dcache(input clk, sb_write, load, sb_hit,
	      input logic [31:0] a, wd,
	      output reg hit,
              output reg [31:0] rd);

    wire [127:0] data;
    //debug
    reg valid0, valid1, valid2, valid3;
    reg [25:0] tag0, tag1, tag2, tag3;
    reg [127:0] data0, data1, data2, data3;
    reg [1:0] set;

    dmem dmem (clk, sb_write, a, wd, data);
    d_cache_entry dcache [4];
    initial
    begin
	    dcache[0][154] <= 0;
	    dcache[1][154] <= 0;
	    dcache[2][154] <= 0;
	    dcache[3][154] <= 0;
    end

    always @ (*)
    begin
            valid0 <= dcache[0][154];
            tag0 <= dcache[0][153:128];
            data0 <= dcache[0][127:0];

            valid1 <= dcache[1][154];
            tag1 <= dcache[1][153:128];
            data1 <= dcache[1][127:0];

            valid2 <= dcache[2][154];
            tag2 <= dcache[2][153:128];
            data2 <= dcache[2][127:0];

            valid3 <= dcache[3][154];
            tag3 <= dcache[3][153:128];
            data3 <= dcache[3][127:0];

	    set <= a[5:4];

	    if(sb_write | (load & ~sb_hit))
	        case(set)
		    2'b00: begin
		        if(a[31:6] == dcache[0][153:128] && dcache[0][154])
			    hit <= 1;
		        else begin
			    hit <= 0;
			    dcache[0][154] <= 1;
			    dcache[0][153:128] <= a[31:6];
			    repeat (10) @ (posedge clk) begin
			        dcache[0][127:0] <= data;
			    end
			    hit <= 1;
			end

			case(a[3:2])
			    2'b00: begin
				if (sb_write) dcache[0][31:0] <= wd;
			        else rd <= dcache[0][31:0];
			    end
			    2'b01: begin
				if (sb_write) dcache[0][63:32] <= wd;
			        else rd <= dcache[0][63:32];
			    end
			    2'b10: begin
				if (sb_write) dcache[0][95:64] <= wd;
			        else rd <= dcache[0][95:64];
			    end
			    2'b11: begin
				if (sb_write) dcache[0][127:96] <= wd;
			        else rd <= dcache[0][127:96];
			    end
	      	        endcase
		    end

		    2'b01: begin
		        if(a[31:6] == dcache[1][153:128] && dcache[1][154])
			    hit <= 1;
		        else begin
			    hit <= 0;
			    dcache[1][154] <= 1;
			    dcache[1][153:128] <= a[31:6];
			    repeat (10) @ (posedge clk) begin
			        dcache[1][127:0] <= data;
			    end
			    hit <= 1;
			end

			case(a[3:2])
			    2'b00: begin
				if (sb_write) dcache[1][31:0] <= wd;
			        else rd <= dcache[1][31:0];
			    end
			    2'b01: begin
				if (sb_write) dcache[1][63:32] <= wd;
			        else rd <= dcache[1][63:32];
			    end
			    2'b10: begin
				if (sb_write) dcache[1][95:64] <= wd;
			        else rd <= dcache[1][95:64];
			    end
			    2'b11: begin
				if (sb_write) dcache[1][127:96] <= wd;
			        else rd <= dcache[1][127:96];
			    end
	      	        endcase
		    end

		    2'b10:  begin
		        if(a[31:6] == dcache[2][153:128] && dcache[2][154])
			    hit <= 1;
		        else begin
			    hit <= 0;
			    dcache[2][154] <= 1;
			    dcache[2][153:128] <= a[31:6];
			    repeat (10) @ (posedge clk) begin
			        dcache[2][127:0] <= data;
		            end
			    hit <= 1;
			end

			case(a[3:2])
			    2'b00: begin
				if (sb_write) dcache[2][31:0] <= wd;
			        else rd <= dcache[2][31:0];
			    end
			    2'b01: begin
				if (sb_write) dcache[2][63:32] <= wd;
			        else rd <= dcache[2][63:32];
			    end
			    2'b10: begin
				if (sb_write) dcache[2][95:64] <= wd;
			        else rd <= dcache[2][95:64];
			    end
			    2'b11: begin
				if (sb_write) dcache[2][127:96] <= wd;
			        else rd <= dcache[2][127:96];
			    end
	      	        endcase
		    end

		    2'b11: begin
		        if(a[31:6] == dcache[3][153:128] && dcache[3][154])
			    hit <= 1;
		        else begin
			    hit <= 0;
			    dcache[3][154] <= 1;
			    dcache[3][153:128] <= a[31:6];
			    repeat (10) @ (posedge clk) begin
			        dcache[3][127:0] <= data;
			    end
			    hit <= 1;
			end

			case(a[3:2])
			    2'b00: begin
				if (sb_write) dcache[3][31:0] <= wd;
			        else rd <= dcache[3][31:0];
			    end
			    2'b01: begin
				if (sb_write) dcache[3][63:32] <= wd;
			        else rd <= dcache[3][63:32];
			    end
			    2'b10: begin
				if (sb_write) dcache[3][95:64] <= wd;
			        else rd <= dcache[3][95:64];
			    end
			    2'b11: begin
				if (sb_write) dcache[3][127:96] <= wd;
			        else rd <= dcache[3][127:96];
			    end
	      	        endcase
		    end
		endcase
    end
always @ (*) begin
    $display("**********************At %d, set = %b, a[3:2] = %b", $time, set, a[3:2]);
    $display("**********************At %d, valid[0] = %b, data[0]= %h", $time, dcache[0][154], dcache[0][127:0]);
    $display("**********************At %d, valid[1] = %b, data[1]= %h", $time, dcache[1][154], dcache[1][127:0]);
    $display("**********************At %d, valid[2] = %b, data[2]= %h", $time, dcache[2][154], dcache[2][127:0]);
    $display("**********************At %d, valid[3] = %b, data[3]= %h", $time, dcache[3][154], dcache[3][127:0]);
end

endmodule
