library ieee;
    use ieee.std_logic_1164.all;
    entity Booths_mul is
        port(X: in std_logic_vector(7 downto 0);
			 Y: in std_logic_vector(7 downto 0);
			 start: in std_logic;
			 clock: in std_logic;
			 reset: in std_logic;
             pdt: buffer std_logic_vector(15 downto 0)
			);
    end Booths_mul;
        
    architecture ST of Booths_mul is
	
	signal U: std_logic_vector(15 downto 0);
	signal Z:std_logic_vector(15 downto 0);
	signal Y_prime: std_logic_vector(7 downto 0);
	signal sum_prime: std_logic_vector(7 downto 0);
	signal Enable_twos_complement: std_logic;
	signal Enable_FA: std_logic;
	signal Enable_RSA: std_logic;
	signal Load_Register: std_logic;
	signal Rot_x: std_logic;
	signal Carry: std_logic;
	signal X_prime: std_logic_vector(7 downto 0);
	signal q: std_logic;
	signal q_bar: std_logic;
	signal count_over: std_logic;
	signal Cin: std_logic :='0';
	
		component control --import control circuit
			port(Clock: in std_logic;
			in1: in std_logic;
			in2: in std_logic;
			count_over: in std_logic;
			Enable_Twos_complement: out std_logic;
			Enable_FA: out std_logic;
			Enable_RSA: out std_logic;
			Load_Register: out std_logic;
			Rot_x: out std_logic
			);
		end component;
		
		component counter_8 --import 8 bit counter
        port(Clock: in std_logic;
			Enable_counter: in std_logic;
			count_over: out std_logic
			);
		end component;
		
		component D_ff --import D flip flop
        port(clk: in std_logic;
            D: in std_logic;
			reset: in std_logic;
			Enable_D: in std_logic;
            Q: out std_logic;
            QPRIME: out std_logic);
		end component;
	
		component FA_8 --import 8 bit FA
			port(Cin: in std_logic;
            X,Y: in std_logic_vector(7 downto 0);
			Enable_FA: in std_logic;
            sum: out std_logic_vector(7 downto 0);
			Cout: out std_logic);
        end component;
		
		component twos_complement --import twos_complement Hardware
			port(Xin: in std_logic_vector(7 downto 0);
            Xout: out std_logic_vector(7 downto 0);
			Enable_twos_complement: in std_logic
			);
		end component;
		
		component RSA  --import 16 bit Right Shift Arithmetic Hardware
			port(Zin: in std_logic_vector(15 downto 0);
			Enable_RSA: in std_logic;
            Zout: out std_logic_vector(15 downto 0)
			);
		end component;
		
		component register_16 --import 16 bit register_16
			port(din : in std_logic_vector(15 downto 0);
			clk: in std_logic;
            Enable_register: in std_logic;
			reset: in std_logic;
            dout: buffer std_logic_vector(15 downto 0)
			);
        end component;
		
		component shift_register_8_bit --import 8 bit Right shift Hardware
			port(clk: in std_logic;
			reset: in std_logic;
			rotate: in std_logic;
			X: in std_logic_vector(7 downto 0);
			Load_register: in std_logic;
            Y: out std_logic_vector(7 downto 0)
			);
		end component;
        	
	begin
			twos_complement_0 : twos_complement port map(Xin=>Y, Xout=>Y_prime, Enable_twos_complement=>Enable_twos_complement);
	
			U<= sum_prime & pdt(7 downto 0);
			
			FA_1: FA_8 port map(Cin=>Cin, X=>Y_prime, Y=>pdt(15 downto 8), Enable_FA=>Enable_FA, sum=>sum_prime, Cout=>Carry);
			
			RSA_2: RSA port map(Zin=> U,Enable_RSA=>Enable_RSA , Zout=> Z);
			
			register_16bit_3: register_16 port map(din=>Z,clk=>clock, Enable_register=> Load_Register, reset=>reset , dout=>pdt);
			
			right_shift_4 : shift_register_8_bit port map(clk=>clock,reset=> reset ,rotate=> Rot_x, X=>X, Load_Register=>start, Y=>X_prime);
			
			D_ff_5: D_ff port map(clk=>clock, D=>X_prime(0),reset=>reset,Enable_D=>Rot_x, Q=>q ,QPRIME=>q_bar);
			
			control_6: control port map(Clock=>clock, in1=>X_prime(0), in2=>q, count_over=>count_over, Enable_Twos_complement=>Enable_Twos_complement, Enable_FA=>Enable_FA, Enable_RSA=>Enable_RSA,Load_Register=>Load_Register, Rot_x=>Rot_x);
			
			counter_7: counter_8 port map(Clock=> clock, Enable_counter=> start, count_over=>count_over);
			
			
    end ST;