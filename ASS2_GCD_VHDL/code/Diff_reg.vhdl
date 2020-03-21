library ieee;
    use ieee.std_logic_1164.all;
    entity Diff_reg is
        port(X,Y: in std_logic_vector(7 downto 0);
			Diff: in std_logic_vector(7 downto 0);
			gt_ltbar: in std_logic;
			clk: in std_logic;
			Ld_diffbar: in std_logic;
			reset: in std_logic;
			Enable_Latch: in std_logic;
            Xout,Yout: out std_logic_vector(7 downto 0)
			);
    end Diff_reg;
        
    architecture Behv of Diff_reg is
	begin
		process(X,Y,Diff,reset,clk,Enable_Latch,gt_ltbar,Ld_diffbar)
		begin
			if (reset='1') then
				Xout<=x"00";
				Yout<=x"00";	
			else
				if(Ld_diffbar='1') then
					Xout<=X;
					Yout<=Y;
				else
					if(clk='1' and clk'event and Enable_Latch='1') then	
						if(gt_ltbar='0') then
							Yout<=Diff;
						else
							Xout<=Diff;
						end if;
					end if;
				end if;
			end if;
		end process;
        end Behv;