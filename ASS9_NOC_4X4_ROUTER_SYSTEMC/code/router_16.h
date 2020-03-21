#include "router.h"

SC_MODULE(router_16){
	sc_in_clk clock;
	sc_in<sc_bv<2> > XPresent1, YPresent1, XPresent2, YPresent2, XPresent3, YPresent3, XPresent4, YPresent4, XPresent5, YPresent5, XPresent6, YPresent6, XPresent7, YPresent7, XPresent8, YPresent8, XPresent9, YPresent9, XPresent10, YPresent10, XPresent11, YPresent11, XPresent12, YPresent12, XPresent13, YPresent13, XPresent14, YPresent14, XPresent15, YPresent15, XPresent16, YPresent16;
	sc_in<sc_bv<32> > Core_in_00, Core_in_10, Core_in_20, Core_in_30;
	sc_in<sc_bv<32> > Core_in_01, Core_in_11, Core_in_21, Core_in_31;
	sc_in<sc_bv<32> > Core_in_02, Core_in_12, Core_in_22, Core_in_32;
	sc_in<sc_bv<32> > Core_in_03, Core_in_13, Core_in_23, Core_in_33;

	sc_in<bool> Core_Credit_in_00, Core_Credit_in_10, Core_Credit_in_20, Core_Credit_in_30;
	sc_in<bool> Core_Credit_in_01, Core_Credit_in_11, Core_Credit_in_21, Core_Credit_in_31;
	sc_in<bool> Core_Credit_in_02, Core_Credit_in_12, Core_Credit_in_22, Core_Credit_in_32;
	sc_in<bool> Core_Credit_in_03, Core_Credit_in_13, Core_Credit_in_23, Core_Credit_in_33;

	sc_out<sc_bv<32> > Core_out_00, Core_out_10, Core_out_20, Core_out_30;
	sc_out<sc_bv<32> > Core_out_01, Core_out_11, Core_out_21, Core_out_31;
	sc_out<sc_bv<32> > Core_out_02, Core_out_12, Core_out_22, Core_out_32;
	sc_out<sc_bv<32> > Core_out_03, Core_out_13, Core_out_23, Core_out_33;

	sc_out<bool> Core_Credit_out_00, Core_Credit_out_10, Core_Credit_out_20, Core_Credit_out_30;
	sc_out<bool> Core_Credit_out_01, Core_Credit_out_11, Core_Credit_out_21, Core_Credit_out_31;
	sc_out<bool> Core_Credit_out_02, Core_Credit_out_12, Core_Credit_out_22, Core_Credit_out_32;
	sc_out<bool> Core_Credit_out_03, Core_Credit_out_13, Core_Credit_out_23, Core_Credit_out_33;

	sc_signal<sc_bv<32> > flit_00_10, flit_10_20, flit_20_30, flit_30_20, flit_20_10, flit_10_00;
	sc_signal<sc_bv<32> > flit_01_11, flit_11_21, flit_21_31, flit_31_21, flit_21_11, flit_11_01;
	sc_signal<sc_bv<32> > flit_02_12, flit_12_22, flit_22_32, flit_32_22, flit_22_12, flit_12_02;
	sc_signal<sc_bv<32> > flit_03_13, flit_13_23, flit_23_33, flit_33_23, flit_23_13, flit_13_03;

	sc_signal<sc_bv<32> > flit_00_01, flit_01_02, flit_02_03, flit_03_02, flit_02_01, flit_01_00;
	sc_signal<sc_bv<32> > flit_10_11, flit_11_12, flit_12_13, flit_13_12, flit_12_11, flit_11_10;
	sc_signal<sc_bv<32> > flit_20_21, flit_21_22, flit_22_23, flit_23_22, flit_22_21, flit_21_20;
	sc_signal<sc_bv<32> > flit_30_31, flit_31_32, flit_32_33, flit_33_32, flit_32_31, flit_31_30;

	sc_signal<bool>  Credit_00_10, Credit_10_20, Credit_20_30, Credit_30_20, Credit_20_10, Credit_10_00;
	sc_signal<bool>  Credit_01_11, Credit_11_21, Credit_21_31, Credit_31_21, Credit_21_11, Credit_11_01;
	sc_signal<bool>  Credit_02_12, Credit_12_22, Credit_22_32, Credit_32_22, Credit_22_12, Credit_12_02;
	sc_signal<bool>  Credit_03_13, Credit_13_23, Credit_23_33, Credit_33_23, Credit_23_13, Credit_13_03;

	sc_signal<bool>  Credit_00_01, Credit_01_02, Credit_02_03, Credit_03_02, Credit_02_01, Credit_01_00;
	sc_signal<bool>  Credit_10_11, Credit_11_12, Credit_12_13, Credit_13_12, Credit_12_11, Credit_11_10;
	sc_signal<bool>  Credit_20_21, Credit_21_22, Credit_22_23, Credit_23_22, Credit_22_21, Credit_21_20;
	sc_signal<bool>  Credit_30_31, Credit_31_32, Credit_32_33, Credit_33_32, Credit_32_31, Credit_31_30;

	//Dummy signals
	sc_signal<sc_bv<32> > dummy_input_00_North, dummy_input_10_North, dummy_input_20_North, dummy_input_30_North;
	sc_signal<sc_bv<32> > dummy_input_00_West, dummy_input_01_West, dummy_input_02_West, dummy_input_03_West;
	sc_signal<sc_bv<32> > dummy_input_30_East, dummy_input_31_East, dummy_input_32_East, dummy_input_33_East;
	sc_signal<sc_bv<32> > dummy_input_03_South, dummy_input_13_South, dummy_input_23_South, dummy_input_33_South;

	sc_signal<sc_bv<32> > dummy_output_00_North, dummy_output_10_North, dummy_output_20_North, dummy_output_30_North;
	sc_signal<sc_bv<32> > dummy_output_00_West, dummy_output_01_West, dummy_output_02_West, dummy_output_03_West;
	sc_signal<sc_bv<32> > dummy_output_30_East, dummy_output_31_East, dummy_output_32_East, dummy_output_33_East;
	sc_signal<sc_bv<32> > dummy_output_03_South, dummy_output_13_South, dummy_output_23_South, dummy_output_33_South;

	sc_signal<bool> dummy_Credit_in_00_North, dummy_Credit_in_10_North, dummy_Credit_in_20_North, dummy_Credit_in_30_North;
	sc_signal<bool> dummy_Credit_in_00_West, dummy_Credit_in_01_West, dummy_Credit_in_02_West, dummy_Credit_in_03_West;
	sc_signal<bool> dummy_Credit_in_30_East, dummy_Credit_in_31_East, dummy_Credit_in_32_East, dummy_Credit_in_33_East;
	sc_signal<bool> dummy_Credit_in_03_South, dummy_Credit_in_13_South, dummy_Credit_in_23_South, dummy_Credit_in_33_South;

	sc_signal<bool> dummy_Credit_out_00_North, dummy_Credit_out_10_North, dummy_Credit_out_20_North, dummy_Credit_out_30_North;
	sc_signal<bool> dummy_Credit_out_00_West, dummy_Credit_out_01_West, dummy_Credit_out_02_West, dummy_Credit_out_03_West;
	sc_signal<bool> dummy_Credit_out_30_East, dummy_Credit_out_31_East, dummy_Credit_out_32_East, dummy_Credit_out_33_East;
	sc_signal<bool> dummy_Credit_out_03_South, dummy_Credit_out_13_South, dummy_Credit_out_23_South, dummy_Credit_out_33_South;

	//pointers
	router *Router_00, *Router_10, *Router_20, *Router_30;
	router *Router_01, *Router_11, *Router_21, *Router_31;
	router *Router_02, *Router_12, *Router_22, *Router_32;
	router *Router_03, *Router_13, *Router_23, *Router_33;

	SC_CTOR(router_16){
		Router_00 = new router("Router1");
		(*Router_00)(clock, XPresent1, YPresent1, Core_in_00, dummy_input_00_North, flit_01_00, flit_10_00, dummy_input_00_West, Core_Credit_in_00, dummy_Credit_in_00_North, Credit_01_00, Credit_10_00, dummy_Credit_in_00_West, Core_Credit_out_00, dummy_Credit_out_00_North, Credit_00_01, Credit_00_10, dummy_Credit_out_00_West, Core_out_00, dummy_output_00_North, flit_00_01, flit_00_10, dummy_output_00_West);
		Router_10 = new router("Router2");
		(*Router_10)(clock, XPresent2, YPresent2, Core_in_10, dummy_input_10_North, flit_11_10, flit_20_10, flit_00_10, Core_Credit_in_10, dummy_Credit_in_10_North, Credit_11_10, Credit_20_10, Credit_00_10, Core_Credit_out_10, dummy_Credit_out_10_North, Credit_10_11, Credit_10_20, Credit_10_00, Core_out_10, dummy_output_10_North, flit_10_11, flit_10_20, flit_10_00);
		Router_20 = new router("Router3");
		(*Router_20)(clock, XPresent3, YPresent3, Core_in_20, dummy_input_20_North, flit_21_20, flit_30_20, flit_10_20, Core_Credit_in_20, dummy_Credit_in_20_North, Credit_21_20, Credit_30_20, Credit_10_20, Core_Credit_out_20, dummy_Credit_out_20_North, Credit_20_21, Credit_20_30, Credit_20_10, Core_out_20, dummy_output_20_North, flit_20_21, flit_20_30, flit_20_10);
		Router_30 = new router("Router4");
		(*Router_30)(clock, XPresent4, YPresent4, Core_in_30, dummy_input_30_North, flit_31_30, dummy_input_30_East, flit_20_30, Core_Credit_in_30, dummy_Credit_in_30_North, Credit_31_30, dummy_Credit_in_30_East, Credit_20_30, Core_Credit_out_30, dummy_Credit_out_30_North, Credit_30_31, dummy_Credit_out_30_East, Credit_30_20, Core_out_30, dummy_output_30_North, flit_30_31, dummy_output_30_East, flit_30_20);
		Router_01 = new router("Router5");
		(*Router_01)(clock, XPresent5, YPresent5, Core_in_01, flit_00_01, flit_02_01, flit_11_01, dummy_input_01_West, Core_Credit_in_01, Credit_00_01, Credit_02_01, Credit_11_01, dummy_Credit_in_01_West, Core_Credit_out_01, Credit_01_00, Credit_01_02, Credit_01_11, dummy_Credit_out_01_West, Core_out_01, flit_01_00, flit_01_02, flit_01_11, dummy_output_01_West);
		Router_11 = new router("Router6");
		(*Router_11)(clock, XPresent6, YPresent6, Core_in_11, flit_10_11, flit_12_11, flit_21_11, flit_01_11, Core_Credit_in_11, Credit_10_11, Credit_12_11, Credit_21_11, Credit_01_11, Core_Credit_out_11, Credit_11_10, Credit_11_12, Credit_11_21, Credit_11_01, Core_out_11, flit_11_10, flit_11_12, flit_11_21, flit_11_01);
		Router_21 = new router("Router7");
		(*Router_21)(clock, XPresent7, YPresent7, Core_in_21, flit_20_21, flit_22_21, flit_31_21, flit_11_21, Core_Credit_in_21, Credit_20_21, Credit_22_21, Credit_31_21, Credit_11_21, Core_Credit_out_21, Credit_21_20, Credit_21_22, Credit_21_31, Credit_21_11, Core_out_21, flit_21_20, flit_21_22, flit_21_31, flit_21_11);
		Router_31 = new router("Router8");
		(*Router_31)(clock, XPresent8, YPresent8, Core_in_31, flit_30_31, flit_32_31, dummy_input_31_East, flit_21_31, Core_Credit_in_31, Credit_30_31, Credit_32_31, dummy_Credit_in_31_East, Credit_21_31, Core_Credit_out_31, Credit_31_30, Credit_31_32, dummy_Credit_out_31_East, Credit_31_21, Core_out_31, flit_31_30, flit_31_32, dummy_output_31_East, flit_31_21);
		Router_02 = new router("Router9");
		(*Router_02)(clock, XPresent9, YPresent9, Core_in_02, flit_01_02, flit_03_02, flit_12_02, dummy_input_02_West, Core_Credit_in_02, Credit_01_02, Credit_03_02, Credit_12_02, dummy_Credit_in_02_West, Core_Credit_out_02, Credit_02_01, Credit_02_03, Credit_02_12, dummy_Credit_out_02_West, Core_out_02, flit_02_01, flit_02_03, flit_02_12, dummy_output_02_West);
		Router_12 = new router("Router10");
		(*Router_12)(clock, XPresent10, YPresent10, Core_in_12, flit_11_12, flit_13_12, flit_22_12, flit_02_12, Core_Credit_in_12, Credit_11_12, Credit_13_12, Credit_22_12, Credit_02_12, Core_Credit_out_12, Credit_12_11, Credit_12_13, Credit_12_22, Credit_12_02, Core_out_12, flit_12_11, flit_12_13, flit_12_22, flit_12_02);
		Router_22 = new router("Router11");
		(*Router_22)(clock, XPresent11, YPresent11, Core_in_22, flit_21_22, flit_23_22, flit_32_22, flit_12_22, Core_Credit_in_22, Credit_21_22, Credit_23_22, Credit_32_22, Credit_12_22, Core_Credit_out_22, Credit_22_21, Credit_22_23, Credit_22_32, Credit_22_12, Core_out_22, flit_22_21, flit_22_23, flit_22_32, flit_22_12);
		Router_32 = new router("Router12");
		(*Router_32)(clock, XPresent12, YPresent12, Core_in_32, flit_31_32, flit_33_32, dummy_input_32_East, flit_22_32, Core_Credit_in_32, Credit_31_32, Credit_33_32, dummy_Credit_in_32_East, Credit_22_32, Core_Credit_out_32, Credit_32_31, Credit_32_33, dummy_Credit_out_32_East, Credit_32_22, Core_out_32, flit_32_31, flit_32_33, dummy_output_32_East, flit_32_22);
		Router_03 = new router("Router13");
		(*Router_03)(clock, XPresent13, YPresent13, Core_in_03, flit_02_03, dummy_input_03_South, flit_13_03, dummy_input_03_West, Core_Credit_in_03, Credit_02_03, dummy_Credit_in_03_South, Credit_13_03, dummy_Credit_in_03_West, Core_Credit_out_03, Credit_03_02, dummy_Credit_out_03_South, Credit_03_13, dummy_Credit_out_03_West, Core_out_03, flit_03_02, dummy_output_03_South, flit_03_13, dummy_output_03_West);
		Router_13 = new router("Router14");
		(*Router_13)(clock, XPresent14, YPresent14, Core_in_13, flit_12_13, dummy_input_13_South, flit_23_13, flit_03_13, Core_Credit_in_13, Credit_12_13, dummy_Credit_in_13_South, Credit_23_13, Credit_03_13, Core_Credit_out_13, Credit_13_12, dummy_Credit_out_13_South, Credit_13_23, Credit_13_03, Core_out_13, flit_13_12, dummy_output_13_South, flit_13_23, flit_13_03);
		Router_23 = new router("Router15");
		(*Router_23)(clock, XPresent15, YPresent15, Core_in_23, flit_22_23, dummy_input_23_South, flit_33_23, flit_13_23, Core_Credit_in_23, Credit_22_23, dummy_Credit_in_23_South, Credit_33_23, Credit_13_23, Core_Credit_out_23, Credit_23_22, dummy_Credit_out_23_South, Credit_23_33, Credit_23_13, Core_out_23, flit_23_22, dummy_output_23_South, flit_23_33, flit_23_13);
		Router_33 = new router("Router16");
		(*Router_33)(clock, XPresent16, YPresent16, Core_in_33, flit_32_33, dummy_input_33_South, dummy_input_33_East, flit_23_33, Core_Credit_in_33, Credit_32_33, dummy_Credit_in_33_South, dummy_Credit_in_33_East, Credit_23_33, Core_Credit_out_33, Credit_33_32, dummy_Credit_out_33_South, dummy_Credit_out_33_East, Credit_33_23, Core_out_33, flit_33_32, dummy_output_33_South, dummy_output_33_East, flit_33_23);
	}
	~router_16(){
		delete Router_00; delete Router_10; delete Router_20; delete Router_30;
		delete Router_01; delete Router_11; delete Router_21; delete Router_31;
		delete Router_02; delete Router_12; delete Router_22; delete Router_32;
		delete Router_03; delete Router_13; delete Router_23; delete Router_33;
	}
};