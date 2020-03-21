module Lift_Model(clk,MoveUp,MoveDown,OpenDoor,CloseDoor,Stop,Sensor,Passenger_in);
	input clk,MoveUp,MoveDown,OpenDoor,CloseDoor,Stop;
	output [5:0] Sensor;
	output Passenger_in;

	wire start;
	wire done;

	Lift Lift_0(clk,MoveUp,MoveDown,OpenDoor,CloseDoor,Stop,start,done,Sensor,Passenger_in);
	counter_30 Counter_1(clk,start,done);
endmodule