library ieee;
use ieee.std_logic_1164.all;
entity  control is
 port(equal : in std_logic;
			clk: in std_logic;
			start: in std_logic;
			reset: in std_logic;
			Enable_FS: out std_logic;
			Enable_Latch: out std_logic;
			Load: out std_logic;
			done: out std_logic
			);
end control;

architecture behave  of control is
type MyState  is (s_reset,s_Load,s_compute,s_done);
   signal state_signal : MyState;  
  
begin  -- behave 

  next_state: process (reset,clk,start,equal)
    variable next_state_var : MyState;
  begin  -- process next_state
    next_state_var := state_signal;

    if reset = '1' then
      next_state_var := s_reset;
    else
      case state_signal is
        when s_reset => 
          if(reset = '0' and start='1') then
            next_state_var := s_Load;
          end if;
        when s_Load =>            
          next_state_var := s_compute;
        when s_compute =>
          if equal = '1' then
            next_state_var := s_done;
          else
            next_state_var := s_compute;
          end if;
        when s_done =>
			--if (reset='1') then
            next_state_var := s_reset;
			--end if;
        when others => null;
      end case;
    end if;

    if(clk'event and clk = '1') then
      state_signal <= next_state_var;
    end if;
      
    end process next_state;

    -- purpose: output process
    -- type   : combinational
    -- inputs : the sensitivity list
    -- outputs: the outputs of the Control path.
    output_process: process(state_signal)
    begin  -- process output_process
      -- hot conditions indicated later
      Enable_FS       <= '0';       
      Enable_Latch    <= '0';       
      Load            <= '0';
	  done			  <= '0';
            
      case state_signal is
        when s_reset=> 
          Enable_FS <= '0';       
		  Enable_Latch <= '0';
		  Load <='0';
		  done<='0';
        when s_Load=>
          Enable_FS <= '0';       
		  Enable_Latch <= '0';
		  Load <='1';
		  done<='0';
        when s_compute =>
			Enable_FS <= '1';       
			Enable_Latch <= '1';
			Load <='0';
			done<='0';
        when s_done =>
			Enable_FS <= '0';       
			Enable_Latch <= '0';
			Load <='0';
			done<='1';
        when others =>null;
      end case;
    end process output_process;
  end behave ;

