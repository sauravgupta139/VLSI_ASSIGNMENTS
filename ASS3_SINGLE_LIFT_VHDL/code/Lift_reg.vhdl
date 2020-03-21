library ieee;
use ieee.std_logic_1164.all;

 entity  Lift_reg is
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
end Lift_reg;
     architecture behav of Lift_reg is
	 signal Hall_call_Down_temp: std_logic_vector(5 downto 1):="00000";
	 signal Hall_call_Up_temp: std_logic_vector(4 downto 0):="00000";
	 signal Car_call_temp: std_logic_vector(5 downto 0):="000000";
	 
	 begin
		process(OpenDoor,clk,Hall_call_Down_signal,Hall_call_Up_signal,Sensor,Car_call_signal)
		begin
		if (clk = '1' and clk'event) then
			Hall_call_Up_temp <= Hall_call_Up_signal or Hall_call_Up_temp;
			Hall_call_Down_temp<= Hall_call_Down_signal or Hall_call_Down_temp;
			Car_call_temp<=Car_call_signal or Car_call_temp;
			if(OpenDoor = '1') then
				if(Sensor(0) = '1') then
					Hall_call_Up_temp(0)<='0';
					Car_call_temp(0)<='0';
				elsif(Sensor(1) = '1') then
					Hall_call_Up_temp(1)<='0';
					Hall_call_Down_temp(1)<='0';
					Car_call_temp(1)<='0';
				elsif(Sensor(2) = '1') then
					Hall_call_Up_temp(2)<='0';
					Hall_call_Down_temp(2)<='0';
					Car_call_temp(2)<='0';
				elsif(Sensor(3) = '1') then
					Hall_call_Up_temp(3)<='0';
					Hall_call_Down_temp(3)<='0';
					Car_call_temp(3)<='0';
				elsif(Sensor(4) = '1') then
					Hall_call_Up_temp(4)<='0';
					Hall_call_Down_temp(4)<='0';
					Car_call_temp(4)<='0';
				elsif(Sensor(5) = '1') then
					Hall_call_Down_temp(5)<='0';
					Car_call_temp(5)<='0';
				end if;
			end if;
		end if;
		end process;
		Hall_call_Down<=Hall_call_Down_temp;
		Hall_call_Up<=Hall_call_Up_temp;
		Car_call<=Car_call_temp;
		
	 
	 end behav;