library ieee;
    use ieee.std_logic_1164.all;

    entity and_2 is
        port(A, B         : in  std_logic_vector(7 downto 0);
                        C : out std_logic_vector(7 downto 0)
                        );
    end and_2;
        
    architecture DF of and_2 is
	
    begin
                process(A, B)
                begin
                        C <= A and B;
                end process;
    end DF;
    
