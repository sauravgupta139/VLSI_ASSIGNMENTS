module RLE(Data_In,Enable,fast_clock,data_clock,start,Data_out,Data_valid);
	input [7:0] Data_In;
	input Enable;
	input fast_clock;
	input data_clock;
	input start;
	
	output reg [7:0] Data_out;
	output reg Data_valid;
	
	reg [39:0] Data_buffer=40'h0000000000;
	reg Data_push;
	reg [7:0] prev_Data,prev_prev_Data;
	reg [7:0] count=8'h00,count_temp;
	reg countgt2,counteq255,Data_eq_Prev,Data_buffer2,Data_buffern;
	
	parameter ESC = 8'h1B;
	parameter IDLE=0, Rdy=1, count_increment =2, output_prev_data_with_count=3, output_Buffer_data_without_count=4, output_Buffer_data_without_count1=5, clear_count=6, Dummy=7;
	reg[2:0] state_signal=0, next_state_var;
	
	always @(posedge data_clock)
	begin
		if(start==1'b1)
			Data_eq_Prev=1'b1;
		else if(Data_In==prev_Data)
			Data_eq_Prev=1'b1;
		else
			Data_eq_Prev=1'b0;
	end
	
	always @(posedge data_clock)
	begin
		if(count==8'hFF)
			counteq255 = 1'b1;
		else
			counteq255= 1'b0;
	end
	
	always @(Enable,Data_eq_Prev,state_signal,countgt2,counteq255,prev_prev_Data,count)
   	begin
	if(Enable==1'b1) begin
      	case(state_signal)
		IDLE: begin
				next_state_var<= Rdy;
		end
		
		Rdy: begin
			if(Data_eq_Prev==1'b1 && counteq255==1'b0)
				next_state_var<= count_increment;
			else if((Data_eq_Prev==1'b0 && (countgt2==1'b1||prev_prev_Data == ESC)) || (Data_eq_Prev==1'b1 && counteq255==1'b1))
				next_state_var<= output_prev_data_with_count;
			else if(Data_eq_Prev==1'b0 && count==8'h01)
				next_state_var <= output_Buffer_data_without_count1;
			else
				next_state_var<= output_Buffer_data_without_count;
		end
		
		count_increment:begin
			next_state_var<= Dummy;	
		end
		
		output_prev_data_with_count: begin
			next_state_var<= clear_count;			
		end
		
		output_Buffer_data_without_count: begin
			next_state_var<= clear_count;
		end
		
		output_Buffer_data_without_count1: begin
			next_state_var<= clear_count;
		end
		
		clear_count: begin
			next_state_var<= IDLE;
		end
		
		Dummy: begin
			next_state_var<=IDLE;
		end
		endcase
	end
	
	else
		next_state_var<=IDLE;
		
	end
	
	always@(posedge fast_clock) 
	begin
		state_signal<=next_state_var;
	end
	
	always@(state_signal)
	begin
		case(state_signal)
		IDLE: begin
			Data_push<= 1'b0;
		end
		
		Rdy: begin
			Data_push<= 1'b0;
			prev_Data = Data_In;
			if(count>8'h02)
				countgt2=1'b1;
			else
				countgt2=1'b0;
		end
		
		count_increment:begin
			Data_push<= 1'b0;
			count<=count+8'h01;
			
		end
		
		output_prev_data_with_count: begin
			Data_push<= 1'b1;
			Data_buffern<=1'b1;
			Data_buffer2 <= 1'b0;
		end
		
		output_Buffer_data_without_count: begin
			Data_push<= 1'b1;
			Data_buffern<=1'b0;
			Data_buffer2 <= 1'b1;
		end
		
		output_Buffer_data_without_count1: begin
			Data_push<= 1'b1;
			Data_buffern<=1'b0;
			Data_buffer2 <= 1'b0;
		end
		
		clear_count: begin
			count_temp= count;
			count=8'h01;
		end
		
		Dummy: begin
		end
		
		endcase
	end
	
	
	always @(posedge data_clock)
	begin
	if(Data_buffer[15:0]==16'h0000)begin
		Data_out =  Data_buffer[23:16];
		Data_buffer = Data_buffer >> 24;
	end
	else if(Data_buffer[7:0]==8'h00)begin
		Data_out =  Data_buffer[15:8];
		Data_buffer = Data_buffer >> 16;
	end
	else begin
		Data_out =  Data_buffer[7:0];
		Data_buffer = Data_buffer >> 8;
	end
		
	if(Data_push==1'b1)begin
		if(Data_buffern==1'b1)
			Data_buffer[39:16] = {prev_prev_Data,count_temp,ESC};
		else if(Data_buffer2==1'b1) begin
			if(Data_buffer[31:16]==8'b0000)
				Data_buffer[31:16]= {prev_prev_Data,prev_prev_Data};
			else
				Data_buffer[39:24]= {prev_prev_Data,prev_prev_Data};
		end
		else begin
			if(Data_buffer[23:16]==8'b00)
				Data_buffer[23:16]= prev_prev_Data;
			else if(Data_buffer[31:24]==8'b00)
				Data_buffer[31:24]= prev_prev_Data;
			else
				Data_buffer[39:32]= prev_prev_Data;
		end
	end
		if(Data_out==8'h00)
			Data_valid = 1'b0;
		else
			Data_valid = 1'b1;	
			
		prev_prev_Data = prev_Data;
	end
endmodule