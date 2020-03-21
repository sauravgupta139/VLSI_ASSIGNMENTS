ghdl -a counter_30.vhdl
ghdl -a Lift.vhdl
ghdl -a Lift_Model.vhdl
ghdl -a Lift_reg.vhdl
ghdl -a Lift_controller.vhdl
ghdl -a Lift_overall.vhdl
ghdl -a Lift_overall_tb.vhdl
ghdl -m Lift_overall_tb
ghdl -r Lift_overall_tb --stop-time=20000ms --wave=run.ghw
gtkwave run.ghw