library ieee;
    use ieee.std_logic_1164.all;
    entity register_16 is
        port(din : in std_logic_vector(15 downto 0);
			clk:in std_logic;
            Enable_register: in std_logic;
			reset: in std_logic;
            dout: buffer std_logic_vector(15 downto 0)
			);
        end register_16;
        architecture ST of register_16 is 
		signal temp: std_logic_vector(15 downto 0);
		signal temp_bar: std_logic_vector(15 downto 0);
		
		component D_ff is
        port(clk: in std_logic;
            D: in std_logic;
			reset: in std_logic;
			Enable_D: in std_logic;
            Q: out std_logic;
            QPRIME: out std_logic);
        end component;		
        begin
		Gen_Reg:
			for i in 15 downto 0 generate
			Dff: D_ff port map(clk=>clk, D=>din(i),reset=>reset,Enable_D=>Enable_register,Q=>temp(i),QPRIME=>temp_bar(i));
			end generate Gen_Reg;
			dout<=temp;
		end ST;
