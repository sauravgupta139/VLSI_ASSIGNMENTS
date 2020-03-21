library ieee;
    use ieee.std_logic_1164.all;
    entity FS_8 is
        port(Bin: in std_logic;
            X,Y: in std_logic_vector(7 downto 0);
			Enable_FS: in std_logic;
            Diff: out std_logic_vector(7 downto 0);
			Bout: out std_logic);
    end FS_8;
        
    architecture DF of FS_8 is
	begin
		process(X,Y,Enable_FS,Bin)
		variable B:std_logic_vector(8 downto 0);
		begin
			if (Enable_FS='1') then
				B(0):=Bin;
				for i in 0 to 7 loop
					Diff(i) <= (X(i) xor Y(i)) xor B(i);
					B(i+1) := ((not X(i)) and Y(i)) or (B(i) and (not X(i))) or (B(i) and Y(i));
				end loop;
				Bout<=B(8);
			end if;
		end process;
        end DF;