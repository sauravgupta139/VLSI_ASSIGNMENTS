#include "systemc.h"

SC_MODULE(delay_element){
	sc_in_clk clock;
	sc_in<sc_bv<32> > Input_flit;
	sc_out<sc_bv<32> > Output_flit;

	sc_bv<32> temp;

	void delay_prc();
	void delay_prc1();

	SC_CTOR(delay_element){
		SC_METHOD(delay_prc1);
		sensitive << clock.pos();
		SC_METHOD(delay_prc);
		sensitive << clock.neg();
	}
};