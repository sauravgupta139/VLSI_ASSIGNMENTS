library ieee;
use ieee.std_logic_1164.all;
 entity Booths_mul_tb is
 end Booths_mul_tb;
     
     architecture DF of Booths_mul_tb is
	 
        --  Declaration of the component that will be instantiated.
        component Booths_mul
        port(X: in std_logic_vector(7 downto 0);
			 Y: in std_logic_vector(7 downto 0);
			 start: in std_logic;
			 clock: in std_logic;
			 reset: in std_logic;
             pdt: buffer std_logic_vector(15 downto 0)
			);
        end component;
		
        --  Specifies which entity is bound with the component.
        --for DUT: Booths_mul use entity work.Booths_mul;
        signal X: std_logic_vector(7 downto 0) :=x"00"; --initial values of signal
		signal Y: std_logic_vector(7 downto 0) :=x"00"; --initial values of signal
		signal start: std_logic:= '0';
		signal clock: std_logic:='0';
		signal reset: std_logic:='0';
		signal pdt: std_logic_vector(15 downto 0);
		
		begin
			--  Component instantiation.
			DUT: Booths_mul port map (X => X, Y => Y, start => start,clock => clock, reset=> reset, pdt => pdt);
     
			--  This process does the real job.
			process
				begin
				X <= x"36"; Y<=x"53"; --in hex change this to give different input
				wait for 20 ns;	
				wait;
			end process;
			
			process
				begin
				clock <='1';
				wait for 20 ns;
				clock <='0';
				wait for 20 ns;				
			end process;
			
			process
			begin
				start<='1';
				wait for 90 ns;
				start<='0';
				wait for 90 ns;
				wait;
			end process;
			
			process
			begin
				reset<= '1';
				wait for 50 ns;
				reset<= '0';
				wait for 50 ns;
				wait;
			end process;
     end DF;
	 