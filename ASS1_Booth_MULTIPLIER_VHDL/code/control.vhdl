library ieee;
    use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;

    entity control is
        port(Clock: in std_logic;
			in1: in std_logic;
			in2: in std_logic;
			count_over: in std_logic;
			Enable_Twos_complement: out std_logic;
			Enable_FA: out std_logic;
			Enable_RSA: out std_logic;
			Load_Register: out std_logic;
			Rot_x: out std_logic
			);
    end control;
        
    architecture Behv of control is
	begin
		process(Clock,in1,in2,count_over)
		begin
		if(count_over /='1') then
			if (Clock ='1' and Clock'event) then
			
				if(in1 = '0' and in2 = '1') then
					Enable_FA <='1';
					Enable_RSA <='1';
					Enable_Twos_complement<='0';
					Load_Register<='1';
				elsif(in1 = '1' and in2 = '0') then
					Enable_FA <='1';
					Enable_RSA <='1';
					Enable_Twos_complement<='1';
					Load_Register<='1';
				else
					Enable_FA <='0';
					Enable_RSA <='1';
					Enable_Twos_complement<='0';
					Load_Register<='1';
				end if;
				Rot_x<='1';
			end if;
		else
		Enable_FA <='0';
		Enable_RSA <='0';
		Enable_Twos_complement<='0';
		Load_Register<='0';
		Rot_x<='0';	
		end if;
		end process;

    end Behv;