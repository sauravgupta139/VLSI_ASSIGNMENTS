library ieee;
    use ieee.std_logic_1164.all;

    entity mux_21 is
        port(select_line: in std_logic;
			in1: in std_logic;
			in2: in std_logic;
            Y: out std_logic
			);
    end mux_21;
        
	architecture DF of mux_21 is
            begin
                process(select_line,in1,in2)
                begin
				Y<=(in1 and select_line) or (in2 and (not select_line));
                end process;				
    end DF;