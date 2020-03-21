`timescale 1us/1ps
module RLE_tb;
	wire [7:0] Data_out;
	wire Data_valid;
	
	reg [7:0] Data_In;
	reg Enable;
	reg fast_clock;
	reg data_clock;
	reg start;
	
	integer i;
	
	RLE DUT(Data_In,Enable,fast_clock,data_clock,start,Data_out,Data_valid);     
	
	initial
	begin
		$dumpfile("run.vcd");
		$dumpvars(0,RLE_tb);
		data_clock=1'b1;
		fast_clock=1'b1;
		Enable=1'b1;
		start=1'b1;
		Data_In= 8'b01100011;	//c
		#40 start=1'b0;
		#40 Data_In= 8'b01100011;	//c
		#80 Data_In= 8'b01100011;	//c
		#80 Data_In= 8'b01100011;	//c
		#80 Data_In= 8'b01100010;	//b
		#80 Data_In= 8'b01100010;	//b
		#80 Data_In= 8'b01100001;	//a
		#80 Data_In= 8'b01100110;	//f
		#80 Data_In= 8'b01100110;	//f
		#80 Data_In= 8'b01100101;	//e
		#80 Data_In= 8'b00011011;	//ESC
		#80 Data_In= 8'b00011011;	//ESC
		#80 Data_In= 8'b01100111;	//g
		for (i=1;i<=300;i=i+1)
			#80 Data_In= 8'b01101000;	//h
		#80 Data_In= 8'b01101000;	//h
		#80 Data_In= 8'b01101000;	//h
		#80 Data_In= 8'b01101000;	//h
		#80 Data_In= 8'b01101000;	//h
		#80 Data_In= 8'b01101000;	//h
		#80 Data_In= 8'b00011011;	//ESC
		#80 Data_In= 8'b00011011;	//ESC
		#80 Data_In= 8'b01101001;	//i
		#80 Data_In= 8'b01101010;	//j
		#80 Data_In= 8'b00011011;	//ESC
		#80 Data_In= 8'b01101011;	//k
		#80 Data_In= 8'b01101011;	//k
		#80 Data_In= 8'b00000000;	//NULL
		#640 $finish;
	end

	always
	begin
		data_clock = #40 ~data_clock;
	end
	
	always
	begin
		fast_clock = #10 ~fast_clock;
	end
			
    endmodule
