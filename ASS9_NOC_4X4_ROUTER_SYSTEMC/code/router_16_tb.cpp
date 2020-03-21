#include "router_16.h"

int sc_main(int argc, char* argv[]) {
	sc_clock  clock("clock", 80, SC_US);
	sc_signal<sc_bv<2> > XPresent1, YPresent1, XPresent2, YPresent2, XPresent3, YPresent3, XPresent4, YPresent4, XPresent5, YPresent5, XPresent6, YPresent6, XPresent7, YPresent7, XPresent8, YPresent8, XPresent9, YPresent9, XPresent10, YPresent10, XPresent11, YPresent11, XPresent12, YPresent12, XPresent13, YPresent13, XPresent14, YPresent14, XPresent15, YPresent15, XPresent16, YPresent16;
	sc_signal<sc_bv<32> > Core_in_00, Core_in_10, Core_in_20, Core_in_30;
	sc_signal<sc_bv<32> > Core_in_01, Core_in_11, Core_in_21, Core_in_31;
	sc_signal<sc_bv<32> > Core_in_02, Core_in_12, Core_in_22, Core_in_32;
	sc_signal<sc_bv<32> > Core_in_03, Core_in_13, Core_in_23, Core_in_33;

	sc_signal<bool> Core_Credit_in_00, Core_Credit_in_10, Core_Credit_in_20, Core_Credit_in_30;
	sc_signal<bool> Core_Credit_in_01, Core_Credit_in_11, Core_Credit_in_21, Core_Credit_in_31;
	sc_signal<bool> Core_Credit_in_02, Core_Credit_in_12, Core_Credit_in_22, Core_Credit_in_32;
	sc_signal<bool> Core_Credit_in_03, Core_Credit_in_13, Core_Credit_in_23, Core_Credit_in_33;

	sc_signal<sc_bv<32> > Core_out_00, Core_out_10, Core_out_20, Core_out_30;
	sc_signal<sc_bv<32> > Core_out_01, Core_out_11, Core_out_21, Core_out_31;
	sc_signal<sc_bv<32> > Core_out_02, Core_out_12, Core_out_22, Core_out_32;
	sc_signal<sc_bv<32> > Core_out_03, Core_out_13, Core_out_23, Core_out_33;

	sc_signal<bool> Core_Credit_out_00, Core_Credit_out_10, Core_Credit_out_20, Core_Credit_out_30;
	sc_signal<bool> Core_Credit_out_01, Core_Credit_out_11, Core_Credit_out_21, Core_Credit_out_31;
	sc_signal<bool> Core_Credit_out_02, Core_Credit_out_12, Core_Credit_out_22, Core_Credit_out_32;
	sc_signal<bool> Core_Credit_out_03, Core_Credit_out_13, Core_Credit_out_23, Core_Credit_out_33;

	// Connect the DUT
	router_16 DUT("Wave");
	DUT << clock << XPresent1 << YPresent1 << XPresent2 << YPresent2 << XPresent3 << YPresent3 << XPresent4 << YPresent4 << XPresent5 << YPresent5 << XPresent6 << YPresent6 << XPresent7 << YPresent7 << XPresent8 << YPresent8 << XPresent9 << YPresent9 << XPresent10 << YPresent10 << XPresent11 << YPresent11 << XPresent12 << YPresent12 << XPresent13 << YPresent13 << XPresent14 << YPresent14 << XPresent15 << YPresent15 << XPresent16 << YPresent16<< Core_in_00 << Core_in_10 << Core_in_20 << Core_in_30
		<< Core_in_01 << Core_in_11 << Core_in_21 << Core_in_31
		<< Core_in_02 << Core_in_12 << Core_in_22 << Core_in_32
		<< Core_in_03 << Core_in_13 << Core_in_23 << Core_in_33
		<< Core_Credit_in_00 << Core_Credit_in_10 << Core_Credit_in_20 << Core_Credit_in_30
		<< Core_Credit_in_01 << Core_Credit_in_11 << Core_Credit_in_21 << Core_Credit_in_31
		<< Core_Credit_in_02 << Core_Credit_in_12 << Core_Credit_in_22 << Core_Credit_in_32
		<< Core_Credit_in_03 << Core_Credit_in_13 << Core_Credit_in_23 << Core_Credit_in_33
		<< Core_out_00 << Core_out_10 << Core_out_20 << Core_out_30
		<< Core_out_01 << Core_out_11 << Core_out_21 << Core_out_31
		<< Core_out_02 << Core_out_12 << Core_out_22 << Core_out_32
		<< Core_out_03 << Core_out_13 << Core_out_23 << Core_out_33
		<< Core_Credit_out_00 << Core_Credit_out_10 << Core_Credit_out_20 << Core_Credit_out_30
		<< Core_Credit_out_01 << Core_Credit_out_11 << Core_Credit_out_21 << Core_Credit_out_31
		<< Core_Credit_out_02 << Core_Credit_out_12 << Core_Credit_out_22 << Core_Credit_out_32
		<< Core_Credit_out_03 << Core_Credit_out_13 << Core_Credit_out_23 << Core_Credit_out_33;

	sc_start(0, SC_US);

	// Open VCD file
	sc_trace_file *wf = sc_create_vcd_trace_file("wave");
	// Dump the desired signals
	sc_trace(wf, clock, "clock");
	sc_trace(wf, Core_in_00, "Core_in_00");
	sc_trace(wf, Core_in_10, "Core_in_10");
	sc_trace(wf, Core_in_20, "Core_in_20");
	sc_trace(wf, Core_in_30, "Core_in_30");

	sc_trace(wf, Core_in_01, "Core_in_01");
	sc_trace(wf, Core_in_11, "Core_in_11");
	sc_trace(wf, Core_in_21, "Core_in_21");
	sc_trace(wf, Core_in_31, "Core_in_31");

	sc_trace(wf, Core_in_02, "Core_in_02");
	sc_trace(wf, Core_in_12, "Core_in_12");
	sc_trace(wf, Core_in_22, "Core_in_22");
	sc_trace(wf, Core_in_32, "Core_in_32");

	sc_trace(wf, Core_in_03, "Core_in_03");
	sc_trace(wf, Core_in_13, "Core_in_13");
	sc_trace(wf, Core_in_23, "Core_in_23");
	sc_trace(wf, Core_in_33, "Core_in_33");

	sc_trace(wf, Core_Credit_in_00, "Core_Credit_in_00");
	sc_trace(wf, Core_Credit_in_10, "Core_Credit_in_10");
	sc_trace(wf, Core_Credit_in_20, "Core_Credit_in_20");
	sc_trace(wf, Core_Credit_in_30, "Core_Credit_in_30");

	sc_trace(wf, Core_Credit_in_01, "Core_Credit_in_01");
	sc_trace(wf, Core_Credit_in_11, "Core_Credit_in_11");
	sc_trace(wf, Core_Credit_in_21, "Core_Credit_in_21");
	sc_trace(wf, Core_Credit_in_31, "Core_Credit_in_31");

	sc_trace(wf, Core_Credit_in_02, "Core_Credit_in_02");
	sc_trace(wf, Core_Credit_in_12, "Core_Credit_in_12");
	sc_trace(wf, Core_Credit_in_22, "Core_Credit_in_22");
	sc_trace(wf, Core_Credit_in_32, "Core_Credit_in_32");

	sc_trace(wf, Core_Credit_in_03, "Core_Credit_in_03");
	sc_trace(wf, Core_Credit_in_13, "Core_Credit_in_13");
	sc_trace(wf, Core_Credit_in_23, "Core_Credit_in_23");
	sc_trace(wf, Core_Credit_in_33, "Core_Credit_in_33");

	sc_trace(wf, Core_out_00, "Core_out_00");
	sc_trace(wf, Core_out_10, "Core_out_10");
	sc_trace(wf, Core_out_20, "Core_out_20");
	sc_trace(wf, Core_out_30, "Core_out_30");

	sc_trace(wf, Core_out_01, "Core_out_01");
	sc_trace(wf, Core_out_11, "Core_out_11");
	sc_trace(wf, Core_out_21, "Core_out_21");
	sc_trace(wf, Core_out_31, "Core_out_31");

	sc_trace(wf, Core_out_02, "Core_out_02");
	sc_trace(wf, Core_out_12, "Core_out_12");
	sc_trace(wf, Core_out_22, "Core_out_22");
	sc_trace(wf, Core_out_32, "Core_out_32");

	sc_trace(wf, Core_out_03, "Core_out_03");
	sc_trace(wf, Core_out_13, "Core_out_13");
	sc_trace(wf, Core_out_23, "Core_out_23");
	sc_trace(wf, Core_out_33, "Core_out_33");

	sc_trace(wf, Core_Credit_out_00, "Core_Credit_out_00");
	sc_trace(wf, Core_Credit_out_10, "Core_Credit_out_10");
	sc_trace(wf, Core_Credit_out_20, "Core_Credit_out_20");
	sc_trace(wf, Core_Credit_out_30, "Core_Credit_out_30");

	sc_trace(wf, Core_Credit_out_01, "Core_Credit_out_01");
	sc_trace(wf, Core_Credit_out_11, "Core_Credit_out_11");
	sc_trace(wf, Core_Credit_out_21, "Core_Credit_out_21");
	sc_trace(wf, Core_Credit_out_31, "Core_Credit_out_31");

	sc_trace(wf, Core_Credit_out_02, "Core_Credit_out_02");
	sc_trace(wf, Core_Credit_out_12, "Core_Credit_out_12");
	sc_trace(wf, Core_Credit_out_22, "Core_Credit_out_22");
	sc_trace(wf, Core_Credit_out_32, "Core_Credit_out_32");

	sc_trace(wf, Core_Credit_out_03, "Core_Credit_out_03");
	sc_trace(wf, Core_Credit_out_13, "Core_Credit_out_13");
	sc_trace(wf, Core_Credit_out_23, "Core_Credit_out_23");
	sc_trace(wf, Core_Credit_out_33, "Core_Credit_out_33");

	sc_trace(wf, DUT.flit_00_10, "flit_00_10");
	sc_trace(wf, DUT.flit_10_20, "flit_10_20");
	sc_trace(wf, DUT.flit_20_30, "flit_20_30");
	sc_trace(wf, DUT.flit_30_31, "flit_30_31");
	sc_trace(wf, DUT.flit_31_32, "flit_31_32");
	sc_trace(wf, DUT.flit_32_33, "flit_32_33");
	sc_trace(wf, DUT.flit_11_21, "flit_11_21");
	sc_trace(wf, DUT.flit_21_31, "flit_21_31");

	sc_trace(wf, DUT.Router_31->input_portW->input_flit, "input_flitW");
	sc_trace(wf, DUT.Router_31->input_portW->Virtual_buffer, "Virtual_bufferW");
	sc_trace(wf, DUT.Router_31->input_portW->output_flit, "output_flitW");
	sc_trace(wf, DUT.Router_31->input_portW->Data_Request_routing, "Data_Request_routingW");
	sc_trace(wf, DUT.Router_31->input_portW->Data_Request_switching, "Data_Request_switchingW");
	sc_trace(wf, DUT.Router_31->input_portW->Data_Request, "Data_RequestW");
	sc_trace(wf, DUT.Router_31->routing->MoveDownW, "MoveDownW");
	sc_trace(wf, DUT.Router_31->Switching->Data_RequestSW, "Data_RequestSW");
	sc_trace(wf, DUT.Router_31->Switching->countS, "countS");
	sc_trace(wf, DUT.Router_31->crossbar->West_Input, "West_Input8");
	sc_trace(wf, DUT.Router_31->crossbar->South_output_temp, "South_output_temp8");
	sc_trace(wf, DUT.Router_31->crossbar->South_output, "South_output8");
	sc_trace(wf, DUT.Router_31->crossbar->North_Input, "North_Input8");

	sc_trace(wf, DUT.Router_31->input_portN->input_flit, "input_flitN");
	sc_trace(wf, DUT.Router_31->input_portN->Virtual_buffer, "Virtual_bufferN");
	sc_trace(wf, DUT.Router_31->input_portN->output_flit, "output_flitN");
	sc_trace(wf, DUT.Router_31->input_portN->Data_Request_routing, "Data_Request_routingN");
	sc_trace(wf, DUT.Router_31->input_portN->Data_Request_switching, "Data_Request_switchingN");
	sc_trace(wf, DUT.Router_31->input_portN->Data_Request, "Data_RequestN");
	sc_trace(wf, DUT.Router_31->routing->MoveDownN, "MoveDownN");
	sc_trace(wf, DUT.Router_31->Switching->Data_RequestSN, "Data_RequestSN");

	sc_trace(wf, DUT.Router_32->input_portN->input_flit, "input_flitN12");
	
	sc_trace(wf, DUT.Router_32->input_portN->Virtual_buffer, "Virtual_bufferN12");
	sc_trace(wf, DUT.Router_32->input_portN->output_flit, "output_flitN12");
	sc_trace(wf, DUT.Router_32->input_portN->credit_out, "credit_outN12");
	sc_trace(wf, DUT.Router_32->routing->MoveCoreN, "MoveCoreN12");
	sc_trace(wf, DUT.Router_32->Switching->Data_RequestLN, "Data_RequestLN12");
	sc_trace(wf, DUT.Router_32->crossbar->North_Input, "cross_North_Input");
	sc_trace(wf, DUT.Router_32->crossbar->Local_output_temp, "cross_Local_output_temp");
	sc_trace(wf, DUT.Router_32->crossbar->Local_output, "cross_Local_output");


	

	// Initialize all variables
	XPresent1 = "00"; YPresent1 = "00";
	XPresent2 = "01"; YPresent2 = "00";
	XPresent3 = "10"; YPresent3 = "00";
	XPresent4 = "11"; YPresent4 = "00";
	XPresent5 = "00"; YPresent5 = "01";
	XPresent6 = "01"; YPresent6 = "01"; 
	XPresent7 = "10"; YPresent7 = "01";
	XPresent8 = "11"; YPresent8 = "01";
	XPresent9 = "00"; YPresent9 = "10";
	XPresent10 = "01"; YPresent10 = "10";
	XPresent11 = "10"; YPresent11 = "10";
	XPresent12 = "11"; YPresent12 = "10";
	XPresent13 = "00"; YPresent13 = "11"; 
	XPresent14 = "01"; YPresent14 = "11";
	XPresent15 = "10"; YPresent15 = "11";
	XPresent16 = "11"; YPresent16 = "11";


	Core_in_00 = 0x40FABCDE; //from 00 to 33
	Core_in_03 = 0x43CABCDE; //from 03 to 30
	Core_in_11 = 0x45EFFFAA; //from 11 t0 32
	Core_in_12 = 0x46012345; //from 12 to 00
	Core_in_23 = 0x00000000;

	sc_start(80, SC_US);

	Core_in_00 = 0x856789AB;
	Core_in_03 = 0x865677AC;
	Core_in_11 = 0x804FBBAA;
	Core_in_12 = 0x88912345;
	Core_in_23 = 0x4B2ABEFA; //from 23 to 02

	sc_start(80, SC_US);

	Core_in_00 = 0x91234567;
	Core_in_03 = 0x912377AC;
	Core_in_11 = 0x945FFAAA;
	Core_in_12 = 0x96123457;
	Core_in_23 = 0x884ABAFF;

	sc_start(80, SC_US);

	Core_in_00 = 0xAABCDEF1;
	Core_in_03 = 0xA67897AC;
	Core_in_11 = 0xC012FBCA;
	Core_in_12 = 0xCAAFF123;
	Core_in_23 = 0x944ABAAA;

	sc_start(80, SC_US);

	Core_in_00 = 0xB3456789;
	Core_in_03 = 0xB65677AC;
	Core_in_11 = 0x00000000;
	Core_in_12 = 0x00000000;

	Core_in_23 = 0xC213464A;
	Core_Credit_in_33 = 1;
	Core_Credit_in_32 = 1;
	sc_start(80, SC_US);

	Core_in_00 = 0xC7891412;
	Core_in_03 = 0xC65677AC;
	Core_in_23 = 0x00000000;

	
	sc_start(80, SC_US);

	Core_in_00 = 0x00000000;
	Core_in_03 = 0x00000000;


	sc_start(240, SC_US);


	sc_start(1600, SC_US);
	Core_Credit_in_33 = 0;
	Core_Credit_in_32 = 0;
	sc_start(720, SC_US);

	sc_close_vcd_trace_file(wf);
	return 0;// Terminate simulation

}