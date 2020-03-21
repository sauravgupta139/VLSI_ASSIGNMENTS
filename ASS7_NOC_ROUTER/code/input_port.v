module input_port(clk,Data_Request_Switching,Data_Request_Routing,input_flit,Credit_out,output_flit);
	input clk,Data_Request_Switching,Data_Request_Routing;
	input [31:0] input_flit;
	output reg Credit_out;
	output reg[31:0] output_flit;
	reg Data_Request;
	reg[191:0] Virtual_buffer=192'h000000000000000000000000000000000000000000000000;
	always @(negedge clk)
	begin
		
		if(Data_Request==1'b1) begin
			Virtual_buffer = Virtual_buffer >> 32;
			Credit_out = 1'b1;
		end
		
		if(Virtual_buffer[31:30]==2'b00)
			Virtual_buffer[31:0] = input_flit;
		else if(Virtual_buffer[63:62]==2'b00)
			Virtual_buffer[63:32] = input_flit;
		else if(Virtual_buffer[95:94]==2'b00)
			Virtual_buffer[95:64] = input_flit;
		else if(Virtual_buffer[127:126]==2'b00)
			Virtual_buffer[127:96] = input_flit;
		else if(Virtual_buffer[159:158]==2'b00)
			Virtual_buffer[159:128] = input_flit;
		else if(Virtual_buffer[191:190]==2'b00)
			Virtual_buffer[191:160] = input_flit;
		
		output_flit = Virtual_buffer[31:0];
	end	
	
	always@(Data_Request_Switching,Data_Request_Routing)
		Data_Request = Data_Request_Switching & Data_Request_Routing;
		
endmodule