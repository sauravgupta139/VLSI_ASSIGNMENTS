library ieee;
    use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;
    entity Datapath is
        port(X,Y: in std_logic_vector(7 downto 0);
			clock: in std_logic;
			reset: in std_logic;
			Load: in std_logic;
			Enable_FS: in std_logic;
			Enable_Latch: in std_logic;
			done: in std_logic;
			equal: out std_logic;
			Z: out std_logic_vector(7 downto 0)
			);
    end Datapath;
        
    architecture ST of Datapath is
	signal Modx: std_logic_vector(7 downto 0);
	signal Mody: std_logic_vector(7 downto 0);
	signal Xnew: std_logic_vector(7 downto 0);
	signal Ynew: std_logic_vector(7 downto 0);
	signal Diff: std_logic_vector(7 downto 0);
	signal gt_ltbar: std_logic;
	signal Bin: std_logic:='0';
	signal Borrow: std_logic;
	signal Borrow1: std_logic;
	signal XminusY: std_logic_vector(7 downto 0);
	signal YminusX: std_logic_vector(7 downto 0);
	
	component Modulus
        port(X,Y: in std_logic_vector(7 downto 0);
            Xout,Yout: out std_logic_vector(7 downto 0)
			);
    end component;
	
	component Diff_reg
		port(X,Y: in std_logic_vector(7 downto 0);
			Diff: in std_logic_vector(7 downto 0);
			gt_ltbar: in std_logic;
			clk: in std_logic;
			Ld_diffbar: in std_logic;
			reset: in std_logic;
			Enable_Latch: in std_logic;
            Xout,Yout: out std_logic_vector(7 downto 0)
			);
	end component;
	
	component comparator
        port(X,Y: in std_logic_vector(7 downto 0);
			equal: out std_logic;
            gt_ltbar: out std_logic
			);
    end component;
	
	component FS_8
        port(Bin: in std_logic;
            X,Y: in std_logic_vector(7 downto 0);
			Enable_FS: in std_logic;
            Diff: out std_logic_vector(7 downto 0);
			Bout: out std_logic);
    end component;
	
	component mux_21
        port(select_line: in std_logic;
			in1: in std_logic_vector(7 downto 0);
			in2: in std_logic_vector(7 downto 0);
            Y: out std_logic_vector(7 downto 0)
			);
    end component;
	
	component Latchs
        port(X: in std_logic_vector(7 downto 0);
			reset: in std_logic;
			clk: in std_logic;
			Enable_Latch: in std_logic;
            Z: out std_logic_vector(7 downto 0)
			);
    end component;
	
	begin
		Modulus_1: Modulus port map(X=>X,Y=>Y,Xout=>ModX,Yout=>ModY);
		Diff_reg_2: Diff_reg port map(X=>ModX,Y=>ModY,Diff=>Diff,gt_ltbar=>gt_ltbar,clk=>clock,Ld_diffbar=>Load,reset=>reset,Enable_Latch=>Enable_Latch,Xout=>Xnew,Yout=>Ynew);
		comparator_3: comparator port map(X=>Xnew,Y=>Ynew,equal=>equal,gt_ltbar=>gt_ltbar);
		FS_8_4: FS_8 port map(Bin=>Bin,X=>Xnew,Y=>Ynew,Enable_FS=>Enable_FS,Diff=>XminusY,Bout=>Borrow);
		FS_8_5: FS_8 port map(Bin=>Bin,X=>Ynew,Y=>Xnew,Enable_FS=>Enable_FS,Diff=>YminusX,Bout=>Borrow1);
		mux_21_6: mux_21 port map(select_line=>gt_ltbar,in1=>YminusX,in2=>XminusY,Y=>Diff);
		Latch_7: Latchs port map(X=>Xnew,reset=>reset,clk=>clock,Enable_Latch=>done,Z=>Z);	
    end ST;