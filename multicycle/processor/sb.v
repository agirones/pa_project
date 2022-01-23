module sb(input clk, dhit, MemWrite, Load,
	  input [31:0] a, data,
  	  output reg hit, sb_write_cache,
	  output reg [31:0] sb_address, sb_data);

reg [1:0]  tail, head;
reg 	   full;
reg [64:0] SB [4]; //valid bit [64], @ [63:32], data [31:0] 

initial begin
    head <= 2'b00;
    tail <= 2'b00;
    full <= 1'b0;
    sb_write_cache <= 0;
    hit <= 0;
end

always @ (*) begin
	$display("MEMWRITE value=%b , LOAD value=%b", MemWrite, Load);
	$display("SB[0][63:0] value=%b , SB[0][64] value=%b", SB[0][63:0], SB[0][64]);
	$display("SB[1][63:0] value=%b , SB[1][64] value=%b", SB[1][63:0], SB[1][64]);
	$display("SB[2][63:0] value=%b , SB[2][64] value=%b", SB[2][63:0], SB[2][64]);
	$display("SB[3][63:0] value=%b , SB[3][64] value=%b", SB[3][63:0], SB[3][64]);
	$display("//////////////////////////////////////////////////////////////////////////////////////////////");
    case({MemWrite, Load})
	2'b00: begin //ALU operation
            hit <= 0;
	    if(~full && (tail != head)) begin // Store buffer not empty
	        //Copy to cache
		sb_write_cache <= 1;
	        {sb_address, sb_data} <= SB[head][63:0];
	        SB[head][64] <= 0;
	        head <= head + 1;	
	    end
	end

	2'b10: begin //Store
		if(full) begin
		    sb_write_cache <= 1;

	            {sb_address, sb_data} = SB[head][63:0];
	            SB[head][64] = 0;
	            head = head + 1;	
		    //if(~dhit) @(posedge dhit);

	            {sb_address, sb_data} = SB[head][63:0];
	            SB[head][64] = 0;
	            head = head + 1;	
		    //if(~dhit) @(posedge dhit);

	            {sb_address, sb_data} = SB[head][63:0];
	            SB[head][64] = 0;
	            head = head + 1;	
		    //if(~dhit) @(posedge dhit);

	            {sb_address, sb_data} = SB[head][63:0];
	            SB[head][64] = 0;
	            head = head + 1;	
		    //if(~dhit) @(posedge dhit);

		    full <= 0;
	        end
		else if(head == (tail + 1)) begin
		    sb_write_cache <= 0; 
		    full <= 1;
		    SB[tail + 1] <= {1'b1, a, data};
		    tail <= tail + 1;
	        end
		else begin
		    sb_write_cache <= 0; 
		    tail <= tail + 1;
		    SB[tail] <= {1'b1, a, data};
		end
	end

	2'b01: begin //Load
		if(SB[tail  ][64] && SB[tail][63:32] == a) begin
		    sb_write_cache <= 0;
		    hit <= 1;
	            {sb_address, sb_data} <= SB[tail][63:0];
	        end
		else if(SB[tail-1][64] && SB[tail-1][63:32] == a) begin
		    sb_write_cache <= 0;
		    hit <= 1;
	            {sb_address, sb_data} <= SB[tail-1][63:0];
	        end
		else if(SB[tail-2][64] && SB[tail-2][63:32] == a) begin
		    sb_write_cache <= 0;
		    hit <= 1;
	            {sb_address, sb_data} <= SB[tail-2][63:0];
	        end
		else if(SB[tail-3][64] && SB[tail-3][63:32] == a) begin
		    sb_write_cache <= 0;
		    hit <= 1;
	            {sb_address, sb_data} <= SB[tail-3][63:0];
	        end
		else hit <= 0;
        end

	default: hit <= 0;

	endcase

end


endmodule
