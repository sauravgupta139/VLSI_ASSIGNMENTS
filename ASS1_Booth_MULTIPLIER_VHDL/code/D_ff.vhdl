library ieee;
    use ieee.std_logic_1164.all;
    entity D_ff is
        port(clk: in std_logic;
            D: in std_logic;
			reset: in std_logic;
			Enable_D: in std_logic;
            Q: out std_logic;
            QPRIME: out std_logic);
    end D_ff;
    
    architecture Behv of D_ff is        
        begin
			process(clk,D,reset,Enable_D)
			begin
				if reset ='1' then
					Q<='0';
					QPRIME<='1';
				else
					if(clk='1' and clk'event and Enable_D ='1')then
						Q<=D;
						QPRIME<=not D;
					end if;
				end if;
			end process;
	end Behv;
