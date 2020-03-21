library ieee;
    use ieee.std_logic_1164.all;
    entity RSA is
        port(Zin: in std_logic_vector(15 downto 0);
			Enable_RSA: in std_logic;
            Zout: out std_logic_vector(15 downto 0)
			);
    end RSA;
        
    architecture Behv of RSA is
	begin
		process(Zin,Enable_RSA)
		begin
			if (Enable_RSA ='1') then
				for i in 0 to 14 loop
					Zout(i)<=Zin(i+1);
				end loop;
				Zout(15)<=Zin(15);
			end if;
		end process;
        end Behv;