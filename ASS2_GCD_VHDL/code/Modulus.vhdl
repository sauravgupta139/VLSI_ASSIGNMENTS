library ieee;
    use ieee.std_logic_1164.all;
    entity Modulus is
        port(X,Y: in std_logic_vector(7 downto 0);
            Xout,Yout: out std_logic_vector(7 downto 0)
			);
    end Modulus;
        
    architecture DF of Modulus is
	begin
		process(X,Y)
		variable A: std_logic_vector(7 downto 0);
		variable B: std_logic_vector(7 downto 0);
		variable sum: std_logic_vector(7 downto 0);
		variable C: std_logic_vector(8 downto 0);
		variable A1: std_logic_vector(7 downto 0);
		variable B1: std_logic_vector(7 downto 0);
		variable sum1: std_logic_vector(7 downto 0);
		variable C1: std_logic_vector(8 downto 0);
		begin
			if(X(7)='1') then
				A:=not X;
				B:=x"01";
				C(0):='0';
				for i in 0 to 7 loop
				sum(i) := (A(i) xor B(i)) xor C(i);
				C(i+1) := (A(i) and B(i)) or (C(i) and (A(i) xor B(i)));
				end loop;
				Xout<=sum;
			else
				Xout<=X;
			end if;
			
			if(Y(7)='1') then
				A1:=not Y;
				B1:=x"01";
				C1(0):='0';
				for i in 0 to 7 loop
				sum1(i) := (A1(i) xor B1(i)) xor C1(i);
				C1(i+1) := (A1(i) and B1(i)) or (C1(i) and (A1(i) xor B1(i)));
				end loop;
				Yout<=sum1;
			else
				Yout<=Y;
			end if;
		end process;
        end DF;