library ieee;
    use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;

    entity counter_8 is
        port(Clock: in std_logic;
			Enable_counter: in std_logic;
			count_over: out std_logic
			);
    end counter_8;
        
    architecture Behv of counter_8 is
	signal temp:integer;
	begin
		process(Clock,Enable_counter)
		begin
		 if (Clock ='1' and Clock'event) then
			if Enable_counter='1' then
				temp<=0;
			elsif temp=8 then
				count_over <= '1';
			else
				temp <=temp+1;
			end if;
		end if;
		end process;

    end Behv;