library ieee;
use ieee.std_logic_1164.all;
 entity GCD_tb is
 end GCD_tb;
     
     architecture DF of GCD_tb is
	 
        --  Declaration of the component that will be instantiated.
        component GCD
        port(X,Y: in std_logic_vector(7 downto 0);
			clock: in std_logic;
			start: in std_logic;
			reset: in std_logic;
			Z: out std_logic_vector(7 downto 0);
			datavalid: out std_logic
			);
        end component;
		
        --  Specifies which entity is bound with the component.
        for DUT: GCD use entity work.GCD;
        signal X: std_logic_vector(7 downto 0) :=x"00"; --initial values of signal
		signal Y: std_logic_vector(7 downto 0) :=x"00"; --initial values of signal
		signal start: std_logic:= '0';
		signal clock: std_logic:='0';
		signal reset: std_logic:='0';
		signal Z: std_logic_vector(7 downto 0);
		signal datavalid: std_logic;
		
		begin
			--  Component instantiation.
			DUT: GCD port map (X => X, Y => Y, start => start,clock => clock, reset=> reset, Z => Z, datavalid => datavalid);
     
			--  This process does the real job.
			process
				begin
				X <= x"FF"; Y<=x"FF"; --in hex change this to give different input
				wait for 600 ns;	
				X <= x"3F"; Y<=x"0C"; --in hex change this to give different input
				wait for 600 ns;
				X <= x"FF"; Y<=x"35"; --in hex change this to give different input
				wait for 600 ns;
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
				wait for 510 ns;
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
	 
