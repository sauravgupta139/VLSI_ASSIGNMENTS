library ieee;
    use ieee.std_logic_1164.all;

    entity shift_register_8_bit is
        port(clk: in std_logic;
			reset: in std_logic;
			rotate: in std_logic;
			X: in std_logic_vector(7 downto 0);
			Load_register: in std_logic;
            Y: out std_logic_vector(7 downto 0)
			);
    end shift_register_8_bit;
        
	architecture ST of shift_register_8_bit is
            signal temp: std_logic_vector(7 downto 0);
			signal temp_bar: std_logic_vector(7 downto 0);
			signal D: std_logic_vector(7 downto 0);
			signal Enable_register: std_logic;
			
			component D_ff
			port(clk: in std_logic;
            D: in std_logic;
			reset: in std_logic;
			Enable_D: in std_logic;
            Q: out std_logic;
            QPRIME: out std_logic);
			end component;
			
			component mux_21
			port(select_line: in std_logic;
			in1: in std_logic;
			in2: in std_logic;
            Y: out std_logic
			);
			end component;
            
                begin
				Enable_register<= Load_register or rotate;
				Gen_Reg:
				for i in 7 downto 0 generate
					mux: mux_21 port map(select_line=>Load_register, in1=>X(i), in2=>temp((i+1)mod 8),Y=>D(i));
					Dff : D_ff port map(clk=>clk, D=>D(i),reset=>reset,Enable_D=>Enable_register,Q=>temp(i),QPRIME=>temp_bar(i));
				end generate Gen_Reg;
					Y<=temp;				
    end ST;