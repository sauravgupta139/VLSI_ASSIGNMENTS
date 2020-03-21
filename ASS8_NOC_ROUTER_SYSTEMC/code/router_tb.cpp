#include "router.h"

int sc_main(int argc, char* argv[]) {
	sc_clock  clock("clock", 80, SC_US);
	sc_signal<sc_bv<2> > XPresent, YPresent;
	sc_signal<sc_bv<32> >  input_flit_Local, input_flit_North, input_flit_South, input_flit_East, input_flit_West;
	sc_signal<bool>   credit_inL, credit_inN, credit_inS, credit_inE, credit_inW;
	sc_signal<bool> Credit_outL, Credit_outN, Credit_outS, Credit_outE, Credit_outW;
	sc_signal<sc_bv<32> > Local_output, North_output, South_output, East_output, West_output;

	// Connect the DUT
	router DUT("Router");
	DUT.clock(clock);
	DUT.XPresent(XPresent);
	DUT.YPresent(YPresent);
	DUT.input_flit_Local(input_flit_Local);
	DUT.input_flit_North(input_flit_North);
	DUT.input_flit_South(input_flit_South);
	DUT.input_flit_East(input_flit_East);
	DUT.input_flit_West(input_flit_West);
	DUT.credit_inL(credit_inL);
	DUT.credit_inN(credit_inN);
	DUT.credit_inS(credit_inS);
	DUT.credit_inE(credit_inE);
	DUT.credit_inW(credit_inW);
	DUT.Credit_outL(Credit_outL);
	DUT.Credit_outN(Credit_outN);
	DUT.Credit_outS(Credit_outS);
	DUT.Credit_outE(Credit_outE);
	DUT.Credit_outW(Credit_outW);
	DUT.Local_output(Local_output);
	DUT.North_output(North_output);
	DUT.South_output(South_output);
	DUT.East_output(East_output);
	DUT.West_output(West_output);

	sc_start(0, SC_US);

	// Open VCD file
	sc_trace_file *wf = sc_create_vcd_trace_file("router");
	// Dump the desired signals
	sc_trace(wf, clock, "clock");
	sc_trace(wf, input_flit_Local, "input_flit_Local");
	sc_trace(wf, input_flit_North, "input_flit_North");
	sc_trace(wf, input_flit_South, "input_flit_South");
	sc_trace(wf, input_flit_East, "input_flit_East");
	sc_trace(wf, input_flit_West, "input_flit_West");

	sc_trace(wf, credit_inL, "credit_inL");
	sc_trace(wf, credit_inN, "credit_inN");
	sc_trace(wf, credit_inS, "credit_inS");
	sc_trace(wf, credit_inE, "credit_inE");
	sc_trace(wf, credit_inW, "credit_inW");

	sc_trace(wf, Credit_outL, "Credit_outL");
	sc_trace(wf, Credit_outN, "Credit_outN");
	sc_trace(wf, Credit_outS, "Credit_outS");
	sc_trace(wf, Credit_outE, "Credit_outE");
	sc_trace(wf, Credit_outW, "Credit_outW");
	sc_trace(wf, Local_output, "Local_output");
	sc_trace(wf, North_output, "North_output");
	sc_trace(wf, South_output, "South_output");
	sc_trace(wf, East_output, "East_output");
	sc_trace(wf, West_output, "West_output");

	sc_trace(wf, DUT.Data_RequestL, "DUT.Data_RequestL");
	sc_trace(wf, DUT.Data_RequestN, "DUT.Data_RequestN");
	sc_trace(wf, DUT.Data_RequestS, "DUT.Data_RequestS");
	sc_trace(wf, DUT.Data_RequestE, "DUT.Data_RequestE");
	sc_trace(wf, DUT.Data_RequestW, "DUT.Data_RequestW");

	sc_trace(wf, DUT.output_flitL, "DUT.output_flitL");
	sc_trace(wf, DUT.output_flitN, "DUT.output_flitN");
	sc_trace(wf, DUT.output_flitS, "DUT.output_flitS");
	sc_trace(wf, DUT.output_flitE, "DUT.output_flitE");
	sc_trace(wf, DUT.output_flitW, "DUT.output_flitW");

	/*sc_trace(wf, DUT.MoveUpL, "DUT.MoveUpL");
	sc_trace(wf, DUT.MoveDownL, "DUT.MoveDownL");
	sc_trace(wf, DUT.MoveRightL, "DUT.MoveRightL");
	sc_trace(wf, DUT.MoveLeftL, "DUT.MoveLeftL");
	sc_trace(wf, DUT.MoveDownN, "DUT.MoveDownN");
	sc_trace(wf, DUT.MoveRightN, "DUT.MoveRightN");
	sc_trace(wf, DUT.MoveLeftN, "DUT.MoveLeftN");
	sc_trace(wf, DUT.MoveCoreN, "DUT. MoveCoreN");
	sc_trace(wf, DUT.MoveUpS, "DUT.MoveUpS");
	sc_trace(wf, DUT.MoveRightS, "DUT.MoveRightS");
	sc_trace(wf, DUT.MoveLeftS, "DUT.MoveLeftS");
	sc_trace(wf, DUT.MoveCoreS, "DUT.MoveCoreS");
	sc_trace(wf, DUT.MoveUpE, "DUT.MoveUpE");
	sc_trace(wf, DUT.MoveDownE, "DUT.MoveDownE");
	sc_trace(wf, DUT.MoveLeftE, "DUT.MoveLeftE");
	sc_trace(wf, DUT.MoveCoreE, "DUT.MoveCoreE");
	sc_trace(wf, DUT.MoveUpW, "DUT.MoveUpW");
	sc_trace(wf, DUT.MoveDownW, "DUT.MoveDownW");
	sc_trace(wf, DUT.MoveRightW, "DUT.MoveRightW");
	sc_trace(wf, DUT.MoveCoreW, "DUT.MoveCoreW");*/

	sc_trace(wf, DUT.NSEWtoL, "DUT.NSEWtoL");
	sc_trace(wf, DUT.LSEWtoN, "DUT.LSEWtoN");
	sc_trace(wf, DUT.LNEWtoS, "DUT.LNEWtoS");
	sc_trace(wf, DUT.LNSWtoE, "DUT.LNSWtoE");
	sc_trace(wf, DUT.LNSEtoW, "DUT.LNSEtoW");

	sc_trace(wf, DUT.Type_headerL, "DUT.Type_headerL");
	sc_trace(wf, DUT.Type_headerN, "DUT.Type_headerN");
	sc_trace(wf, DUT.Type_headerS, "DUT.Type_headerS");
	sc_trace(wf, DUT.Type_headerE, "DUT.Type_headerE");
	sc_trace(wf, DUT.Type_headerW, "DUT.Type_headerW");

	sc_trace(wf, DUT.XDestinationL, "DUT.XDestinationL");
	sc_trace(wf, DUT.XDestinationN, "DUT.XDestinationN");
	sc_trace(wf, DUT.XDestinationS, "DUT.XDestinationS");
	sc_trace(wf, DUT.XDestinationE, "DUT.XDestinationE");
	sc_trace(wf, DUT.XDestinationW, "DUT.XDestinationW");

	sc_trace(wf, DUT.YDestinationL, "DUT.YDestinationL");
	sc_trace(wf, DUT.YDestinationN, "DUT.YDestinationN");
	sc_trace(wf, DUT.YDestinationS, "DUT.YDestinationS");
	sc_trace(wf, DUT.YDestinationE, "DUT.YDestinationE");
	sc_trace(wf, DUT.YDestinationW, "DUT.YDestinationW");

	// Initialize all variables
	XPresent = "01";
	YPresent = "01";
	credit_inE = 0;
	credit_inL = 0;
	credit_inN = 0;
	credit_inS = 0;
	credit_inW = 0;

	input_flit_Local = 0x40FABCDE; //from local to east
	input_flit_West = 0x404ABCDE; //from west to north
	input_flit_South = 0x404FFFAA; //from south to north
	input_flit_East = 0x49612345; //from east to south
	input_flit_North = 0x00000000;

	sc_start(80, SC_US);

	input_flit_Local = 0x856789AB;
	input_flit_West = 0x865677AC;
	input_flit_South = 0x804FBBAA;
	input_flit_East = 0x88912345;
	input_flit_North = 0x447ABEFA; //from north to south

	sc_start(80, SC_US);

	input_flit_Local = 0x91234567;
	input_flit_West = 0x912377AC;
	input_flit_South = 0x945FFAAA;
	input_flit_East = 0x96123457;
	input_flit_North = 0x884ABAFF;

	sc_start(80, SC_US);

	input_flit_Local = 0xAABCDEF1;
	input_flit_West = 0xA67897AC;
	input_flit_South = 0xC012FBCA;
	input_flit_East = 0xCAAFF123;
	input_flit_North = 0x944ABAAA;

	credit_inN = 1;
	credit_inE = 1;
	credit_inS = 1;

	sc_start(80, SC_US);

	input_flit_Local = 0xB3456789;
	input_flit_West = 0xB65677AC;
	input_flit_South = 0x00000000;
	input_flit_East = 0x00000000;
	input_flit_North = 0x00000000;

	sc_start(80, SC_US);

	input_flit_Local = 0xC7891412;
	input_flit_West = 0xC65677AC;

	sc_start(80, SC_US);

	input_flit_Local = 0x00000000;
	input_flit_West = 0x00000000;

	sc_start(80, SC_US);
	input_flit_Local = 0x406AB567;

	sc_start(80, SC_US);

	input_flit_Local = 0x896AB567;

	sc_start(80, SC_US);

	credit_inE = 0;
	input_flit_Local = 0xC1230000;

	sc_start(80, SC_US);

	input_flit_Local = 0x00000000;

	sc_start(80, SC_US);

	credit_inS = 0;
	sc_start(240, SC_US);
	credit_inN = 0;
	
	sc_start(600, SC_US);

	sc_close_vcd_trace_file(wf);
	return 0;// Terminate simulation

}