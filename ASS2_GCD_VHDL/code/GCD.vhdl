library ieee;
    use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;
    entity GCD is
        port(X,Y: in std_logic_vector(7 downto 0);
			clock: in std_logic;
			start: in std_logic;
			reset: in std_logic;
			Z: out std_logic_vector(7 downto 0);
			datavalid: out std_logic
			);
    end GCD;
        
    architecture ST of GCD is
	signal equal: std_logic;
	signal Enable_FS: std_logic;
	signal Enable_Latch: std_logic;
	signal Load: std_logic;
	signal done: std_logic;
	
	
	component control
        port(equal : in std_logic;
			clk: in std_logic;
			start: in std_logic;
			reset: in std_logic;
			Enable_FS: out std_logic;
			Enable_Latch: out std_logic;
			Load: out std_logic;
			done: out std_logic
			);
    end component;
	
	component Datapath
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
    end component;
	
	
	
	begin
		control_0: control port map(equal=>equal, clk=>clock, start=>start, reset=>reset,Enable_FS=>Enable_FS, Enable_Latch=>Enable_Latch,Load=>Load,done=>done);
		Datapath_1: Datapath port map(X=>X,Y=>Y,clock=>clock,reset=>reset,Load=>Load,Enable_FS=>Enable_FS,Enable_Latch=>Enable_Latch,done=>done,equal=>equal,Z=>Z);
		datavalid <= done;
    end ST;
