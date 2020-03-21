library ieee;
    use ieee.std_logic_1164.all;

    entity mux_21 is
        port(select_line: in std_logic;
			in1: in std_logic_vector(7 downto 0);
			in2: in std_logic_vector(7 downto 0);
            Y: out std_logic_vector(7 downto 0)
			);
    end mux_21;
        
	architecture Behv of mux_21 is
	
            begin
                process(select_line,in1,in2)
                begin
				if(select_line='0') then
					Y<=in1;
				else
					Y<=in2;
				end if;
                end process;				
    end Behv;