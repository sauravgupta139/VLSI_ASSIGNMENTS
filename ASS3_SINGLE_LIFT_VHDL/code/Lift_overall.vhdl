library ieee;
use ieee.std_logic_1164.all;

 entity  Lift_overall is
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
end Lift_overall;

     architecture ST of Lift_overall is
	 
	 signal Car_call_temp: std_logic_vector(5 downto 0);
	 signal Hall_call_Up_temp: std_logic_vector(4 downto 0);
	 signal Hall_call_Down_temp: std_logic_vector(5 downto 1);
	 signal OpenDoor_temp: std_logic;
	 signal CloseDoor_temp: std_logic;
	 signal Stop_temp: std_logic;
	 signal Sensor: std_logic_vector(5 downto 0);
	 signal MoveDown_temp: std_logic;
	 signal MoveUp_temp: std_logic;
	 signal Passenger_in_temp: std_logic;
	 
	 component  Lift_controller
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
	 end component;
	 
	  component  Lift_reg
	   port(clk: in std_logic;
	  Car_call_signal: in std_logic_vector(5 downto 0);
	  Hall_call_Up_signal: in std_logic_vector(4 downto 0);
	  Hall_call_Down_signal: in std_logic_vector(5 downto 1);
	  Sensor: in std_logic_vector(5 downto 0);
	  OpenDoor: in std_logic;
	  Hall_call_Up: out std_logic_vector(4 downto 0);
	  Hall_call_Down: out std_logic_vector(5 downto 1);
	  Car_call: out std_logic_vector(5 downto 0)
	 );
	  end component;
	 
	  component  Lift_Model
	  port(clk: in std_logic;
	  MoveUp: in std_logic;
	  MoveDown: in std_logic;
	  OpenDoor: in std_logic;
	  CloseDoor: in std_logic;
	  Stop: in std_logic;
	  Sensor: out std_logic_vector(5 downto 0);
	  Passenger_in: out std_logic
	 );
		end component;
		
	 begin
		Lift_controller_0 : Lift_controller port map(clk=>clk, reset=>reset,Sensor=>Sensor,Car_call=>Car_call_temp,Hall_call_Up=>Hall_call_Up_temp,Hall_call_Down=>Hall_call_Down_temp,Passenger_in=>Passenger_in_temp,MoveUp=>MoveUp_temp,MoveDown=>MoveDown_temp,OpenDoor=>OpenDoor_temp,CloseDoor=>CloseDoor_temp,Stop=>Stop_temp,LCD=>LCD);
		Lift_reg_1: Lift_reg port map(clk=>clk,Car_call_signal=>Car_call_signal,Hall_call_Down_signal=>Hall_call_Down_signal,Hall_call_Up_signal=>Hall_call_Up_signal,Sensor=>Sensor,OpenDoor=>OpenDoor_temp,Hall_call_Up=>Hall_call_Up_temp,Hall_call_Down=>Hall_call_Down_temp,Car_call=>Car_call_temp);
		Lift_Model_2: Lift_Model port map(clk=>clk,MoveUp=>MoveUp_temp,MoveDown=>MoveDown_temp,OpenDoor=>OpenDoor_temp,CloseDoor=>CloseDoor_temp,Stop=>Stop_temp,Sensor=>Sensor,Passenger_in=>Passenger_in_temp);
		OpenDoor<=OpenDoor_temp;
		CloseDoor<=CloseDoor_temp;
		MoveUp<=MoveUp_temp;
		MoveDown<=MoveDown_temp;
		Stop<=Stop_temp;
		LED_HALL_UP<=Hall_call_Up_temp;
		LED_HALL_DOWN<=Hall_call_Down_temp;
		LED_Car<=Car_call_temp;
 end ST;