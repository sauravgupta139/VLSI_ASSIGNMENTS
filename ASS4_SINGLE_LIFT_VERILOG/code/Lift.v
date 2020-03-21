module Lift(clk,MoveUp,MoveDown,OpenDoor,CloseDoor,stop,start,done,Sensor,Passenger_in);
	input clk,MoveUp,MoveDown,OpenDoor,CloseDoor,stop,done;
	output [5:0] Sensor;
	output reg Passenger_in,start;

	reg [5:0] Sensor_temp = 6'b000001;

	always @(posedge clk)
	begin
	if(clk==1'b1) begin
		if(MoveUp ==1'b1) begin
			start<=1;
			if(done==1'b1) begin
				start<=0;
				Sensor_temp<= Sensor_temp<<1;
			end
		end
		
		else if(MoveDown ==1'b1) begin
			start<=1;
			if(done==1'b1) begin
				start<=0;
				Sensor_temp<= Sensor_temp>>1;
			end
		end
		
		else if(OpenDoor==1'b1 && stop==1'b1) begin
			start<=1;Passenger_in<=0;
			if(done==1'b1) begin
				start<=0;
				Passenger_in<=1;
			end
		end
			
		else if(CloseDoor==1'b1 && stop==1'b1) begin
			start<=0;
		end
	end
	end
	assign Sensor = Sensor_temp;
endmodule
