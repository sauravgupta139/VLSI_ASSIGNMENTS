ghdl -a and_2.vhdl
ghdl -a counter_8.vhdl
ghdl -a D_ff.vhdl
ghdl -a FA_8.vhdl
ghdl -a mux_21.vhdl
ghdl -a register_16.vhdl
ghdl -a RSA.vhdl
ghdl -a shift_register_8_bit.vhdl
ghdl -a twos_complement.vhdl
ghdl -a control.vhdl
ghdl -a Booths_mul.vhdl
ghdl -a Booths_mul_tb.vhdl
ghdl -m Booths_mul_tb
ghdl -r Booths_mul_tb --stop-time=700ns --wave=run.ghw
gtkwave run.ghw