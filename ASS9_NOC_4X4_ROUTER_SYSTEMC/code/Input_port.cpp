#include "Input_port.h"

void Input_port::input() {
	if (Data_Request == 1){
		Virtual_buffer = Virtual_buffer >> 32;
		credit_out = 1;
	}

	if (Virtual_buffer.range(31, 30) == "00" || Virtual_buffer.range(31, 30) == "XX")
		Virtual_buffer.range(31, 0) = input_flit.read();
	else if (Virtual_buffer.range(63, 62) == "00" || Virtual_buffer.range(63, 62) == "XX")
		Virtual_buffer.range(63, 32) = input_flit.read();
	else if (Virtual_buffer.range(95, 94) == "00" || Virtual_buffer.range(95, 94) == "XX")
		Virtual_buffer.range(95, 64) = input_flit.read();
	else if (Virtual_buffer.range(127, 126) == "00" || Virtual_buffer.range(127, 126) == "XX")
		Virtual_buffer.range(127, 96) = input_flit.read();
	else if (Virtual_buffer.range(159, 158) == "00" || Virtual_buffer.range(159, 158) == "XX")
		Virtual_buffer.range(159, 128) = input_flit.read();
	else if (Virtual_buffer.range(191, 190) == "00" || Virtual_buffer.range(191, 190) == "XX")
		Virtual_buffer.range(191, 160) = input_flit.read();

	output_flit = Virtual_buffer.range(31, 0);
}

void Input_port::Request(){
	Data_Request = Data_Request_routing & Data_Request_switching;
}