library ieee;
    use ieee.std_logic_1164.all;
    entity Latchs is
        port(X: in std_logic_vector(7 downto 0);
			reset: in std_logic;
			clk: in std_logic;
			Enable_Latch: in std_logic;
            Z: out std_logic_vector(7 downto 0)
			);
    end Latchs;
        
    architecture DF of Latchs is
	begin
		process(X,Enable_Latch,reset,clk)
			begin
				if(reset='1') then
					Z<=x"00";
				else
					if(clk='1' and clk'event and Enable_Latch='1') then
						Z<=X;
					end if;
				end if;
		end process;
    end DF;