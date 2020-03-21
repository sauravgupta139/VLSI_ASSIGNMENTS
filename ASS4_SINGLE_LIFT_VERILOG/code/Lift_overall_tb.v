`timescale 1ms/100us
module Lift_overall_tb;
	wire MoveUp,MoveDown,OpenDoor,CloseDoor,Stop;
	wire [4:0] LED_HALL_UP;
	wire [5:1] LED_HALL_DOWN;
	wire [5:0] LED_Car;
	wire [2:0] LCD;
	reg clk,reset;
	reg [5:0] Car_call_signal=6'b000000;
	reg [4:0] Hall_call_Up_signal=6'b00000;
	reg [5:1] Hall_call_Down_signal=6'b00000;
	
	Lift_overall DUT(clk,reset,Car_call_signal,Hall_call_Up_signal,Hall_call_Down_signal,MoveUp,MoveDown,OpenDoor,CloseDoor,Stop,LCD,LED_HALL_UP,LED_HALL_DOWN,LED_Car);     
	
	initial
	begin
		$dumpfile("run.vcd");
		$dumpvars(0,Lift_overall_tb);
		clk=0;
		reset=0;
		Hall_call_Up_signal[2]=1; #600 Hall_call_Up_signal[2]=0;
		#2000 
		Car_call_signal[4]=1; #600 Car_call_signal[4]=0;
		#800
		Hall_call_Down_signal[5]=1;#600 Hall_call_Down_signal[5]=0; 
		#3000 
		Car_call_signal[0]=1;#600 Car_call_signal[0]=0; 
		#400
		Hall_call_Up_signal[3]=1;#600 Hall_call_Up_signal[3]=0;
		#10000 $finish;
	end

	always
	begin
		clk = #10 ~clk;
	end
			
	always
	begin			
		#19000 reset=1;
	end
			
		
	
     endmodule
