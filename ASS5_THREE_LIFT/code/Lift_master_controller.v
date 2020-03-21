module Lift_master_controller(clk,emergency,Sensor1,Sensor2,Sensor3,Move_Up,Move_Down,Stop,Hall_call_Up_signal,Hall_call_Down_signal,Hall_call_Up_signalout1,Hall_call_Up_signalout2,Hall_call_Up_signalout3,Hall_call_Down_signalout1,Hall_call_Down_signalout2, Hall_call_Down_signalout3);
	input clk;
	input [3:1] emergency,Move_Up,Move_Down,Stop;
	input [5:0] Sensor1,Sensor2,Sensor3;
	input [4:0] Hall_call_Up_signal;
	input [5:1] Hall_call_Down_signal;
	output reg[4:0] Hall_call_Up_signalout1=5'b00000,Hall_call_Up_signalout2=5'b00000,Hall_call_Up_signalout3=5'b00000;
	output reg [5:1] Hall_call_Down_signalout1=5'b00000, Hall_call_Down_signalout2=5'b00000, Hall_call_Down_signalout3=5'b00000;
	
	reg [5:0] a=6'b000000;
	integer b,c,d;
	reg one_near_than_two;
	reg two_near_than_three;
	reg three_near_than_one;
	reg one_is_nearest,two_is_nearest,three_is_nearest;
	
	always @ (clk,emergency,Move_Up,Move_Down,Stop,Sensor1,Sensor2,Sensor3,Hall_call_Up_signal,Hall_call_Down_signal) begin
	
	if(clk ==1'b0) begin
		a = {1'b0,Hall_call_Up_signal}|{Hall_call_Down_signal,1'b0};
		if((Sensor1|a)%9==1'b0)
			b = 3;
		else if((Sensor1|a)%33==1'b0)
			b = 5;
		else if((Sensor1|a)%3==1'b0)
			b = 1;
		else if((Sensor1|a)%5==1'b0)
			b = 2;
		else if((Sensor1|a)%17==1'b0)
			b = 4;
		else 
			b = 0;
			
		if((Sensor2|a)%9==1'b0)
			c = 3;
		else if((Sensor2|a)%33==1'b0)
			c = 5;
		else if((Sensor2|a)%3==1'b0)
			c = 1;
		else if((Sensor2|a)%5==1'b0)
			c = 2;
		else if((Sensor2|a)%17==1'b0)
			c = 4;
		else 
			c = 0;
			
		if((Sensor3|a)%9==1'b0)
			d = 3;
		else if((Sensor3|a)%33==1'b0)
			d = 5;
		else if((Sensor3|a)%3==1'b0)
			d = 1;
		else if((Sensor3|a)%5==1'b0)
			d = 2;
		else if((Sensor3|a)%17==1'b0)
			d = 4;
		else 
			d = 0;
		
	
		if(b<c)
			one_near_than_two=1'b1;
		else
			one_near_than_two=1'b0;
			
		if(d<c)
			two_near_than_three=1'b0;
		else
			two_near_than_three=1'b1;
	
		if(d<b)
			three_near_than_one=1'b1;
		else
			three_near_than_one=1'b0;
		
		if(emergency==3'b000)begin
			if((one_near_than_two==1'b1 && two_near_than_three==1'b1 && three_near_than_one==1'b0)||(one_near_than_two==1'b1 && two_near_than_three==1'b0 && three_near_than_one==1'b0))begin
				one_is_nearest = 1'b1;two_is_nearest = 1'b0;three_is_nearest = 1'b0;end
			else if((one_near_than_two==1'b1 && two_near_than_three==1'b0 && three_near_than_one==1'b1)||(one_near_than_two==1'b0 && two_near_than_three==1'b0 && three_near_than_one==1'b1))begin
				one_is_nearest = 1'b0;two_is_nearest = 1'b0;three_is_nearest = 1'b1;end
			else begin
				one_is_nearest = 1'b0;two_is_nearest = 1'b1;three_is_nearest = 1'b0;end
		end
		
		else if(emergency[1]==1'b1)begin
			two_is_nearest = two_near_than_three;
			three_is_nearest = ~ two_near_than_three;
		end
		
		else if(emergency[2]==1'b1)begin
			one_is_nearest = ~ three_near_than_one;
			three_is_nearest = three_near_than_one;
		end
		
		else if(emergency[3]==1'b1)begin
			one_is_nearest = one_near_than_two;
			two_is_nearest = ~ one_near_than_two;
		end
		
		
	end
	
	if(clk ==1'b1) begin
		if(Hall_call_Up_signal[0]==1'b1)begin	
			if((Move_Down[1]==1'b1||Stop[1]==1'b1) && one_is_nearest==1'b1 && emergency[1]==1'b0)
				 Hall_call_Up_signalout1[0] =Hall_call_Up_signal[0];
			else if((Move_Down[3]==1'b1||Stop[3]==1'b1) && three_is_nearest==1'b1 && emergency[3]==1'b0)
				 Hall_call_Up_signalout3[0] =Hall_call_Up_signal[0];
			else if((Move_Down[2]==1'b1||Stop[2]==1'b1) && two_is_nearest==1'b1 && emergency[2]==1'b0)
				 Hall_call_Up_signalout2[0] =Hall_call_Up_signal[0];
			else if((Move_Down[1]==1'b1||Stop[1]==1'b1) && emergency[1]==1'b0)
				 Hall_call_Up_signalout1[0] =Hall_call_Up_signal[0];
			else if((Move_Down[3]==1'b1||Stop[3]==1'b1) && emergency[3]==1'b0)
				 Hall_call_Up_signalout3[0] =Hall_call_Up_signal[0];
			else if(emergency[2]==1'b0)
				 Hall_call_Up_signalout2[0] =Hall_call_Up_signal[0];
		end
		else begin
			Hall_call_Up_signalout1[0] =Hall_call_Up_signal[0];
			Hall_call_Up_signalout3[0] =Hall_call_Up_signal[0];
			Hall_call_Up_signalout2[0] =Hall_call_Up_signal[0];	 
		end
	
		if(Hall_call_Up_signal[1]==1'b1)begin
			if(((Move_Down[1]==1'b1 && (Sensor1[5]==1'b1 || Sensor1[4]==1'b1|| Sensor1[3]==1'b1|| Sensor1[2]==1'b1)) || (Move_Up[1]==1'b1 && Sensor1[0]==1'b1 ))&& one_is_nearest==1'b1 && emergency[1]==1'b0)
				 Hall_call_Up_signalout1[1]=Hall_call_Up_signal[1];
			else if(((Move_Down[3]==1'b1 && (Sensor3[5]==1'b1 || Sensor3[4]==1'b1|| Sensor3[3]==1'b1|| Sensor3[2]==1'b1)) || (Move_Up[3]==1'b1 && Sensor3[0]==1'b1 ))&& three_is_nearest==1'b1 && emergency[3]==1'b0)
				 Hall_call_Up_signalout3[1]=Hall_call_Up_signal[1];
			else if(((Move_Down[2]==1'b1 && (Sensor2[5]==1'b1 || Sensor2[4]==1'b1|| Sensor2[3]==1'b1|| Sensor2[2]==1'b1)) || (Move_Up[2]==1'b1 && Sensor2[0]==1'b1 ))&& two_is_nearest==1'b1 && emergency[2]==1'b0)
				 Hall_call_Up_signalout2[1]=Hall_call_Up_signal[1];
			else if(((Move_Down[1]==1'b1 && (Sensor1[5]==1'b1 || Sensor1[4]==1'b1|| Sensor1[3]==1'b1|| Sensor1[2]==1'b1)) || (Move_Up[1]==1'b1 && Sensor1[0]==1'b1 )) && emergency[1]==1'b0)
				 Hall_call_Up_signalout1[1]=Hall_call_Up_signal[1];
			else if(((Move_Down[3]==1'b1 && (Sensor3[5]==1'b1 || Sensor3[4]==1'b1|| Sensor3[3]==1'b1|| Sensor3[2]==1'b1)) || (Move_Up[3]==1'b1 && Sensor3[0]==1'b1 )) && emergency[3]==1'b0)
				 Hall_call_Up_signalout3[1]=Hall_call_Up_signal[1];
			else if(emergency[2]==1'b0)
				 Hall_call_Up_signalout2[1]=Hall_call_Up_signal[1];
		end
		else begin
			Hall_call_Up_signalout1[1] =Hall_call_Up_signal[1];
			Hall_call_Up_signalout3[1] =Hall_call_Up_signal[1];
			Hall_call_Up_signalout2[1] =Hall_call_Up_signal[1];	 
		end

		if(Hall_call_Down_signal[1]==1'b1)begin	
			if(((Move_Down[1]==1'b1 && (Sensor1[5]==1'b1 || Sensor1[4]==1'b1|| Sensor1[3]==1'b1|| Sensor1[2]==1'b1)) || (Move_Up[1]==1'b1 && Sensor1[0]==1'b1 ))&& one_is_nearest==1'b1 && emergency[1]==1'b0)
				 Hall_call_Down_signalout1[1]=Hall_call_Down_signal[1];
			else if(((Move_Down[3]==1'b1 && (Sensor3[5]==1'b1 || Sensor3[4]==1'b1|| Sensor3[3]==1'b1|| Sensor3[2]==1'b1)) || (Move_Up[3]==1'b1 && Sensor3[0]==1'b1 ))&& three_is_nearest==1'b1 && emergency[3]==1'b0)
				 Hall_call_Down_signalout3[1]=Hall_call_Down_signal[1];
			else if(((Move_Down[2]==1'b1 && (Sensor2[5]==1'b1 || Sensor2[4]==1'b1|| Sensor2[3]==1'b1|| Sensor2[2]==1'b1)) || (Move_Up[2]==1'b1 && Sensor2[0]==1'b1 ))&& two_is_nearest==1'b1 && emergency[2]==1'b0)
				 Hall_call_Down_signalout2[1]=Hall_call_Down_signal[1];
			else if(((Move_Down[1]==1'b1 && (Sensor1[5]==1'b1 || Sensor1[4]==1'b1|| Sensor1[3]==1'b1|| Sensor1[2]==1'b1)) || (Move_Up[1]==1'b1 && Sensor1[0]==1'b1 )) && emergency[1]==1'b0)
				 Hall_call_Down_signalout1[1]=Hall_call_Down_signal[1];
			else if(((Move_Down[3]==1'b1 && (Sensor3[5]==1'b1 || Sensor3[4]==1'b1|| Sensor3[3]==1'b1|| Sensor3[2]==1'b1)) || (Move_Up[3]==1'b1 && Sensor3[0]==1'b1 )) && emergency[3]==1'b0)
				 Hall_call_Down_signalout3[1]=Hall_call_Down_signal[1];
			else if(emergency[2]==1'b0)
				 Hall_call_Down_signalout2[1]=Hall_call_Down_signal[1];
		end
		else begin
			Hall_call_Down_signalout1[1]=Hall_call_Down_signal[1];
			Hall_call_Down_signalout3[1]=Hall_call_Down_signal[1];
			Hall_call_Down_signalout2[1]=Hall_call_Down_signal[1];
		end

			

		if(Hall_call_Up_signal[2]==1'b1)begin		
			if(((Move_Down[1]==1'b1 && (Sensor1[5]==1'b1 || Sensor1[4]==1'b1 || Sensor1[3]==1'b1)) || (Move_Up[1]==1'b1 && (Sensor1[1]==1'b1 || Sensor1[0]==1'b1)))&& one_is_nearest==1'b1 && emergency[1]==1'b0)
				 Hall_call_Up_signalout1[2]=Hall_call_Up_signal[2];
			else if(((Move_Down[3]==1'b1 && (Sensor3[5]==1'b1 || Sensor3[4]==1'b1 || Sensor3[3]==1'b1)) || (Move_Up[3]==1'b1 && (Sensor3[1]==1'b1 || Sensor3[0]==1'b1)))&& three_is_nearest==1'b1 && emergency[3]==1'b0)
				 Hall_call_Up_signalout3[2]=Hall_call_Up_signal[2];
			else if(((Move_Down[2]==1'b1 && (Sensor2[5]==1'b1 || Sensor2[4]==1'b1 || Sensor2[3]==1'b1)) || (Move_Up[2]==1'b1 && (Sensor2[1]==1'b1 || Sensor2[0]==1'b1)))&& two_is_nearest==1'b1 && emergency[2]==1'b0)
				Hall_call_Up_signalout2[2]=Hall_call_Up_signal[2];
			else if(((Move_Down[1]==1'b1 && (Sensor1[5]==1'b1 || Sensor1[4]==1'b1 || Sensor1[3]==1'b1)) || (Move_Up[1]==1'b1 && (Sensor1[1]==1'b1 || Sensor1[0]==1'b1))) && emergency[1]==1'b0)
				 Hall_call_Up_signalout1[2]=Hall_call_Up_signal[2];
			else if(((Move_Down[3]==1'b1 && (Sensor3[5]==1'b1 || Sensor3[4]==1'b1 || Sensor3[3]==1'b1)) || (Move_Up[3]==1'b1 && (Sensor3[1]==1'b1 || Sensor3[0]==1'b1))) && emergency[3]==1'b0)
				 Hall_call_Up_signalout3[2]=Hall_call_Up_signal[2];
			else if(emergency[2]==1'b0)
				Hall_call_Up_signalout2[2]=Hall_call_Up_signal[2];
		end
		else begin
			Hall_call_Up_signalout1[2]=Hall_call_Up_signal[2];
			Hall_call_Up_signalout3[2]=Hall_call_Up_signal[2];
			Hall_call_Up_signalout2[2]=Hall_call_Up_signal[2];
		end

		if(Hall_call_Down_signal[2]==1'b1)begin	
			if(((Move_Down[1]==1'b1 && (Sensor1[5]==1'b1 || Sensor1[4]==1'b1 || Sensor1[3]==1'b1)) || (Move_Up[1]==1'b1 && (Sensor1[1]==1'b1 || Sensor1[0]==1'b1)))&& one_is_nearest==1'b1 && emergency[1]==1'b0)
				 Hall_call_Down_signalout1[2]=Hall_call_Down_signal[2];
			else if(((Move_Down[3]==1'b1 && (Sensor3[5]==1'b1 || Sensor3[4]==1'b1 || Sensor3[3]==1'b1)) || (Move_Up[3]==1'b1 && (Sensor3[1]==1'b1 || Sensor3[0]==1'b1)))&& three_is_nearest==1'b1 && emergency[3]==1'b0)
				 Hall_call_Down_signalout3[2]=Hall_call_Down_signal[2];
			else if(((Move_Down[2]==1'b1 && (Sensor2[5]==1'b1 || Sensor2[4]==1'b1 || Sensor2[3]==1'b1)) || (Move_Up[2]==1'b1 && (Sensor2[1]==1'b1 || Sensor2[0]==1'b1)))&& two_is_nearest==1'b1 &&emergency[2]==1'b0)
				Hall_call_Down_signalout2[2]=Hall_call_Down_signal[2];
			else if(((Move_Down[1]==1'b1 && (Sensor1[5]==1'b1 || Sensor1[4]==1'b1 || Sensor1[3]==1'b1)) || (Move_Up[1]==1'b1 && (Sensor1[1]==1'b1 || Sensor1[0]==1'b1))) && emergency[1]==1'b0)
				 Hall_call_Down_signalout1[2]=Hall_call_Down_signal[2];
			else if(((Move_Down[3]==1'b1 && (Sensor3[5]==1'b1 || Sensor3[4]==1'b1 || Sensor3[3]==1'b1)) || (Move_Up[3]==1'b1 && (Sensor3[1]==1'b1 || Sensor3[0]==1'b1))) && emergency[3]==1'b0)
				 Hall_call_Down_signalout3[2]=Hall_call_Down_signal[2];
			else if(emergency[2]==1'b0)
				Hall_call_Down_signalout2[2]=Hall_call_Down_signal[2];
		end
		else begin
			Hall_call_Down_signalout1[2]=Hall_call_Down_signal[2];
			Hall_call_Down_signalout3[2]=Hall_call_Down_signal[2];
			Hall_call_Down_signalout2[2]=Hall_call_Down_signal[2];
		end

		if(Hall_call_Up_signal[3]==1'b1)begin	
			if(((Move_Down[1]==1'b1 && (Sensor1[5]==1'b1 || Sensor1[4]==1'b1)) || (Move_Up[1]==1'b1 && (Sensor1[2]==1'b1 || Sensor1[1]==1'b1|| Sensor1[0]==1'b1)))&& one_is_nearest==1'b1 && emergency[1]==1'b0)
				 Hall_call_Up_signalout1[3]=Hall_call_Up_signal[3];
			else if(((Move_Down[3]==1'b1 && (Sensor3[5]==1'b1 || Sensor3[4]==1'b1)) || (Move_Up[3]==1'b1 && (Sensor3[2]==1'b1 || Sensor3[1]==1'b1|| Sensor3[0]==1'b1)))&& three_is_nearest==1'b1 && emergency[3]==1'b0)
				 Hall_call_Up_signalout3[3]=Hall_call_Up_signal[3];
			else if(((Move_Down[2]==1'b1 && (Sensor2[5]==1'b1 || Sensor2[4]==1'b1)) || (Move_Up[2]==1'b1 && (Sensor2[2]==1'b1 || Sensor2[1]==1'b1|| Sensor2[0]==1'b1)))&& two_is_nearest==1'b1 &&emergency[2]==1'b0)
				 Hall_call_Up_signalout2[3]=Hall_call_Up_signal[3];
			else if(((Move_Down[1]==1'b1 && (Sensor1[5]==1'b1 || Sensor1[4]==1'b1)) || (Move_Up[1]==1'b1 && (Sensor1[2]==1'b1 || Sensor1[1]==1'b1|| Sensor1[0]==1'b1)))&& emergency[1]==1'b0)
				 Hall_call_Up_signalout1[3]=Hall_call_Up_signal[3];
			else if(((Move_Down[3]==1'b1 && (Sensor3[5]==1'b1 || Sensor3[4]==1'b1)) || (Move_Up[3]==1'b1 && (Sensor3[2]==1'b1 || Sensor3[1]==1'b1|| Sensor3[0]==1'b1))) && emergency[3]==1'b0)
				 Hall_call_Up_signalout3[3]=Hall_call_Up_signal[3];
			else if(emergency[2]==1'b0)
				 Hall_call_Up_signalout2[3]=Hall_call_Up_signal[3];
		end
		else begin
			Hall_call_Up_signalout1[3]=Hall_call_Up_signal[3];
			Hall_call_Up_signalout3[3]=Hall_call_Up_signal[3];
			Hall_call_Up_signalout2[3]=Hall_call_Up_signal[3];
		end
	
		if(Hall_call_Down_signal[3]==1'b1)begin
			if(((Move_Down[1]==1'b1 && (Sensor1[5]==1'b1 || Sensor1[4]==1'b1)) || (Move_Up[1]==1'b1 && (Sensor1[2]==1'b1 || Sensor1[1]==1'b1|| Sensor1[0]==1'b1)))&& one_is_nearest==1'b1 && emergency[1]==1'b0)
				 Hall_call_Down_signalout1[3]=Hall_call_Down_signal[3];
			else if(((Move_Down[3]==1'b1 && (Sensor3[5]==1'b1 || Sensor3[4]==1'b1)) || (Move_Up[3]==1'b1 && (Sensor3[2]==1'b1 || Sensor3[1]==1'b1|| Sensor3[0]==1'b1)))&& three_is_nearest==1'b1 && emergency[3]==1'b0)
				 Hall_call_Down_signalout3[3]=Hall_call_Down_signal[3];
			else if(((Move_Down[2]==1'b1 && (Sensor2[5]==1'b1 || Sensor2[4]==1'b1)) || (Move_Up[2]==1'b1 && (Sensor2[2]==1'b1 || Sensor2[1]==1'b1|| Sensor2[0]==1'b1)))&& two_is_nearest==1'b1 && emergency[2]==1'b0)
				 Hall_call_Down_signalout2[3]=Hall_call_Down_signal[3];
			else if(((Move_Down[1]==1'b1 && (Sensor1[5]==1'b1 || Sensor1[4]==1'b1)) || (Move_Up[1]==1'b1 && (Sensor1[2]==1'b1 || Sensor1[1]==1'b1|| Sensor1[0]==1'b1))) && emergency[1]==1'b0)
				 Hall_call_Down_signalout1[3]=Hall_call_Down_signal[3];
			else if(((Move_Down[3]==1'b1 && (Sensor3[5]==1'b1 || Sensor3[4]==1'b1)) || (Move_Up[3]==1'b1 && (Sensor3[2]==1'b1 || Sensor3[1]==1'b1|| Sensor3[0]==1'b1))) && emergency[3]==1'b0)
				 Hall_call_Down_signalout3[3]=Hall_call_Down_signal[3];
			else if(emergency[2]==1'b0)
				 Hall_call_Down_signalout2[3]=Hall_call_Down_signal[3];
		end
		else begin
			Hall_call_Down_signalout1[3]=Hall_call_Down_signal[3];
			Hall_call_Down_signalout3[3]=Hall_call_Down_signal[3];
			Hall_call_Down_signalout2[3]=Hall_call_Down_signal[3];
		end
		
		if(Hall_call_Up_signal[4]==1'b1)begin	
			if(((Move_Down[1]==1'b1 && Sensor1[5]==1'b1 ) || (Move_Up[1]==1'b1 && (Sensor1[3]==1'b1 || Sensor1[2]==1'b1 || Sensor1[1]==1'b1|| Sensor1[0]==1'b1)))&& one_is_nearest==1'b1 && emergency[1]==1'b0)
				 Hall_call_Up_signalout1[4]=Hall_call_Up_signal[4];
			else if(((Move_Down[3]==1'b1 && Sensor3[5]==1'b1 ) || (Move_Up[3]==1'b1 && (Sensor3[3]==1'b1 || Sensor3[2]==1'b1 || Sensor3[1]==1'b1|| Sensor3[0]==1'b1)))&& three_is_nearest==1'b1 && emergency[3]==1'b0)
				 Hall_call_Up_signalout3[4]=Hall_call_Up_signal[4];
			else if(((Move_Down[2]==1'b1 && Sensor2[5]==1'b1 ) || (Move_Up[2]==1'b1 && (Sensor2[3]==1'b1 || Sensor2[2]==1'b1 || Sensor2[1]==1'b1|| Sensor2[0]==1'b1)))&& two_is_nearest==1'b1 &&emergency[2]==1'b0)
				 Hall_call_Up_signalout2[4]=Hall_call_Up_signal[4];
			else if(((Move_Down[1]==1'b1 && Sensor1[5]==1'b1 ) || (Move_Up[1]==1'b1 && (Sensor1[3]==1'b1 || Sensor1[2]==1'b1 || Sensor1[1]==1'b1|| Sensor1[0]==1'b1))) && emergency[1]==1'b0)
				 Hall_call_Up_signalout1[4]=Hall_call_Up_signal[4];
			else if(((Move_Down[3]==1'b1 && Sensor3[5]==1'b1 ) || (Move_Up[3]==1'b1 && (Sensor3[3]==1'b1 || Sensor3[2]==1'b1 || Sensor3[1]==1'b1|| Sensor3[0]==1'b1))) && emergency[3]==1'b0)
				 Hall_call_Up_signalout3[4]=Hall_call_Up_signal[4];
			else if(emergency[2]==1'b0)
				 Hall_call_Up_signalout2[4]=Hall_call_Up_signal[4];
		end
		else begin
			Hall_call_Up_signalout1[4]=Hall_call_Up_signal[4];
			Hall_call_Up_signalout3[4]=Hall_call_Up_signal[4];
			Hall_call_Up_signalout2[4]=Hall_call_Up_signal[4];
		end
			
		if(Hall_call_Down_signal[4]==1'b1)begin
			if(((Move_Down[1]==1'b1 && Sensor1[5]==1'b1 ) || (Move_Up[1]==1'b1 && (Sensor1[3]==1'b1 || Sensor1[2]==1'b1 || Sensor1[1]==1'b1|| Sensor1[0]==1'b1)))&& one_is_nearest==1'b1 && emergency[1]==1'b0)
				 Hall_call_Down_signalout1[4]=Hall_call_Down_signal[4];
			else if(((Move_Down[3]==1'b1 && Sensor3[5]==1'b1 ) || (Move_Up[3]==1'b1 && (Sensor3[3]==1'b1 || Sensor3[2]==1'b1 || Sensor3[1]==1'b1|| Sensor3[0]==1'b1)))&& three_is_nearest==1'b1 && emergency[3]==1'b0)
				 Hall_call_Down_signalout3[4]=Hall_call_Down_signal[4];
			else if(((Move_Down[2]==1'b1 && Sensor2[5]==1'b1 ) || (Move_Up[2]==1'b1 && (Sensor2[3]==1'b1 || Sensor2[2]==1'b1 || Sensor2[1]==1'b1|| Sensor2[0]==1'b1)))&& two_is_nearest==1'b1 &&emergency[2]==1'b0)
				 Hall_call_Down_signalout2[4]=Hall_call_Down_signal[4];
			else if(((Move_Down[1]==1'b1 && Sensor1[5]==1'b1 ) || (Move_Up[1]==1'b1 && (Sensor1[3]==1'b1 || Sensor1[2]==1'b1 || Sensor1[1]==1'b1|| Sensor1[0]==1'b1))) && emergency[1]==1'b0)
				 Hall_call_Down_signalout1[4]=Hall_call_Down_signal[4];
			else if(((Move_Down[3]==1'b1 && Sensor3[5]==1'b1 ) || (Move_Up[3]==1'b1 && (Sensor3[3]==1'b1 || Sensor3[2]==1'b1 || Sensor3[1]==1'b1|| Sensor3[0]==1'b1))) && emergency[3]==1'b0)
				 Hall_call_Down_signalout3[4]=Hall_call_Down_signal[4];
			else if(emergency[2]==1'b0)
				 Hall_call_Down_signalout2[4]=Hall_call_Down_signal[4];
		end
		else begin
			Hall_call_Down_signalout1[4]=Hall_call_Down_signal[4];
			Hall_call_Down_signalout3[4]=Hall_call_Down_signal[4];
			Hall_call_Down_signalout2[4]=Hall_call_Down_signal[4];
		end

		if(Hall_call_Down_signal[5]==1'b1)begin
			if((Move_Up[1]==1'b1||Stop==1'b1) && one_is_nearest==1'b1 && emergency[1]==1'b0)
				 Hall_call_Down_signalout1[5]=Hall_call_Down_signal[5];
			else if((Move_Up[3]==1'b1||Stop==1'b1) && three_is_nearest==1'b1 && emergency[3]==1'b0)
				 Hall_call_Down_signalout3[5]=Hall_call_Down_signal[5];
			else if((Move_Up[2]==1'b1||Stop==1'b1) && two_is_nearest==1'b1 && emergency[2]==1'b0)
				 Hall_call_Down_signalout2[5]=Hall_call_Down_signal[5];
			else if((Move_Up[1]==1'b1||Stop==1'b1)  && emergency[1]==1'b0)
				 Hall_call_Down_signalout1[5]=Hall_call_Down_signal[5];
			else if((Move_Up[3]==1'b1||Stop==1'b1)  && emergency[3]==1'b0)
				 Hall_call_Down_signalout3[5]=Hall_call_Down_signal[5];
			else if(emergency[2]==1'b0)
				 Hall_call_Down_signalout2[5]=Hall_call_Down_signal[5];
		end
		else begin
			Hall_call_Down_signalout1[5]=Hall_call_Down_signal[5];
			Hall_call_Down_signalout3[5]=Hall_call_Down_signal[5];
			Hall_call_Down_signalout2[5]=Hall_call_Down_signal[5];
		end
	end
	end
  endmodule