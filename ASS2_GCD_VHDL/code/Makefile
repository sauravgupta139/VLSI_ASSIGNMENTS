all: compile elaborate run
compile:
	ghdl -a FS_8.vhdl
	ghdl -a Latchs.vhdl
	ghdl -a mux_21.vhdl
	ghdl -a Modulus.vhdl
	ghdl -a Diff_reg.vhdl
	ghdl -a comparator.vhdl
	ghdl -a control.vhdl
	ghdl -a Datapath.vhdl
	ghdl -a GCD.vhdl
	ghdl -a GCD_tb.vhdl
elaborate:
	ghdl -e GCD_tb
run:
	ghdl -r GCD_tb --stop-time=2000ns --wave=run.ghw
	gtkwave run.ghw
