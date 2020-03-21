#include "systemc.h"

SC_MODULE(crossbar_switch){
	sc_in_clk clock;
	sc_in<sc_bv<32> >Local_Input, North_Input, South_Input, East_Input, West_Input;
	sc_in<sc_bv<4> > NSEWtoL, LSEWtoN, LNEWtoS, LNSWtoE, LNSEtoW;
	sc_out<sc_bv<32> > Local_output, North_output, South_output, East_output, West_output;

	sc_bv<32> Local_output_temp, North_output_temp, South_output_temp, East_output_temp, West_output_temp;
	sc_bv<32> temp1, temp2, temp3, temp4, temp5;

	sc_trace_file *wf;
	void cross_switch();
	void output_flits();

	SC_CTOR(crossbar_switch){
		wf = sc_create_vcd_trace_file("crossbar_switch");
		sc_trace(wf, clock, "clock");
		sc_trace(wf, Local_Input, "Local_Input");
		sc_trace(wf, North_Input, "North_Input");
		sc_trace(wf, South_Input, "South_Input");
		sc_trace(wf, East_Input, "East_Input");
		sc_trace(wf, West_Input, "West_Input");
		sc_trace(wf, NSEWtoL, "NSEWtoL");
		sc_trace(wf, LSEWtoN, "LSEWtoN");
		sc_trace(wf, LNEWtoS, "LNEWtoS");
		sc_trace(wf, LNSWtoE, "LNSWtoE");
		sc_trace(wf, LNSEtoW, "LNSEtoW");
		sc_trace(wf, Local_output, "Local_output");
		sc_trace(wf, North_output, "North_output");
		sc_trace(wf, South_output, "South_output");
		sc_trace(wf, East_output, "East_output");
		sc_trace(wf, West_output, " West_output");

		sc_trace(wf, Local_output_temp, "Local_output_temp");
		sc_trace(wf, North_output_temp, "North_output_temp");
		sc_trace(wf, South_output_temp, "South_output_temp");
		sc_trace(wf, East_output_temp, "East_output_temp");
		sc_trace(wf, West_output_temp, " West_output_temp");

		sc_trace(wf, temp1, "temp1");
		sc_trace(wf, temp2, "temp2");
		sc_trace(wf, temp3, "temp3");
		sc_trace(wf, temp4, "temp4");
		sc_trace(wf, temp5, "temp5");

		SC_METHOD(cross_switch);
		sensitive << clock.pos();
		SC_METHOD(output_flits);
		sensitive << clock.pos();
	}
	~crossbar_switch(){
		sc_close_vcd_trace_file(wf);
	}
};