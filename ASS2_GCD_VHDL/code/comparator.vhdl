library ieee;
    use ieee.std_logic_1164.all;
    entity comparator is
        port(X,Y: in std_logic_vector(7 downto 0);
			equal: out std_logic;
            gt_ltbar: out std_logic
			);
    end comparator;
        
    architecture DF of comparator is
	begin
		process(X,Y)
		begin
			if(X=Y and X/=x"00") then
				equal<='1';
				gt_ltbar<='0';
			else
				if(X>Y) then
					equal<='0';
					gt_ltbar<='1';
				else
					equal<='0';
					gt_ltbar<='0';
				end if;
			end if;
			
		end process;
        end DF;