iverilog -o RLE_tb RLE_tb.v RLE.v
vvp RLE_tb
gtkwave run.vcd