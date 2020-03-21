module Lift(clk,MoveUp,MoveDown,OpenDoor,CloseDoor,stop,start,done,Sensor,Passenger_in);
	input clk,MoveUp,MoveDown,OpenDoor,CloseDoor,stop,done;
	output [5:0] Sensor;
	output Passenger_in,start;
	
	reg Passenger_in_temp=1'b0,start_temp=1'b0;
	reg [5:0] Sensor_temp = 6'b000001;

	always @(posedge clk)
	begin
	if(clk==1'b1) begin
		if(MoveUp ==1'b1 && stop==1'b0) begin
			start_temp<=1;
			if(done==1'b1) begin
				start_temp<=0;
				Sensor_temp<= Sensor_temp<<1;
			end
		end
		
		else if(MoveDown ==1'b1 && stop==1'b0) begin
			start_temp<=1;
			if(done==1'b1) begin
				start_temp<=0;
				Sensor_temp<= Sensor_temp>>1;
			end
		end
		
		if(OpenDoor==1'b1 && stop==1'b1) begin
			start_temp<=1;Passenger_in_temp<=0;
			if(done==1'b1) begin
				start_temp<=0;
				Passenger_in_temp<=1;
			end
		end
			
		else if(CloseDoor==1'b1 && stop==1'b1) begin
			start_temp<=0;
		end
	end
	end
	assign Sensor = Sensor_temp;
	assign Passenger_in = Passenger_in_temp;
	assign start = start_temp;
	
endmodule
