module sb(input dhit, MemWrite, Load,
	  input [31:0] a, data,
  	  output hit, sb_emptying,
	  output [31:0] data);

reg [1:0] tail, head;
reg 	   full;
reg [64:0] SB [4]; //valid bit [64], @ [63:32], data [31:0] 

always @ (*) begin
    case({MemWrite, Load})
	2'b00: //ALU operation
	    if(~full && (tail != head)) // Store buffer not empty
	        //Copy cache
	        data <= SB[head][31:0];
	        SB[head][64] <= 0;
	        head <= head + 1;	

	2'b10: //Store
	    if(dhit)
                if(full)
		    sb_emptying <= 1;

	            data <= SB[head][31:0];
	            SB[head][64] <= 0;
	            head <= head + 1;	
	    	
		if(head == (tail + 1)) begin
		    full <= 1;
		    SB[tail + 1] <= {1'b1, a, data};
		    tail <= tail + 1;
	        end

	2'b01: //Load
	    if(dhit) begin
		if(SB[tail][64] && SB[tail][63:32] == a)
		if(SB[tail-1][64] && SB[tail-1][63:32] == a)
		if(SB[tail-2][64] && SB[tail-2][63:32] == a)
		if(SB[tail-3][64] && SB[tail-3][63:32] == a)
		hit <= 1;
            end
end


endmodule
