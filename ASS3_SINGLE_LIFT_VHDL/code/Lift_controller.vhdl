library ieee;
use ieee.std_logic_1164.all;

entity  Lift_controller is
 port(clk: in std_logic;
	  reset: in std_logic;
	  Sensor: in std_logic_vector(5 downto 0);
	  Car_call: in std_logic_vector(5 downto 0);
	  Hall_call_Up: in std_logic_vector(4 downto 0);
	  Hall_call_Down: in std_logic_vector(5 downto 1);
	  Passenger_in: in std_logic;
	  MoveUp: out std_logic;
	  MoveDown: out std_logic;
	  OpenDoor: out std_logic;
	  CloseDoor: out std_logic;
	  Stop: out std_logic;
	  LCD: out integer
	 );
end Lift_controller;

architecture behave  of Lift_controller is
 
type MyState is (s_0_stop,s_0_open,s_01_Up,s_10_Down,s_1_stopU,s_1_stopD,s_1_openU,s_1_openD,s_12_Up,s_21_Down,s_2_stopU,s_2_stopD,s_2_openU,s_2_openD,s_23_Up,s_32_Down,s_3_stopU,s_3_stopD,s_3_openU,s_3_openD,s_34_Up,s_43_Down,s_4_stopU,s_4_stopD,s_4_openU,s_4_openD,s_45_Up,s_54_Down,s_5_stop,s_5_open);
   signal state_signal : MyState;  
  
begin  -- behave 

  next_state: process (reset,clk,Sensor,Hall_call_Up,Hall_call_Down,Car_call,Passenger_in,state_signal)
    variable next_state_var : MyState;
  begin  -- process next_state
    next_state_var := state_signal;

      case state_signal is
		when s_0_stop => 
			if(reset = '1' or Hall_call_Up(0)='1' or Car_call(0)='1') then
				next_state_var := s_0_open;
			elsif (Hall_call_Down(1)='1' or Hall_call_Up(1)='1' or Car_call(1)='1' or Hall_call_Down(2)='1' or Hall_call_Up(2)='1' or Car_call(2)='1' or Hall_call_Down(3)='1'or Hall_call_Up(3)='1' or Car_call(3)='1' or Hall_call_Down(4)='1'or Hall_call_Up(4)='1' or Car_call(4)='1' or Hall_call_Down(5)='1' or Car_call(5)='1') then
					next_state_var := s_01_Up;
			end if;
		  
		when s_0_open => 
			if(reset = '1') then
				next_state_var := s_0_open;
			else
				if(Passenger_in ='1') then
					next_state_var := s_0_stop;
				end if;
			end if;
		
		when s_01_Up => 
			if(Sensor(1)='1' and (Car_call(1)='1' or Hall_call_Up(1)='1' or reset='1'))  then
				next_state_var := s_1_stopU;
			elsif(Sensor(1)='1' and (Hall_call_Down(2)='1' or Hall_call_Up(2)='1' or Car_call(2)='1' or Hall_call_Down(3)='1'or Hall_call_Up(3)='1' or Car_call(3)='1' or Hall_call_Down(4)='1'or Hall_call_Up(4)='1' or Car_call(4)='1' or Hall_call_Down(5)='1' or Car_call(5)='1' )) then
				next_state_var := s_12_Up;
			elsif(Sensor(1)='1') then
				next_state_var := s_1_stopU;
			end if;
		when s_10_Down => 
			if(Sensor(0)='1') then
				next_state_var := s_0_stop;
			end if;
		  
		when s_1_stopU => 
			if(reset = '1' or Car_call(1)='1' or Hall_call_Down(1)='1' or Hall_call_Up(1)='1') then
				next_state_var := s_1_openU;
			elsif (Hall_call_Down(2)='1' or Hall_call_Up(2)='1' or Car_call(2)='1' or Hall_call_Down(3)='1'or Hall_call_Up(3)='1' or Car_call(3)='1' or Hall_call_Down(4)='1'or Hall_call_Up(4)='1' or Car_call(4)='1'or Hall_call_Down(5)='1' or Car_call(5)='1') then
				next_state_var := s_12_Up;
			elsif (Hall_call_Up(0)='1') then
				next_state_var := s_10_Down;
			end if;
		
		when s_1_stopD => 
			if(reset = '1' or Car_call(1)='1' or Hall_call_Down(1)='1' or Hall_call_Up(1)='1') then
				next_state_var := s_1_openD;
			elsif (Hall_call_Up(0)='1') then
				next_state_var := s_10_Down;
			elsif (Hall_call_Down(2)='1' or Hall_call_Up(2)='1' or Car_call(2)='1' or Hall_call_Down(3)='1'or Hall_call_Up(3)='1' or Car_call(3)='1' or Hall_call_Down(4)='1'or Hall_call_Up(4)='1' or Car_call(4)='1'or Hall_call_Down(5)='1' or Car_call(5)='1') then
				next_state_var := s_12_Up;
			end if;
		  
		when s_1_openU => 
			if(reset = '1') then
				next_state_var := s_1_openU;
			else
				if(Passenger_in ='1') then
					next_state_var := s_1_stopU;
				end if;
			end if;
			
		when s_1_openD => 
			if(reset = '1') then
				next_state_var := s_1_openD;
			else
				if(Passenger_in ='1') then
					next_state_var := s_1_stopD;
				end if;
			end if;
		
		when s_12_Up => 
			if(Sensor(2)='1' and (Hall_call_Up(2)='1' or Car_call(2)='1' or reset='1'))  then
				next_state_var := s_2_stopU;
			elsif(Sensor(2)='1' and (Hall_call_Down(3)='1'or Hall_call_Up(3)='1' or Car_call(3)='1' or Hall_call_Down(4)='1'or Hall_call_Up(4)='1' or Car_call(4)='1' or Hall_call_Down(5)='1' or Car_call(5)='1' )) then
				next_state_var := s_23_Up;
			elsif(Sensor(2)='1') then
				next_state_var := s_2_stopU;
			end if;
		  
		when s_21_Down => 
			if(Sensor(1)='1' and (Hall_call_Down(1)='1' or Car_call(1)='1' or reset='1'))  then
				next_state_var := s_1_stopD;
			elsif(Sensor(1)='1' and (Hall_call_Up(0)='1' or Car_call(0)='1')) then
				next_state_var := s_10_Down;
			elsif(Sensor(1)='1') then
				next_state_var := s_1_stopD;
			end if;
		  
		when s_2_stopU => 
			if(reset = '1' or Hall_call_Down(2)='1' or Hall_call_Up(2)='1' or Car_call(2)='1') then
				next_state_var := s_2_openU;
			elsif (Hall_call_Down(3)='1'or Hall_call_Up(3)='1' or Car_call(3)='1' or Hall_call_Down(4)='1'or Hall_call_Up(4)='1' or Car_call(4)='1' or Hall_call_Down(5)='1' or Car_call(5)='1') then
				next_state_var := s_23_Up;	
			elsif (Hall_call_Up(0)='1' or Car_call(0)='1' or Hall_call_Down(1)='1'or Hall_call_Up(1)='1' or Car_call(1)='1') then
				next_state_var := s_21_Down;
			end if;
		
		when s_2_stopD => 
			if(reset = '1' or Hall_call_Down(2)='1' or Hall_call_Up(2)='1' or Car_call(2)='1') then
				next_state_var := s_2_openD;
			elsif (Hall_call_Up(0)='1' or Car_call(0)='1' or Hall_call_Down(1)='1'or Hall_call_Up(1)='1' or Car_call(1)='1') then
				next_state_var := s_21_Down;
			elsif (Hall_call_Down(3)='1'or Hall_call_Up(3)='1' or Car_call(3)='1' or Hall_call_Down(4)='1'or Hall_call_Up(4)='1' or Car_call(4)='1' or Hall_call_Down(5)='1' or Car_call(5)='1') then
				next_state_var := s_23_Up;	
			end if;
		  
		when s_2_openU => 
			if(reset = '1') then
				next_state_var := s_2_openU;
			else
				if(Passenger_in ='1') then
					next_state_var := s_2_stopU;
				end if;
			end if;
			
		when s_2_openD => 
			if(reset = '1') then
				next_state_var := s_2_openD;
			else
				if(Passenger_in ='1') then
					next_state_var := s_2_stopD;
				end if;
			end if;
		
		when s_23_Up => 
			if(Sensor(3)='1' and (Hall_call_Up(3)='1' or Car_call(3)='1' or reset='1'))  then
				next_state_var := s_3_stopU;
			elsif(Sensor(3)='1' and  (Hall_call_Down(4)='1'or Hall_call_Up(4)='1' or Car_call(4)='1' or Hall_call_Down(5)='1' or Car_call(5)='1' )) then
				next_state_var := s_34_Up;
			elsif(Sensor(3)='1') then
				next_state_var := s_3_stopU;
			end if;
		  
		when s_32_Down => 
			if(Sensor(2)='1' and (Hall_call_Down(2)='1' or Car_call(2)='1' or reset='1'))  then
				next_state_var := s_2_stopD;
			elsif(Sensor(2)='1' and(Hall_call_Up(0)='1' or Car_call(0)='1' or Hall_call_Down(1)='1'or Hall_call_Up(1)='1' or Car_call(1)='1')) then
				next_state_var := s_21_Down;
			elsif(Sensor(2)='1') then
				next_state_var := s_2_stopD;
			end if;
		  
		when s_3_stopU => 
			if(reset = '1' or Hall_call_Down(3)='1' or Hall_call_Up(3)='1' or Car_call(3)='1') then
				next_state_var := s_3_openU;
			elsif (Hall_call_Down(4)='1'or Hall_call_Up(4)='1' or Car_call(4)='1' or Hall_call_Down(5)='1'  or Car_call(5)='1') then
				next_state_var := s_34_Up;
			elsif (Hall_call_Up(0)='1' or Car_call(0)='1' or Hall_call_Down(1)='1' or Hall_call_Up(1)='1' or Car_call(1)='1' or Hall_call_Down(2)='1' or Hall_call_Up(2)='1' or Car_call(2)='1') then
				next_state_var := s_32_Down;				
			end if;
		
		when s_3_stopD => 
			if(reset = '1' or Hall_call_Down(3)='1' or Hall_call_Up(3)='1' or Car_call(3)='1') then
				next_state_var := s_3_openU;
			elsif (Hall_call_Up(0)='1' or Car_call(0)='1' or Hall_call_Down(1)='1' or Hall_call_Up(1)='1' or Car_call(1)='1' or Hall_call_Down(2)='1' or Hall_call_Up(2)='1' or Car_call(2)='1') then
				next_state_var := s_32_Down;
			elsif (Hall_call_Down(4)='1'or Hall_call_Up(4)='1' or Car_call(4)='1' or Hall_call_Down(5)='1'  or Car_call(5)='1') then
				next_state_var := s_34_Up;				
			end if;		
		  
		when s_3_openU => 
			if(reset = '1') then
				next_state_var := s_3_openU;
			else
				if(Passenger_in ='1') then
					next_state_var := s_3_stopU;
				end if;
			end if;
			
		when s_3_openD => 
			if(reset = '1') then
				next_state_var := s_3_openD;
			else
				if(Passenger_in ='1') then
					next_state_var := s_3_stopD;
				end if;
			end if;
		
		when s_34_Up => 
			if(Sensor(4)='1' and (Hall_call_Up(4)='1' or Car_call(4)='1' or reset='1'))  then
				next_state_var := s_4_stopU;
			elsif(Sensor(4)='1' and (Hall_call_Down(5)='1' or Car_call(5)='1')) then
				next_state_var := s_45_Up;
			elsif(Sensor(4)='1') then
				next_state_var := s_4_stopU;
			end if;
		  
		when s_43_Down => 
			if(Sensor(3)='1' and (Hall_call_Down(3)='1' or Car_call(3)='1' or reset='1'))  then
				next_state_var := s_3_stopD;
			elsif(Sensor(3)='1' and (Hall_call_Up(0)='1' or Car_call(0)='1' or Hall_call_Down(1)='1'or Hall_call_Up(1)='1' or Car_call(1)='1' or Hall_call_Down(2)='1' or Hall_call_Up(2)='1' or Car_call(2)='1')) then
				next_state_var := s_32_Down;
			elsif(Sensor(3)='1') then
				next_state_var := s_3_stopD;
			end if;
		  
		when s_4_stopU => 
			if(reset = '1' or Hall_call_Down(4)='1' or Hall_call_Up(4)='1' or Car_call(4)='1') then
				next_state_var := s_4_openU;
			elsif (Hall_call_Down(5)='1' or Car_call(5)='1') then
				next_state_var := s_45_Up;
			elsif (Hall_call_Up(0)='1' or Car_call(0)='1'or Hall_call_Down(1)='1'or Hall_call_Up(1)='1' or Car_call(1)='1' or Hall_call_Down(2)='1' or Hall_call_Up(2)='1' or Car_call(2)='1'or Hall_call_Down(3)='1' or Hall_call_Up(3)='1' or Car_call(3)='1') then
				next_state_var := s_43_Down;				
			end if;
			
		when s_4_stopD => 
			if(reset = '1' or Hall_call_Down(4)='1' or Hall_call_Up(4)='1' or Car_call(4)='1') then
				next_state_var := s_4_openD;
			elsif (Hall_call_Up(0)='1' or Car_call(0)='1'or Hall_call_Down(1)='1'or Hall_call_Up(1)='1' or Car_call(1)='1' or Hall_call_Down(2)='1' or Hall_call_Up(2)='1' or Car_call(2)='1'or Hall_call_Down(3)='1' or Hall_call_Up(3)='1' or Car_call(3)='1') then
				next_state_var := s_43_Down;
			elsif (Hall_call_Down(5)='1' or Car_call(5)='1') then
				next_state_var := s_45_Up;				
			end if;
		  
		when s_4_openU => 
			if(reset = '1') then
				next_state_var := s_4_openU;
			else
				if(Passenger_in ='1') then
					next_state_var := s_4_stopU;
				end if;
			end if;
			
		when s_4_openD => 
			if(reset = '1') then
				next_state_var := s_4_openD;
			else
				if(Passenger_in ='1') then
					next_state_var := s_4_stopD;
				end if;
			end if;
		
		when s_45_Up => 
			if(Sensor(5)='1') then
				next_state_var := s_5_stop;
			end if;
		  
		when s_54_Down => 
			if(Sensor(4)='1' and (Hall_call_Down(4)='1' or Car_call(4)='1' or reset='1'))  then
				next_state_var := s_4_stopD;
			elsif(Sensor(4)='1' and (Hall_call_Up(0)='1' or Car_call(0)='1' or Hall_call_Down(1)='1'or Hall_call_Up(1)='1' or Car_call(1)='1' or Hall_call_Down(2)='1' or Hall_call_Up(2)='1' or Car_call(2)='1' or Hall_call_Down(3)='1' or Hall_call_Up(3)='1' or Car_call(3)='1' )) then
				next_state_var := s_43_Down;
			elsif(Sensor(4)='1') then
				next_state_var := s_4_stopD;
			end if;
		  
		when s_5_stop => 
			if(reset = '1' or Hall_call_Down(5)='1' or Car_call(5)='1') then
				next_state_var := s_5_open;
			elsif (Hall_call_Up(0)='1' or Car_call(0)='1' or Hall_call_Down(1)='1'or Hall_call_Up(1)='1' or Car_call(1)='1' or Hall_call_Down(2)='1' or Hall_call_Up(2)='1' or Car_call(2)='1' or Hall_call_Down(3)='1' or Hall_call_Up(3)='1' or Car_call(3)='1' or Hall_call_Down(4)='1' or Hall_call_Up(4)='1' or Car_call(4)='1') then
				next_state_var := s_54_Down;				
			end if;
		  
		when s_5_open => 
			if(reset = '1') then
				next_state_var := s_5_open;
			else
				if(Passenger_in ='1') then
					next_state_var := s_5_stop;
				end if;
			end if;

        when others => null;
      end case;

    if(clk'event and clk = '1') then
      state_signal <= next_state_var;
    end if;
      
    end process next_state;
	

    -- purpose: output process
    -- type   : combinational
    -- inputs : the sensitivity list
    -- outputs: the outputs of the Control path.
    output_process: process(state_signal)
    begin  -- process output_process
      -- hot conditions indicated later
            
      case state_signal is
        when s_0_stop=>
			MoveUp <= '0';
			MoveDown <= '0';
			OpenDoor <= '0';
			CloseDoor <= '1';
			Stop <='1';
			LCD<= 0;

        when s_0_open =>
			MoveUp <= '0';
			MoveDown <= '0';
			OpenDoor <= '1';
			CloseDoor <= '0';
			Stop <='1';
			LCD<= 0;
		
        when s_01_Up =>
			MoveUp <= '1';
			MoveDown <= '0';
			OpenDoor <= '0';
			CloseDoor <= '1';
			Stop <='0';
			LCD<= 0;
			
		when s_10_Down=>
			MoveUp <= '0';
			MoveDown <= '1';
			OpenDoor <= '0';
			CloseDoor <= '1';
			Stop <='0';
			LCD<= 1;
			
		when s_1_stopU=>
			MoveUp <= '0';
			MoveDown <= '0';
			OpenDoor <= '0';
			CloseDoor <= '1';
			Stop <='1';
			LCD<= 1;
			
		when s_1_stopD=>
			MoveUp <= '0';
			MoveDown <= '0';
			OpenDoor <= '0';
			CloseDoor <= '1';
			Stop <='1';
			LCD<= 1;
        
        when s_1_openU =>
			MoveUp <= '0';
			MoveDown <= '0';
			OpenDoor <= '1';
			CloseDoor <= '0';
			Stop <='1';
			LCD<= 1;
		
		when s_1_openD =>
			MoveUp <= '0';
			MoveDown <= '0';
			OpenDoor <= '1';
			CloseDoor <= '0';
			Stop <='1';
			LCD<= 1;
		
        when s_12_Up =>
			MoveUp <= '1';
			MoveDown <= '0';
			OpenDoor <= '0';
			CloseDoor <= '1';
			Stop <='0';
			LCD<= 1;
			
		when s_21_Down=>
			MoveUp <= '0';
			MoveDown <= '1';
			OpenDoor <= '0';
			CloseDoor <= '1';
			Stop <='0';
			LCD<= 2;
			
		when s_2_stopU=>
			MoveUp <= '0';
			MoveDown <= '0';
			OpenDoor <= '0';
			CloseDoor <= '1';
			Stop <='1';
			LCD<= 2;
			
		when s_2_stopD=>
			MoveUp <= '0';
			MoveDown <= '0';
			OpenDoor <= '0';
			CloseDoor <= '1';
			Stop <='1';
			LCD<= 2;
        
        when s_2_openU =>
			MoveUp <= '0';
			MoveDown <= '0';
			OpenDoor <= '1';
			CloseDoor <= '0';
			Stop <='1';
			LCD<= 2;
			
		when s_2_openD =>
			MoveUp <= '0';
			MoveDown <= '0';
			OpenDoor <= '1';
			CloseDoor <= '0';
			Stop <='1';
			LCD<= 2;
			
        when s_23_Up =>
			MoveUp <= '1';
			MoveDown <= '0';
			OpenDoor <= '0';
			CloseDoor <= '1';
			Stop <='0';
			LCD<= 2;
		
		when s_32_Down=>
			MoveUp <= '0';
			MoveDown <= '1';
			OpenDoor <= '0';
			CloseDoor <= '1';
			Stop <='0';
			LCD<= 3;
			
		when s_3_stopU=>
			MoveUp <= '0';
			MoveDown <= '0';
			OpenDoor <= '0';
			CloseDoor <= '1';
			Stop <='1';
			LCD<= 3;
			
		when s_3_stopD=>
			MoveUp <= '0';
			MoveDown <= '0';
			OpenDoor <= '0';
			CloseDoor <= '1';
			Stop <='1';
			LCD<= 3;
        
        when s_3_openU =>
			MoveUp <= '0';
			MoveDown <= '0';
			OpenDoor <= '1';
			CloseDoor <= '0';
			Stop <='1';
			LCD<= 3;
			
		when s_3_openD =>
			MoveUp <= '0';
			MoveDown <= '0';
			OpenDoor <= '1';
			CloseDoor <= '0';
			Stop <='1';
			LCD<= 3;
			
        when s_34_Up =>
			MoveUp <= '1';
			MoveDown <= '0';
			OpenDoor <= '0';
			CloseDoor <= '1';
			Stop <='0';
			LCD<= 3;
			
		when s_43_Down=>
			MoveUp <= '0';
			MoveDown <= '1';
			OpenDoor <= '0';
			CloseDoor <= '1';
			Stop <='0';
			LCD<= 4;
			
		when s_4_stopU=>
			MoveUp <= '0';
			MoveDown <= '0';
			OpenDoor <= '0';
			CloseDoor <= '1';
			Stop <='1';
			LCD<= 4;
			
		when s_4_stopD=>
			MoveUp <= '0';
			MoveDown <= '0';
			OpenDoor <= '0';
			CloseDoor <= '1';
			Stop <='1';
			LCD<= 4;
        
        when s_4_openU =>
			MoveUp <= '0';
			MoveDown <= '0';
			OpenDoor <= '1';
			CloseDoor <= '0';
			Stop <='1';
			LCD<= 4;
			
		when s_4_openD =>
			MoveUp <= '0';
			MoveDown <= '0';
			OpenDoor <= '1';
			CloseDoor <= '0';
			Stop <='1';
			LCD<= 4;
		
        when s_45_Up =>
			MoveUp <= '1';
			MoveDown <= '0';
			OpenDoor <= '0';
			CloseDoor <= '1';
			Stop <='0';
			LCD<= 4;
			
		when s_54_Down=>
			MoveUp <= '0';
			MoveDown <= '1';
			OpenDoor <= '0';
			CloseDoor <= '1';
			Stop <='0';
			LCD<= 5;
			
		when s_5_stop=>
			MoveUp <= '0';
			MoveDown <= '0';
			OpenDoor <= '0';
			CloseDoor <= '1';
			Stop <='1';
			LCD<= 5;
			
        when s_5_open =>
			MoveUp <= '0';
			MoveDown <= '0';
			OpenDoor <= '1';
			CloseDoor <= '0';
			Stop <='1';
			LCD<= 5;
		
        when others =>null;
      end case;
    end process output_process;
  end behave ;