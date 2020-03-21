module Lift_overall(clk,reset,Car_call_signal,Hall_call_Up_signal,Hall_call_Down_signal,MoveUp,MoveDown,OpenDoor,CloseDoor,Stop,LCD,LED_HALL_UP,LED_HALL_DOWN,LED_Car);
	input clk,reset;
	input [5:0] Car_call_signal;
	input [4:0] Hall_call_Up_signal;
	input [5:1] Hall_call_Down_signal;
	output MoveUp,MoveDown,OpenDoor,CloseDoor,Stop;
	output [2:0] LCD;
	output [4:0] LED_HALL_UP;
	output [5:1] LED_HALL_DOWN;
	output [5:0] LED_Car;
	 
	wire [5:0] Car_call_temp;
	wire [4:0] Hall_call_Up_temp;
	wire [5:1] Hall_call_Down_temp;
	wire OpenDoor_temp, CloseDoor_temp,Stop_temp,MoveDown_temp,MoveUp_temp,Passenger_in_temp;
	wire [5:0] Sensor;
	wire [2:0] LCD_temp;
		
	Lift_controller Lift_controller_0(clk, reset,Passenger_in_temp,Sensor,Car_call_temp,Hall_call_Up_temp,Hall_call_Down_temp,MoveUp_temp,MoveDown_temp,OpenDoor_temp,CloseDoor_temp,Stop_temp,LCD_temp);
	Lift_reg Lift_reg_1(clk,Car_call_signal,Hall_call_Up_signal,Hall_call_Down_signal,Sensor,OpenDoor_temp,Hall_call_Up_temp,Hall_call_Down_temp,Car_call_temp);
	Lift_Model Lift_Model_2(clk,MoveUp_temp,MoveDown_temp,OpenDoor_temp,CloseDoor_temp,Stop_temp,Sensor,Passenger_in_temp);
	assign OpenDoor = OpenDoor_temp;
	assign CloseDoor = CloseDoor_temp;
	assign MoveUp = MoveUp_temp;
	assign MoveDown = MoveDown_temp;
	assign Stop = Stop_temp;
	assign LED_HALL_UP = Hall_call_Up_temp;
	assign LED_HALL_DOWN = Hall_call_Down_temp;
	assign LED_Car = Car_call_temp;
	assign LCD = LCD_temp;
 endmodule
