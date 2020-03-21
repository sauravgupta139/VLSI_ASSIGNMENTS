library ieee;
    use ieee.std_logic_1164.all;
    entity twos_complement is
        port(Xin: in std_logic_vector(7 downto 0);
            Xout: out std_logic_vector(7 downto 0);
			Enable_twos_complement: in std_logic
			);
    end twos_complement;
        
    architecture ST of twos_complement is
	
	begin
		process(Xin,Enable_twos_complement)
		variable D:std_logic_vector(7 downto 0);
		variable C:std_logic_vector(8 downto 0);
		variable sum: std_logic_vector(7 downto 0);
		variable X: std_logic_vector(7 downto 0);
		variable Y: std_logic_vector(7 downto 0);
			begin
				if (Enable_twos_complement = '1') then
					X:=not Xin;
					Y:=x"01";
					C(0):='0';
					for i in 0 to 7 loop
						sum(i) := (X(i) xor Y(i)) xor C(i);
						C(i+1) := (X(i) and Y(i)) or (C(i) and (X(i) xor Y(i)));
					end loop;
					D:=sum;
				else
					D:= Xin;
				end if;
				Xout <=D;
		end process;
    end ST;