module  Lift_reg (clk,Car_call_signal,Hall_call_Up_signal,Hall_call_Down_signal,Sensor,OpenDoor,Hall_call_Up,Hall_call_Down,Car_call);
	input clk,OpenDoor;
	input [5:0] Car_call_signal,Sensor;
	input [4:0] Hall_call_Up_signal;
	input [5:1] Hall_call_Down_signal;
	 
	output [4:0] Hall_call_Up;
	output [5:1] Hall_call_Down;
	output [5:0] Car_call;

	reg [5:1] Hall_call_Down_temp =5'b00000;
	reg [4:0] Hall_call_Up_temp=5'b00000;
	reg [5:0] Car_call_temp=6'b000000;

	 always @ (posedge clk)
		begin
		if (clk) begin
			Hall_call_Up_temp <= Hall_call_Up_signal | Hall_call_Up_temp;
			Hall_call_Down_temp <= Hall_call_Down_signal | Hall_call_Down_temp;
			Car_call_temp <= Car_call_signal | Car_call_temp;
			if(OpenDoor == 1'b1) begin
				if(Sensor[0] == 1'b1) begin
					Hall_call_Up_temp[0]<=1'b0;
					Car_call_temp[0]<=1'b0; end
				else if(Sensor[1] == 1'b1) begin
					Hall_call_Up_temp[1]<=1'b0;
					Hall_call_Down_temp[1]<=1'b0;
					Car_call_temp[1]<=1'b0; end
				else if(Sensor[2] == 1'b1) begin
					Hall_call_Up_temp[2]<=1'b0;
					Hall_call_Down_temp[2]<=1'b0;
					Car_call_temp[2]<=1'b0; end
				else if(Sensor[3] == 1'b1) begin
					Hall_call_Up_temp[3]<=1'b0;
					Hall_call_Down_temp[3]<=1'b0;
					Car_call_temp[3]<=1'b0; end
				else if(Sensor[4] == 1'b1) begin
					Hall_call_Up_temp[4]<=1'b0;
					Hall_call_Down_temp[4]<=1'b0;
					Car_call_temp[4]<=1'b0; end
				else if(Sensor[5] == 1'b1) begin
					Hall_call_Down_temp[5]<=1'b0;
					Car_call_temp[5]<=1'b0; end
			end
		end
		end
		assign Hall_call_Down = Hall_call_Down_temp;
		assign Hall_call_Up = Hall_call_Up_temp;
		assign Car_call = Car_call_temp;
endmodule
