#include "Input_port.h"
#include "crossbar_switch.h"
#include "routing_logic.h"
#include "Switching_Allocator.h"
#include "delay_element.h"


SC_MODULE(router){

	sc_in_clk clock;
	sc_in<sc_bv<2> > XPresent, YPresent;
	sc_in<sc_bv<32> > input_flit_Local, input_flit_North, input_flit_South, input_flit_East, input_flit_West;
	sc_in<bool> credit_inL, credit_inN, credit_inS, credit_inE, credit_inW;
	sc_out<bool> Credit_outL, Credit_outN, Credit_outS, Credit_outE, Credit_outW;
	sc_out<sc_bv<32> > Local_output, North_output, South_output, East_output, West_output;

	sc_signal<sc_bv<32> > output_flitL, output_flitN, output_flitS, output_flitE, output_flitW;
	sc_signal<sc_bv<32> > Output_flitL_delayed, Output_flitN_delayed, Output_flitS_delayed, Output_flitE_delayed, Output_flitW_delayed;
	sc_signal<bool> Data_RequestL, Data_RequestN, Data_RequestS, Data_RequestE, Data_RequestW;
	sc_signal<bool> Data_RequestLR, Data_RequestNR, Data_RequestSR, Data_RequestER, Data_RequestWR;
	sc_signal<bool> MoveUpL, MoveDownL, MoveRightL, MoveLeftL, MoveDownN, MoveRightN, MoveLeftN, MoveCoreN, MoveUpS, MoveRightS, MoveLeftS, MoveCoreS, MoveUpE, MoveDownE, MoveLeftE, MoveCoreE, MoveUpW, MoveDownW, MoveRightW, MoveCoreW;
	sc_signal<sc_bv<4> > NSEWtoL, LSEWtoN, LNEWtoS, LNSWtoE, LNSEtoW;

	sc_signal<sc_bv<2> > Type_headerL, Type_headerN, Type_headerS, Type_headerE, Type_headerW;
	sc_signal<sc_bv<2> > XDestinationL, YDestinationL, XDestinationN, YDestinationN, XDestinationS, YDestinationS, XDestinationE, YDestinationE, XDestinationW, YDestinationW;
	sc_bv<32> outputL, outputN, outputS, outputE, outputW;

	Input_port *input_portL, *input_portN, *input_portS, *input_portE, *input_portW;
	crossbar_switch *crossbar;
	routing_logic *routing;
	Switching_Allocator *Switching;
	delay_element *delayL, *delayN, *delayS, *delayE, *delayW;
	

	void output();

	SC_CTOR(router){
		SC_METHOD(output);
		sensitive << output_flitL << output_flitN << output_flitS << output_flitE << output_flitW;

		input_portL = new Input_port("inputL");
		(*input_portL)(clock, Data_RequestL, Data_RequestLR, input_flit_Local, Credit_outL, output_flitL);
		input_portN = new Input_port("inputN");
		(*input_portN)(clock, Data_RequestN, Data_RequestNR, input_flit_North, Credit_outN, output_flitN);
		input_portS = new Input_port("inputS");
		(*input_portS)(clock, Data_RequestS, Data_RequestSR, input_flit_South, Credit_outS, output_flitS);
		input_portE = new Input_port("inputE");
		(*input_portE)(clock, Data_RequestE, Data_RequestER, input_flit_East, Credit_outE, output_flitE);
		input_portW = new Input_port("inputW");
		(*input_portW)(clock, Data_RequestW, Data_RequestWR, input_flit_West, Credit_outW, output_flitW);
		delayL = new delay_element("delayL");
		(*delayL)(clock, output_flitL, Output_flitL_delayed);
		delayN = new delay_element("delayN");
		(*delayN)(clock, output_flitN, Output_flitN_delayed);
		delayS = new delay_element("delayS");
		(*delayS)(clock, output_flitS, Output_flitS_delayed);
		delayE = new delay_element("delayE");
		(*delayE)(clock, output_flitE, Output_flitE_delayed);
		delayW = new delay_element("delayW");
		(*delayW)(clock, output_flitW, Output_flitW_delayed);
		crossbar = new crossbar_switch("crossbar1");
		(*crossbar)(clock, Output_flitL_delayed, Output_flitN_delayed, Output_flitS_delayed, Output_flitE_delayed, Output_flitW_delayed, NSEWtoL, LSEWtoN, LNEWtoS, LNSWtoE, LNSEtoW, Local_output, North_output, South_output, East_output, West_output);
		routing = new routing_logic("routing1");
		(*routing)(clock, Type_headerL, Type_headerN, Type_headerS, Type_headerE, Type_headerW, XDestinationL, YDestinationL, XDestinationN, YDestinationN, XDestinationS, YDestinationS, XDestinationE, YDestinationE, XDestinationW, YDestinationW, XPresent, YPresent, MoveUpL, MoveDownL, MoveRightL, MoveLeftL, MoveDownN, MoveRightN, MoveLeftN, MoveCoreN, MoveUpS, MoveRightS, MoveLeftS, MoveCoreS, MoveUpE, MoveDownE, MoveLeftE, MoveCoreE, MoveUpW, MoveDownW, MoveRightW, MoveCoreW, Data_RequestLR, Data_RequestNR, Data_RequestSR, Data_RequestER, Data_RequestWR);
		Switching = new Switching_Allocator("Switching1");
		(*Switching)(clock, credit_inL, credit_inN, credit_inS, credit_inE, credit_inW, MoveUpL, MoveDownL, MoveRightL, MoveLeftL, MoveCoreN, MoveDownN, MoveRightN, MoveLeftN, MoveCoreS, MoveUpS, MoveRightS, MoveLeftS, MoveCoreE, MoveUpE, MoveDownE, MoveLeftE, MoveCoreW, MoveUpW, MoveDownW, MoveRightW, NSEWtoL, LSEWtoN, LNEWtoS, LNSWtoE, LNSEtoW, Data_RequestL, Data_RequestN, Data_RequestS, Data_RequestE, Data_RequestW);
	}
	~router(){
		delete input_portL;
		delete input_portN;
		delete input_portS;
		delete input_portE;
		delete input_portW;
		delete crossbar;
		delete routing;
		delete Switching;
	}
};