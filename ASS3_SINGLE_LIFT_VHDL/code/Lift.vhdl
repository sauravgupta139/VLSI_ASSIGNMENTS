library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

 entity  Lift is
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
end Lift;

architecture behav of Lift is
	
signal Sensor_temp: std_logic_vector(5 downto 0):="000001";
begin

process(clk,MoveDown,MoveUp,OpenDoor,CloseDoor,done,Stop)
begin
	if(clk='1' and clk'event) then
		if(MoveUp ='1') then
			start<='1';
			if(done='1') then
				start<='0';
				Sensor_temp<= std_logic_vector(shift_left(unsigned(Sensor_temp),1));
			end if;
		
		elsif(MoveDown ='1') then
			start<='1';
			if(done='1') then
				start<='0';
				Sensor_temp<= std_logic_vector(shift_right(unsigned(Sensor_temp),1));
			end if;
		
		elsif(OpenDoor='1' and stop='1') then
			start<='1';Passenger_in<='0';
			if(done='1') then
				start<='0';
				Passenger_in<='1';
			end if;
			
		elsif(CloseDoor='1' and stop='1') then
			start<='0';
		end if;
	end if;
end process;
	Sensor<= Sensor_temp;
end behav;