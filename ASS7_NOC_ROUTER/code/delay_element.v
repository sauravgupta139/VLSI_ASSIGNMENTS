module delay_element(clk,Input_flit,Output_flit);
	input clk;
	input[31:0] Input_flit;
	output reg[31:0] Output_flit;
	reg[31:0] temp;
	
	always@(posedge clk)
	begin
		temp <= Input_flit;
	end
	always@(negedge clk)
	begin
		Output_flit <= temp;
	end
endmodule
