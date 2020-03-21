#include "systemc.h"

SC_MODULE(Input_port){
	sc_in_clk clock;
	sc_in<bool> Data_Request_switching;
	sc_in<bool> Data_Request_routing;
	sc_in<sc_bv<32> >input_flit;
	sc_out<bool> credit_out;
	sc_out<sc_bv<32> > output_flit;

	sc_bv<192> Virtual_buffer = 0x000000000000000000000000000000000000000000000000;
	bool Data_Request;
	sc_trace_file *wf;

	void input();
	void Request();

	SC_CTOR(Input_port){
		wf = sc_create_vcd_trace_file("input_port");
		sc_trace(wf, clock, "clock");
		sc_trace(wf, Data_Request, "Data_Request");
		sc_trace(wf, input_flit, "input_flit");
		sc_trace(wf, credit_out, "credit_out");
		sc_trace(wf, output_flit, "output_flit");
		sc_trace(wf, Virtual_buffer, "Virtual_buffer");
		SC_METHOD(input);
		sensitive << clock.neg();
		SC_METHOD(Request);
		sensitive << Data_Request_switching << Data_Request_routing;
	}

	~Input_port(){
		sc_close_vcd_trace_file(wf);
	}
};