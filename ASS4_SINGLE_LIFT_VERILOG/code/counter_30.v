module counter_30(Clock,Enable_counter,count_over);
	input Clock,Enable_counter;
	output reg count_over;
        
	integer temp =0;

	always @(negedge Clock)
	begin
		if (Enable_counter ==1'b1) begin
			if (Clock ==1'b0) begin
				if (temp==30) begin
					count_over <= 1'b1 ;
				end
				else begin
					temp <= temp+1;
				end
			end
		end
		else begin
			temp<=0;
			count_over<=1'b0;
		end 
	end
endmodule
