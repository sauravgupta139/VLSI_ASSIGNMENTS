library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

 entity  Lift_Model is
 port(clk: in std_logic;
	  MoveUp: in std_logic;
	  MoveDown: in std_logic;
	  OpenDoor: in std_logic;
	  CloseDoor: in std_logic;
	  Stop: in std_logic;
	  Sensor: out std_logic_vector(5 downto 0);
	  Passenger_in: out std_logic
	 );
end Lift_Model;

architecture behav of Lift_Model is

	component Lift
	port(clk: in std_logic;
	  MoveUp: in std_logic;
	  MoveDown: in std_logic;
	  OpenDoor: in std_logic;
	  CloseDoor: in std_logic;
	  Stop: in std_logic;
	  start: out std_logic;
	  done: in std_logic;
	  Sensor: out std_logic_vector(5 downto 0);
	  Passenger_in: out std_logic
	 );
	end component;
	
	component counter_30
        port(Clock: in std_logic;
			Enable_counter: in std_logic;
			count_over: out std_logic
			);
    end component;
	
signal start: std_logic;
signal done : std_logic;

begin
	Lift_0 : Lift port map(clk=>clk,MoveUp=>MoveUp,MoveDown=>MoveDown,OpenDoor=>OpenDoor,CloseDoor=>CloseDoor,Stop=>Stop,start=>start,done=>done,Sensor=>Sensor,Passenger_in=>Passenger_in);
	Counter_1: counter_30 port map(Clock=>clk,Enable_counter=>start,count_over=>done);
end behav;