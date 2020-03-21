`timescale 1ms/100us
module Lift_overall_tb;
	wire [3:1] MoveUp,MoveDown,OpenDoor,CloseDoor,Stop;
	wire [4:0] LED_HALL_UP;
	wire [5:1] LED_HALL_DOWN;
	wire [5:0] LED_Car1,LED_Car2,LED_Car3;
	wire [2:0] LCD1,LCD2,LCD3;
	reg clk;
	reg [3:1] emergency;
	reg [5:0] Car_call_signal1=6'b000000;
	reg [5:0] Car_call_signal2=6'b000000;
	reg [5:0] Car_call_signal3=6'b000000;
	reg [4:0] Hall_call_Up_signal=6'b00000;
	reg [5:1] Hall_call_Down_signal=6'b00000;
	
	Lift_overall DUT(clk,emergency,Car_call_signal1,Car_call_signal2,Car_call_signal3,Hall_call_Up_signal,Hall_call_Down_signal,MoveUp,MoveDown,OpenDoor,CloseDoor,Stop,LCD1,LCD2,LCD3,LED_HALL_UP,LED_HALL_DOWN,LED_Car1,LED_Car2,LED_Car3);    
	
	initial
	begin
		$dumpfile("run.vcd");
		$dumpvars(0,Lift_overall_tb);
		clk=0;
		emergency=0;
		#100
		Hall_call_Up_signal[2]=1; #60 Hall_call_Up_signal[2]=0;
		#2000 
		Car_call_signal2[4]=1; #60 Car_call_signal2[4]=0;
		#800
		Hall_call_Down_signal[5]=1;#60 Hall_call_Down_signal[5]=0; 
		#3000
		Hall_call_Up_signal[1]=1;#60 Hall_call_Up_signal[1]=0;
		#700
		Car_call_signal2[0]=1;#60 Car_call_signal2[0]=0; 
		#400
		Car_call_signal1[3]=1;#60 Car_call_signal1[3]=0;
		#100
		Hall_call_Up_signal[0]=1;#60 Hall_call_Up_signal[0]=0;
		#300
		Car_call_signal3[3]=1;#60 Car_call_signal3[3]=0;
		#10000 $finish;
	end

	always
	begin
		clk = #10 ~clk;
	end
			
	always
	begin			
		#12000 emergency[1]=1;
	end
			
		
	
     endmodule
