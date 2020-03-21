
module Lift_controller(clk,reset,Passenger_in,Sensor,Car_call,Hall_call_Up,Hall_call_Down,MoveUp,MoveDown,OpenDoor,CloseDoor,Stop,LCD);
	input clk,reset,Passenger_in;
	input [5:0] Sensor,Car_call;
	input [4:0] Hall_call_Up;
	input [5:1] Hall_call_Down;
	output reg MoveUp,MoveDown,OpenDoor,CloseDoor,Stop;
	output reg [2:0] LCD;
 
	parameter s_0_stop = 0,s_0_open =1,s_01_Up=2,s_10_Down=3,s_1_stopU =4,s_1_stopD =5,s_1_openU =6,s_1_openD=7,s_12_Up =8,s_21_Down =9,s_2_stopU =10,s_2_stopD =11,s_2_openU=12,s_2_openD =13,s_23_Up =14,s_32_Down =15,s_3_stopU =16,s_3_stopD =17,s_3_openU =18,s_3_openD =19,s_34_Up =20,s_43_Down =21,s_4_stopU =22,s_4_stopD =23,s_4_openU =24,s_4_openD= 25,s_45_Up =26,s_54_Down =27,s_5_stop =28,s_5_open =29;
   	reg[0:5] state_signal, next_state_var;
  
	always @(reset,Sensor,Hall_call_Up,Hall_call_Down,Car_call,Passenger_in,state_signal)
   	begin
      	case(state_signal)
		s_0_stop: begin
			 if(reset ==1'b1 || Hall_call_Up[0]==1'b1 || Car_call[0]==1'b1)
				next_state_var = s_0_open;
			 else if (Hall_call_Down[1]==1'b1 || Hall_call_Up[1]==1'b1 || Car_call[1]==1'b1 || Hall_call_Down[2]==1'b1 || Hall_call_Up[2]==1'b1 || Car_call[2]==1'b1 || Hall_call_Down[3]==1'b1|| Hall_call_Up[3]==1'b1 || Car_call[3]==1'b1 || Hall_call_Down[4]==1'b1|| Hall_call_Up[4]==1'b1 || Car_call[4]==1'b1 || Hall_call_Down[5]==1'b1 || Car_call[5]==1'b1)
					next_state_var = s_01_Up;
			 end
		  
		s_0_open: begin
			  if(reset ==1'b1)
				next_state_var = s_0_open;
			  else
				if(Passenger_in ==1'b1)
					next_state_var = s_0_stop;
			  end
		
		s_01_Up: begin
			if(Sensor[1]==1'b1 && (Car_call[1]==1'b1 || Hall_call_Up[1]==1'b1 || reset==1'b1))
				next_state_var = s_1_stopU;
			else if(Sensor[1]==1'b1 && (Hall_call_Down[2]==1'b1 || Hall_call_Up[2]==1'b1 || Car_call[2]==1'b1 || Hall_call_Down[3]==1'b1|| Hall_call_Up[3]==1'b1 || Car_call[3]==1'b1 || Hall_call_Down[4]==1'b1|| Hall_call_Up[4]==1'b1 || Car_call[4]==1'b1 || Hall_call_Down[5]==1'b1 || Car_call[5]==1'b1 ))
				next_state_var = s_12_Up;
			else if(Sensor[1]==1'b1)
				next_state_var = s_1_stopU;
			end
		s_10_Down: begin
			if(Sensor[0]==1'b1)
				next_state_var = s_0_stop;
			end
		  
		s_1_stopU: begin
			if(reset ==1'b1 || Car_call[1]==1'b1 || Hall_call_Down[1]==1'b1 || Hall_call_Up[1]==1'b1)
				next_state_var = s_1_openU;
			else if (Hall_call_Down[2]==1'b1 || Hall_call_Up[2]==1'b1 || Car_call[2]==1'b1 || Hall_call_Down[3]==1'b1|| Hall_call_Up[3]==1'b1 || Car_call[3]==1'b1 || Hall_call_Down[4]==1'b1|| Hall_call_Up[4]==1'b1 || Car_call[4]==1'b1|| Hall_call_Down[5]==1'b1 || Car_call[5]==1'b1)
				next_state_var = s_12_Up;
			else if (Hall_call_Up[0]==1'b1)
				next_state_var = s_10_Down;
			end
		
		s_1_stopD: begin
			if(reset ==1'b1 || Car_call[1]==1'b1 || Hall_call_Down[1]==1'b1 || Hall_call_Up[1]==1'b1)
				next_state_var = s_1_openD;
			else if (Hall_call_Up[0]==1'b1)
				next_state_var = s_10_Down;
			else if (Hall_call_Down[2]==1'b1 || Hall_call_Up[2]==1'b1 || Car_call[2]==1'b1 || Hall_call_Down[3]==1'b1|| Hall_call_Up[3]==1'b1 || Car_call[3]==1'b1 || Hall_call_Down[4]==1'b1|| Hall_call_Up[4]==1'b1 || Car_call[4]==1'b1|| Hall_call_Down[5]==1'b1 || Car_call[5]==1'b1)
				next_state_var = s_12_Up;
			end
		  
		s_1_openU: begin
			if(reset ==1'b1)
				next_state_var = s_1_openU;
			else
				if(Passenger_in ==1'b1)
					next_state_var = s_1_stopU;
			end
			
		 s_1_openD: begin
			if(reset ==1'b1)
				next_state_var = s_1_openD;
			else
				if(Passenger_in ==1'b1)
					next_state_var = s_1_stopD;
			end
		
		 s_12_Up: begin
			if(Sensor[2]==1'b1 && (Hall_call_Up[2]==1'b1 || Car_call[2]==1'b1 || reset==1'b1))
				next_state_var = s_2_stopU;
			else if(Sensor[2]==1'b1 && (Hall_call_Down[3]==1'b1|| Hall_call_Up[3]==1'b1 || Car_call[3]==1'b1 || Hall_call_Down[4]==1'b1|| Hall_call_Up[4]==1'b1 || Car_call[4]==1'b1 || Hall_call_Down[5]==1'b1 || Car_call[5]==1'b1 ))
				next_state_var = s_23_Up;
			else if(Sensor[2]==1'b1)
				next_state_var = s_2_stopU;
			end
		  
		 s_21_Down: begin
			if(Sensor[1]==1'b1 && (Hall_call_Down[1]==1'b1 || Car_call[1]==1'b1 || reset==1'b1))
				next_state_var = s_1_stopD;
			else if(Sensor[1]==1'b1 && (Hall_call_Up[0]==1'b1 || Car_call[0]==1'b1))
				next_state_var = s_10_Down;
			else if(Sensor[1]==1'b1)
				next_state_var = s_1_stopD;
			end
		  
		 s_2_stopU: begin
			if(reset ==1'b1 || Hall_call_Down[2]==1'b1 || Hall_call_Up[2]==1'b1 || Car_call[2]==1'b1)
				next_state_var = s_2_openU;
			else if (Hall_call_Down[3]==1'b1|| Hall_call_Up[3]==1'b1 || Car_call[3]==1'b1 || Hall_call_Down[4]==1'b1|| Hall_call_Up[4]==1'b1 || Car_call[4]==1'b1 || Hall_call_Down[5]==1'b1 || Car_call[5]==1'b1)
				next_state_var = s_23_Up;	
			else if (Hall_call_Up[0]==1'b1 || Car_call[0]==1'b1 || Hall_call_Down[1]==1'b1|| Hall_call_Up[1]==1'b1 || Car_call[1]==1'b1)
				next_state_var = s_21_Down;
			end
		
		 s_2_stopD: begin
			if(reset ==1'b1 || Hall_call_Down[2]==1'b1 || Hall_call_Up[2]==1'b1 || Car_call[2]==1'b1)
				next_state_var = s_2_openD;
			else if (Hall_call_Up[0]==1'b1 || Car_call[0]==1'b1 || Hall_call_Down[1]==1'b1|| Hall_call_Up[1]==1'b1 || Car_call[1]==1'b1)
				next_state_var = s_21_Down;
			else if (Hall_call_Down[3]==1'b1|| Hall_call_Up[3]==1'b1 || Car_call[3]==1'b1 || Hall_call_Down[4]==1'b1|| Hall_call_Up[4]==1'b1 || Car_call[4]==1'b1 || Hall_call_Down[5]==1'b1 || Car_call[5]==1'b1)
				next_state_var = s_23_Up;	
			end
		  
		 s_2_openU: begin
			if(reset ==1'b1)
				next_state_var = s_2_openU;
			else
				if(Passenger_in ==1'b1)
					next_state_var = s_2_stopU;
			end
			
		 s_2_openD: begin
			if(reset ==1'b1)
				next_state_var = s_2_openD;
			else
				if(Passenger_in ==1'b1)
					next_state_var = s_2_stopD;
			end
		
		 s_23_Up: begin
			if(Sensor[3]==1'b1 && (Hall_call_Up[3]==1'b1 || Car_call[3]==1'b1 || reset==1'b1))
				next_state_var = s_3_stopU;
			else if(Sensor[3]==1'b1 &&  (Hall_call_Down[4]==1'b1|| Hall_call_Up[4]==1'b1 || Car_call[4]==1'b1 || Hall_call_Down[5]==1'b1 || Car_call[5]==1'b1 ))
				next_state_var = s_34_Up;
			else if(Sensor[3]==1'b1)
				next_state_var = s_3_stopU;
			end
		  
		 s_32_Down: begin
			if(Sensor[2]==1'b1 && (Hall_call_Down[2]==1'b1 || Car_call[2]==1'b1 || reset==1'b1))
				next_state_var = s_2_stopD;
			else if(Sensor[2]==1'b1 &&(Hall_call_Up[0]==1'b1 || Car_call[0]==1'b1 || Hall_call_Down[1]==1'b1|| Hall_call_Up[1]==1'b1 || Car_call[1]==1'b1))
				next_state_var = s_21_Down;
			else if(Sensor[2]==1'b1)
				next_state_var = s_2_stopD;
			end
		  
		 s_3_stopU: begin
			if(reset ==1'b1 || Hall_call_Down[3]==1'b1 || Hall_call_Up[3]==1'b1 || Car_call[3]==1'b1)
				next_state_var = s_3_openU;
			else if (Hall_call_Down[4]==1'b1|| Hall_call_Up[4]==1'b1 || Car_call[4]==1'b1 || Hall_call_Down[5]==1'b1  || Car_call[5]==1'b1)
				next_state_var = s_34_Up;
			else if (Hall_call_Up[0]==1'b1 || Car_call[0]==1'b1 || Hall_call_Down[1]==1'b1 || Hall_call_Up[1]==1'b1 || Car_call[1]==1'b1 || Hall_call_Down[2]==1'b1 || Hall_call_Up[2]==1'b1 || Car_call[2]==1'b1)
				next_state_var = s_32_Down;				
			end
		
		 s_3_stopD: begin
			if(reset ==1'b1 || Hall_call_Down[3]==1'b1 || Hall_call_Up[3]==1'b1 || Car_call[3]==1'b1)
				next_state_var = s_3_openU;
			else if (Hall_call_Up[0]==1'b1 || Car_call[0]==1'b1 || Hall_call_Down[1]==1'b1 || Hall_call_Up[1]==1'b1 || Car_call[1]==1'b1 || Hall_call_Down[2]==1'b1 || Hall_call_Up[2]==1'b1 || Car_call[2]==1'b1)
				next_state_var = s_32_Down;
			else if (Hall_call_Down[4]==1'b1|| Hall_call_Up[4]==1'b1 || Car_call[4]==1'b1 || Hall_call_Down[5]==1'b1  || Car_call[5]==1'b1)
				next_state_var = s_34_Up;				
			end		
		  
		 s_3_openU: begin
			if(reset ==1'b1)
				next_state_var = s_3_openU;
			else
				if(Passenger_in ==1'b1)
					next_state_var = s_3_stopU;
			end
			
		 s_3_openD: begin
			if(reset ==1'b1)
				next_state_var = s_3_openD;
			else
				if(Passenger_in ==1'b1)
					next_state_var = s_3_stopD;
			end
		
		 s_34_Up: begin
			if(Sensor[4]==1'b1 && (Hall_call_Up[4]==1'b1 || Car_call[4]==1'b1 || reset==1'b1))
				next_state_var = s_4_stopU;
			else if(Sensor[4]==1'b1 && (Hall_call_Down[5]==1'b1 || Car_call[5]==1'b1))
				next_state_var = s_45_Up;
			else if(Sensor[4]==1'b1)
				next_state_var = s_4_stopU;
			end
		  
		 s_43_Down: begin
			if(Sensor[3]==1'b1 && (Hall_call_Down[3]==1'b1 || Car_call[3]==1'b1 || reset==1'b1))
				next_state_var = s_3_stopD;
			else if(Sensor[3]==1'b1 && (Hall_call_Up[0]==1'b1 || Car_call[0]==1'b1 || Hall_call_Down[1]==1'b1|| Hall_call_Up[1]==1'b1 || Car_call[1]==1'b1 || Hall_call_Down[2]==1'b1 || Hall_call_Up[2]==1'b1 || Car_call[2]==1'b1))
				next_state_var = s_32_Down;
			else if(Sensor[3]==1'b1)
				next_state_var = s_3_stopD;
			end
		  
		 s_4_stopU: begin
			if(reset ==1'b1 || Hall_call_Down[4]==1'b1 || Hall_call_Up[4]==1'b1 || Car_call[4]==1'b1)
				next_state_var = s_4_openU;
			else if (Hall_call_Down[5]==1'b1 || Car_call[5]==1'b1)
				next_state_var = s_45_Up;
			else if (Hall_call_Up[0]==1'b1 || Car_call[0]==1'b1|| Hall_call_Down[1]==1'b1|| Hall_call_Up[1]==1'b1 || Car_call[1]==1'b1 || Hall_call_Down[2]==1'b1 || Hall_call_Up[2]==1'b1 || Car_call[2]==1'b1|| Hall_call_Down[3]==1'b1 || Hall_call_Up[3]==1'b1 || Car_call[3]==1'b1)
				next_state_var = s_43_Down;				
			end
			
		 s_4_stopD: begin
			if(reset ==1'b1 || Hall_call_Down[4]==1'b1 || Hall_call_Up[4]==1'b1 || Car_call[4]==1'b1)
				next_state_var = s_4_openD;
			else if (Hall_call_Up[0]==1'b1 || Car_call[0]==1'b1|| Hall_call_Down[1]==1'b1|| Hall_call_Up[1]==1'b1 || Car_call[1]==1'b1 || Hall_call_Down[2]==1'b1 || Hall_call_Up[2]==1'b1 || Car_call[2]==1'b1|| Hall_call_Down[3]==1'b1 || Hall_call_Up[3]==1'b1 || Car_call[3]==1'b1)
				next_state_var = s_43_Down;
			else if (Hall_call_Down[5]==1'b1 || Car_call[5]==1'b1)
				next_state_var = s_45_Up;				
			end
		  
		 s_4_openU: begin
			if(reset ==1'b1)
				next_state_var = s_4_openU;
			else
				if(Passenger_in ==1'b1)
					next_state_var = s_4_stopU;
			end
			
		 s_4_openD: begin
			if(reset ==1'b1)
				next_state_var = s_4_openD;
			else
				if(Passenger_in ==1'b1)
					next_state_var = s_4_stopD;
			end
		
		 s_45_Up: begin
			if(Sensor[5]==1'b1)
				next_state_var = s_5_stop;
			end
		  
		 s_54_Down: begin
			if(Sensor[4]==1'b1 && (Hall_call_Down[4]==1'b1 || Car_call[4]==1'b1 || reset==1'b1))
				next_state_var = s_4_stopD;
			else if(Sensor[4]==1'b1 && (Hall_call_Up[0]==1'b1 || Car_call[0]==1'b1 || Hall_call_Down[1]==1'b1|| Hall_call_Up[1]==1'b1 || Car_call[1]==1'b1 || Hall_call_Down[2]==1'b1 || Hall_call_Up[2]==1'b1 || Car_call[2]==1'b1 || Hall_call_Down[3]==1'b1 || Hall_call_Up[3]==1'b1 || Car_call[3]==1'b1 ))
				next_state_var = s_43_Down;
			else if(Sensor[4]==1'b1)
				next_state_var = s_4_stopD;
			end
		  
		 s_5_stop: begin
			if(reset ==1'b1 || Hall_call_Down[5]==1'b1 || Car_call[5]==1'b1)
				next_state_var = s_5_open;
			else if (Hall_call_Up[0]==1'b1 || Car_call[0]==1'b1 || Hall_call_Down[1]==1'b1|| Hall_call_Up[1]==1'b1 || Car_call[1]==1'b1 || Hall_call_Down[2]==1'b1 || Hall_call_Up[2]==1'b1 || Car_call[2]==1'b1 || Hall_call_Down[3]==1'b1 || Hall_call_Up[3]==1'b1 || Car_call[3]==1'b1 || Hall_call_Down[4]==1'b1 || Hall_call_Up[4]==1'b1 || Car_call[4]==1'b1)
				next_state_var = s_54_Down;				
			end
		  
		 s_5_open: begin
			if(reset ==1'b1)
				next_state_var = s_5_open;
			else
				if(Passenger_in ==1'b1)
					next_state_var = s_5_stop;
			end

         	default : begin 
			next_state_var = s_0_stop;
			end
      endcase
	end
	always @(posedge clk)
      		state_signal <= next_state_var;
      


    always @(state_signal)
    begin      
      case(state_signal)
         s_0_stop: begin
			MoveUp <= 1'b0;
			MoveDown <= 1'b0;
			OpenDoor <= 1'b0;
			CloseDoor <=1'b1;
			Stop <=1'b1;
			LCD <= 3'b000;
		end

         s_0_open: begin
			MoveUp <= 1'b0;
			MoveDown <= 1'b0;
			OpenDoor <=1'b1;
			CloseDoor <= 1'b0;
			Stop <=1'b1;
			LCD<=3'b000;
		end
		
         s_01_Up: begin
			MoveUp <=1'b1;
			MoveDown <= 1'b0;
			OpenDoor <= 1'b0;
			CloseDoor <=1'b1;
			Stop <=1'b0;
			LCD<= 3'b000;
		end
			
	s_10_Down: begin
			MoveUp <= 1'b0;
			MoveDown <=1'b1;
			OpenDoor <= 1'b0;
			CloseDoor <=1'b1;
			Stop <=1'b0;
			LCD<= 3'b001;
		end
			
	s_1_stopU: begin
			MoveUp <= 1'b0;
			MoveDown <= 1'b0;
			OpenDoor <= 1'b0;
			CloseDoor <=1'b1;
			Stop <=1'b1;
			LCD<=3'b001;
		end
			
	s_1_stopD: begin
			MoveUp <= 1'b0;
			MoveDown <= 1'b0;
			OpenDoor <= 1'b0;
			CloseDoor <=1'b1;
			Stop <=1'b1;
			LCD<= 3'b001;
		end
        
         s_1_openU: begin
			MoveUp <= 1'b0;
			MoveDown <= 1'b0;
			OpenDoor <=1'b1;
			CloseDoor <= 1'b0;
			Stop <=1'b1;
			LCD<= 3'b001;
		end
		
	s_1_openD: begin
			MoveUp <= 1'b0;
			MoveDown <= 1'b0;
			OpenDoor <=1'b1;
			CloseDoor <= 1'b0;
			Stop <=1'b1;
			LCD<=3'b001;
		end
		
         s_12_Up: begin
			MoveUp <=1'b1;
			MoveDown <= 1'b0;
			OpenDoor <= 1'b0;
			CloseDoor <=1'b1;
			Stop <=1'b0;
			LCD<= 3'b001;
		end
			
	s_21_Down: begin
			MoveUp <= 1'b0;
			MoveDown <=1'b1;
			OpenDoor <= 1'b0;
			CloseDoor <=1'b1;
			Stop <=1'b0;
			LCD<= 3'b010;
		end
			
	s_2_stopU: begin
			MoveUp <= 1'b0;
			MoveDown <= 1'b0;
			OpenDoor <= 1'b0;
			CloseDoor <=1'b1;
			Stop <=1'b1;
			LCD<= 3'b010;
		end
			
	s_2_stopD: begin
			MoveUp <= 1'b0;
			MoveDown <= 1'b0;
			OpenDoor <= 1'b0;
			CloseDoor <=1'b1;
			Stop <=1'b1;
			LCD<= 3'b010;
		end
        
         s_2_openU: begin
			MoveUp <= 1'b0;
			MoveDown <= 1'b0;
			OpenDoor <=1'b1;
			CloseDoor <= 1'b0;
			Stop <=1'b1;
			LCD<= 3'b010;
		end
			
	s_2_openD: begin
			MoveUp <= 1'b0;
			MoveDown <= 1'b0;
			OpenDoor <=1'b1;
			CloseDoor <= 1'b0;
			Stop <=1'b1;
			LCD<= 3'b010;
		end
			
         s_23_Up: begin
			MoveUp <=1'b1;
			MoveDown <= 1'b0;
			OpenDoor <= 1'b0;
			CloseDoor <=1'b1;
			Stop <=1'b0;
			LCD<= 3'b010;
		end
		
	s_32_Down: begin
			MoveUp <= 1'b0;
			MoveDown <=1'b1;
			OpenDoor <= 1'b0;
			CloseDoor <=1'b1;
			Stop <=1'b0;
			LCD<=3'b011;
		end
			
	s_3_stopU: begin
			MoveUp <= 1'b0;
			MoveDown <= 1'b0;
			OpenDoor <= 1'b0;
			CloseDoor <=1'b1;
			Stop <=1'b1;
			LCD<= 3'b011;
		end
			
	s_3_stopD: begin
			MoveUp <= 1'b0;
			MoveDown <= 1'b0;
			OpenDoor <= 1'b0;
			CloseDoor <=1'b1;
			Stop <=1'b1;
			LCD<= 3'b011;
		end
        
         s_3_openU: begin
			MoveUp <= 1'b0;
			MoveDown <= 1'b0;
			OpenDoor <=1'b1;
			CloseDoor <= 1'b0;
			Stop <=1'b1;
			LCD<= 3'b011;
		end
			
	s_3_openD: begin
			MoveUp <= 1'b0;
			MoveDown <= 1'b0;
			OpenDoor <=1'b1;
			CloseDoor <= 1'b0;
			Stop <=1'b1;
			LCD<= 3'b011;
		end
			
         s_34_Up: begin
			MoveUp <=1'b1;
			MoveDown <= 1'b0;
			OpenDoor <= 1'b0;
			CloseDoor <=1'b1;
			Stop <=1'b0;
			LCD<= 3'b011;
		end
			
	s_43_Down: begin
			MoveUp <= 1'b0;
			MoveDown <=1'b1;
			OpenDoor <= 1'b0;
			CloseDoor <=1'b1;
			Stop <=1'b0;
			LCD<=3'b100;
		end
			
	s_4_stopU: begin
			MoveUp <= 1'b0;
			MoveDown <= 1'b0;
			OpenDoor <= 1'b0;
			CloseDoor <=1'b1;
			Stop <=1'b1;
			LCD<= 3'b100;
		end
			
	s_4_stopD: begin
			MoveUp <= 1'b0;
			MoveDown <= 1'b0;
			OpenDoor <= 1'b0;
			CloseDoor <=1'b1;
			Stop <=1'b1;
			LCD<= 3'b100;
		end
        
         s_4_openU: begin
			MoveUp <= 1'b0;
			MoveDown <= 1'b0;
			OpenDoor <=1'b1;
			CloseDoor <= 1'b0;
			Stop <=1'b1;
			LCD<= 3'b100;
		end
			
	s_4_openD: begin
			MoveUp <= 1'b0;
			MoveDown <= 1'b0;
			OpenDoor <=1'b1;
			CloseDoor <= 1'b0;
			Stop <=1'b1;
			LCD<= 3'b100;
		end
		
         s_45_Up: begin
			MoveUp <=1'b1;
			MoveDown <= 1'b0;
			OpenDoor <= 1'b0;
			CloseDoor <=1'b1;
			Stop <=1'b0;
			LCD<= 3'b100;
		end
			
	s_54_Down: begin
			MoveUp <= 1'b0;
			MoveDown <=1'b1;
			OpenDoor <= 1'b0;
			CloseDoor <=1'b1;
			Stop <=1'b0;
			LCD<= 3'b101;
		end
			
	s_5_stop: begin
			MoveUp <= 1'b0;
			MoveDown <= 1'b0;
			OpenDoor <= 1'b0;
			CloseDoor <=1'b1;
			Stop <=1'b1;
			LCD<= 3'b101;
		end
			
         s_5_open: begin
			MoveUp <= 1'b0;
			MoveDown <= 1'b0;
			OpenDoor <=1'b1;
			CloseDoor <= 1'b0;
			Stop <=1'b1;
			LCD<= 3'b101;
			end
         default: begin 
			MoveUp <= 1'b0;
			MoveDown <= 1'b0;
			OpenDoor <= 1'b0;
			CloseDoor <=1'b1;
			Stop <=1'b1;
			LCD<= 3'b000;
			end
      endcase
    end
  endmodule
