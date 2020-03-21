library ieee;
    use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;

    entity counter_30 is
        port(Clock: in std_logic;
			Enable_counter: in std_logic;
			count_over: out std_logic
			);
    end counter_30;
        
    architecture Behv of counter_30 is
	signal temp:integer:=0;
	begin
		process(Clock,Enable_counter)
		begin
		if Enable_counter='1' then
			if (Clock ='1' and Clock'event) then
				if temp=30 then
					count_over <= '1';
				else
					temp <=temp+1;
				end if;
			end if;
		else
			temp<=0;
			count_over<='0';
			
		end if;
		end process;

    end Behv;