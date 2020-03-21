iverilog -o input_port input_port.v
vvp input_port
iverilog -o delay_element delay_element.v
vvp delay_element
iverilog -o routing_logic routing_logic.v
vvp routing_logic
iverilog -o crossbar_switch crossbar_switch.v
vvp crossbar_switch
iverilog -o Switch_Allocator Switch_Allocator.v
vvp Switch_Allocator
iverilog -o router router.v input_port.v routing_logic.v Switch_Allocator.v delay_element.v crossbar_switch.v
vvp router
iverilog -o router_tb router_tb.v input_port.v routing_logic.v Switch_Allocator.v delay_element.v crossbar_switch.v router.v
vvp router_tb
gtkwave run.vcd