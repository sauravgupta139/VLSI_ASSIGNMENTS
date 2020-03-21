module Lift_overall(clk,emergency,Car_call_signal1,Car_call_signal2,Car_call_signal3,Hall_call_Up_signal,Hall_call_Down_signal,MoveUp,MoveDown,OpenDoor,CloseDoor,Stop,LCD1,LCD2,LCD3,LED_HALL_UP,LED_HALL_DOWN,LED_Car1,LED_Car2,LED_Car3);
	input clk;
	input [3:1] emergency;
	input [5:0] Car_call_signal1,Car_call_signal2,Car_call_signal3;
	input [4:0] Hall_call_Up_signal;
	input [5:1] Hall_call_Down_signal;
	
	output [3:1] MoveUp,MoveDown,OpenDoor,CloseDoor,Stop;
	output [4:0] LED_HALL_UP;
	output [5:1] LED_HALL_DOWN;
	output [5:0] LED_Car1,LED_Car2,LED_Car3;
	output [2:0] LCD1,LCD2,LCD3;
	 
	wire [5:0] Car_call_temp1,Car_call_temp2,Car_call_temp3;
	wire [4:0] Hall_call_Up_temp1,Hall_call_Up_temp2,Hall_call_Up_temp3;
	wire [5:1] Hall_call_Down_temp1,Hall_call_Down_temp2,Hall_call_Down_temp3;
	wire [3:1] OpenDoor_temp, CloseDoor_temp,Stop_temp,MoveDown_temp,MoveUp_temp,Passenger_in_temp;
	wire [5:0] Sensor1, Sensor2, Sensor3;
	wire one_is_nearest_temp,two_is_nearest_temp,three_is_nearest_temp;
	wire [4:0] Hall_call_Up_signalout1_temp,Hall_call_Up_signalout2_temp,Hall_call_Up_signalout3_temp;
	wire [5:1] Hall_call_Down_signalout1_temp,Hall_call_Down_signalout2_temp, Hall_call_Down_signalout3_temp;
	wire [2:0] LCD_temp1,LCD_temp2,LCD_temp3;
	
	Lift_master_controller Lift_master_controller_1(clk,emergency,Sensor1,Sensor2,Sensor3,MoveUp_temp,MoveDown_temp,Stop_temp,Hall_call_Up_signal,Hall_call_Down_signal,Hall_call_Up_signalout1_temp,Hall_call_Up_signalout2_temp,Hall_call_Up_signalout3_temp,Hall_call_Down_signalout1_temp,Hall_call_Down_signalout2_temp, Hall_call_Down_signalout3_temp);	
	Lift_controller Lift_controller_1(clk, emergency[1],Passenger_in_temp[1],Sensor1,Car_call_temp1,Hall_call_Up_temp1,Hall_call_Down_temp1,MoveUp_temp[1],MoveDown_temp[1],OpenDoor_temp[1],CloseDoor_temp[1],Stop_temp[1],LCD_temp1);
	Lift_controller Lift_controller_2(clk, emergency[2],Passenger_in_temp[2],Sensor2,Car_call_temp2,Hall_call_Up_temp2,Hall_call_Down_temp2,MoveUp_temp[2],MoveDown_temp[2],OpenDoor_temp[2],CloseDoor_temp[2],Stop_temp[2],LCD_temp2);
	Lift_controller Lift_controller_3(clk, emergency[3],Passenger_in_temp[3],Sensor3,Car_call_temp3,Hall_call_Up_temp3,Hall_call_Down_temp3,MoveUp_temp[3],MoveDown_temp[3],OpenDoor_temp[3],CloseDoor_temp[3],Stop_temp[3],LCD_temp3);
	Lift_reg Lift_reg_1(clk,Car_call_signal1,Hall_call_Up_signalout1_temp,Hall_call_Down_signalout1_temp,Sensor1,OpenDoor_temp[1],Hall_call_Up_temp1,Hall_call_Down_temp1,Car_call_temp1);
	Lift_reg Lift_reg_2(clk,Car_call_signal2,Hall_call_Up_signalout2_temp,Hall_call_Down_signalout2_temp,Sensor2,OpenDoor_temp[2],Hall_call_Up_temp2,Hall_call_Down_temp2,Car_call_temp2);
	Lift_reg Lift_reg_3(clk,Car_call_signal3,Hall_call_Up_signalout3_temp,Hall_call_Down_signalout3_temp,Sensor3,OpenDoor_temp[3],Hall_call_Up_temp3,Hall_call_Down_temp3,Car_call_temp3);
	Lift_Model Lift_Model_1(clk,MoveUp_temp[1],MoveDown_temp[1],OpenDoor_temp[1],CloseDoor_temp[1],Stop_temp[1],Sensor1,Passenger_in_temp[1]);
	Lift_Model Lift_Model_2(clk,MoveUp_temp[2],MoveDown_temp[2],OpenDoor_temp[2],CloseDoor_temp[2],Stop_temp[2],Sensor2,Passenger_in_temp[2]);
	Lift_Model Lift_Model_3(clk,MoveUp_temp[3],MoveDown_temp[3],OpenDoor_temp[3],CloseDoor_temp[3],Stop_temp[3],Sensor3,Passenger_in_temp[3]);
	assign OpenDoor = OpenDoor_temp;
	assign CloseDoor = CloseDoor_temp;
	assign MoveUp = MoveUp_temp;
	assign MoveDown = MoveDown_temp;
	assign Stop = Stop_temp;
	assign LED_HALL_UP = Hall_call_Up_temp1| Hall_call_Up_temp2| Hall_call_Up_temp3;
	assign LED_HALL_DOWN = Hall_call_Down_temp1|Hall_call_Down_temp2|Hall_call_Down_temp3;
	assign LED_Car1 = Car_call_temp1;
	assign LED_Car2 = Car_call_temp2;
	assign LED_Car3 = Car_call_temp3;
	assign LCD1 = LCD_temp1;
	assign LCD2 = LCD_temp2;
	assign LCD3 = LCD_temp3;
 endmodule
