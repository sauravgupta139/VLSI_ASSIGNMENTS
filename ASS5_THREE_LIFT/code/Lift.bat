iverilog -o Lift_overall_tb Lift_overall_tb.v Lift_overall.v Lift_master_controller.v Lift_controller.v Lift_reg.v Lift_Model.v Lift.v counter_30.v
vvp Lift_overall_tb

gtkwave run.vcd