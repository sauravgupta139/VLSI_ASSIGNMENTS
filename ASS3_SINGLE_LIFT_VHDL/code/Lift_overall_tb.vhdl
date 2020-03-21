library ieee;
use ieee.std_logic_1164.all;
 entity Lift_overall_tb is
 end Lift_overall_tb;
     
     architecture behav of Lift_overall_tb is
	 
        --  Declaration of the component that will be instantiated.
      component Lift_overall
	   port(clk: in std_logic;
	  reset: in std_logic;
	  Car_call_signal: in std_logic_vector(5 downto 0);
	  Hall_call_Up_signal: in std_logic_vector(4 downto 0);
	  Hall_call_Down_signal: in std_logic_vector(5 downto 1);
	  MoveUp: out std_logic;
	  MoveDown: out std_logic;
	  OpenDoor: out std_logic;
	  CloseDoor: out std_logic;
	  Stop: out std_logic;
	  LCD: out integer;
	  LED_HALL_UP: out std_logic_vector(4 downto 0);
	  LED_HALL_DOWN: out std_logic_vector(5 downto 1);
	  LED_Car: out std_logic_vector(5 downto 0)
	 );
      end component;
		
        --  Specifies which entity is bound with the component.
        --for DUT: Lift_overall use entity work.Lift_overall;
        signal clk: std_logic:='0';
		signal reset: std_logic:='0';
		signal Car_call_signal: std_logic_vector(5 downto 0):="000000";
		signal Hall_call_Up_signal: std_logic_vector(4 downto 0):="00000";
		signal Hall_call_Down_signal: std_logic_vector(5 downto 1):="00000";
		signal MoveUp: std_logic;
		signal MoveDown: std_logic;
		signal OpenDoor: std_logic;
		signal CloseDoor: std_logic;
		signal Stop: std_logic;
		signal LCD: integer;
		signal LED_HALL_UP: std_logic_vector(4 downto 0);
		signal LED_HALL_DOWN: std_logic_vector(5 downto 1);
		signal LED_Car: std_logic_vector(5 downto 0);
		
		
		begin
			--  Component instantiation.
			DUT: Lift_overall port map (clk => clk,reset=>reset,Car_call_signal=>Car_call_signal, Hall_call_Down_signal => Hall_call_Down_signal,Hall_call_Up_signal=> Hall_call_Up_signal,OpenDoor=>OpenDoor,MoveDown=>MoveDown,MoveUp=>MoveUp,CloseDoor=>CloseDoor,Stop=>Stop,LCD=>LCD,LED_HALL_UP=>LED_HALL_UP,LED_HALL_DOWN=>LED_HALL_DOWN,LED_Car=>LED_Car);     
			--  This process does the real job.
			process
				begin
				clk<='1';
				wait for 10 ms;
				clk<='0';
				wait for 10 ms;
			end process;
			
			process
				begin
				reset<='0';				
				wait for 19000 ms;
				--reset<='1';
				--wait for 4000 ms;
				wait;
			end process;
			
			process
				begin
				Hall_call_Up_signal(2)<='1';wait for 600 ms; Hall_call_Up_signal(2)<='0';
				wait for 2000 ms;
				Car_call_signal(4)<='1';wait for 600 ms;Car_call_signal(4)<='0';
				wait for 800 ms;
				Hall_call_Down_signal(5)<='1';wait for 600 ms;Hall_call_Down_signal(5)<='0'; 
				wait for 3000 ms;
				Car_call_signal(0)<='1';wait for 600 ms;Car_call_signal(0)<='0'; --new third floor up request
				wait for 400 ms;
				Hall_call_Up_signal(3)<='1';wait for 600 ms;Hall_call_Up_signal(3)<='0'; --new second floor request
				wait;
			end process;
     end behav;