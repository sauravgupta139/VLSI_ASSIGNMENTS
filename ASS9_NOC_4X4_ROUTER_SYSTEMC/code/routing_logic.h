#include "systemc.h"

enum vm_state {
	IDLEL = 25, MoveNorthL, MoveSouthL, MoveEastL, MoveWestL
};
enum vm1_state {
	IDLEN = 30, MoveSouthN, MoveEastN, MoveWestN, MoveLocalN
};
enum vm2_state {
	IDLES = 35, MoveNorthS, MoveEastS, MoveWestS, MoveLocalS
};
enum vm3_state {
	IDLEE = 40, MoveNorthE, MoveSouthE, MoveWestE, MoveLocalE
};
enum vm4_state {
	IDLEW = 45, MoveNorthW, MoveSouthW, MoveEastW, MoveLocalW
};

SC_MODULE(routing_logic){
	sc_in_clk clock;
	sc_in<sc_bv<2> > Type_headerL, Type_headerN, Type_headerS, Type_headerE, Type_headerW;
	sc_in<sc_bv<2> > XDestinationL, YDestinationL, XDestinationN, YDestinationN, XDestinationS, YDestinationS, XDestinationE, YDestinationE, XDestinationW, YDestinationW;
	sc_in<sc_bv<2> > XPresent, YPresent;
	sc_out<bool> MoveUpL, MoveDownL, MoveRightL, MoveLeftL;
	sc_out<bool> MoveDownN, MoveRightN, MoveLeftN, MoveCoreN;
	sc_out<bool> MoveUpS, MoveRightS, MoveLeftS, MoveCoreS;
	sc_out<bool> MoveUpE, MoveDownE, MoveLeftE, MoveCoreE;
	sc_out<bool> MoveUpW, MoveDownW, MoveRightW, MoveCoreW;
	sc_out<bool> Data_RequestL, Data_RequestN, Data_RequestS, Data_RequestE, Data_RequestW;
	sc_int<3> XdiffL, YdiffL, XdiffN, YdiffN, XdiffS, YdiffS, XdiffE, YdiffE, XdiffW, YdiffW;
	sc_uint<2> XPres, YPres;
	sc_uint<2> XDesL, YDesL, XDesN, YDesN, XDesS, YDesS, XDesE, YDesE, XDesW, YDesW;

	sc_signal<vm_state>state_signalL;
	sc_signal<vm_state>next_stateL; //Local input states
	sc_signal<vm1_state>state_signalN;
	sc_signal<vm1_state>next_stateN; //North input states
	sc_signal<vm2_state>state_signalS;
	sc_signal<vm2_state>next_stateS; //South input states
	sc_signal<vm3_state>state_signalE;
	sc_signal<vm3_state>next_stateE; //East input states
	sc_signal<vm4_state>state_signalW;
	sc_signal<vm4_state>next_stateW; //West input states

	sc_trace_file *fp;

	void getnextstateL();
	void getnextstateN();
	void getnextstateS();
	void getnextstateE();
	void getnextstateW();
	void setnextstate();
	void outputL();
	void outputN();
	void outputS();
	void outputE();
	void outputW();
	void address();
	void Data_Request();

	SC_CTOR(routing_logic){
		fp = sc_create_vcd_trace_file("routing_logic");
		sc_trace(fp, clock, "clock");
		sc_trace(fp, Type_headerL, "Type_headerL");
		sc_trace(fp, Type_headerN, "Type_headerN");
		sc_trace(fp, Type_headerS, "Type_headerS");
		sc_trace(fp, Type_headerE, "Type_headerE");
		sc_trace(fp, Type_headerW, "Type_headerW");
		sc_trace(fp, XDestinationL, "XDestinationL");
		sc_trace(fp, YDestinationL, "YDestinationL");
		sc_trace(fp, XDestinationN, "XDestinationN");
		sc_trace(fp, YDestinationN, "YDestinationN");
		sc_trace(fp, XDestinationS, "XDestinationS");
		sc_trace(fp, YDestinationS, "YDestinationS");
		sc_trace(fp, XDestinationE, "XDestinationE");
		sc_trace(fp, YDestinationE, "YDestinationE");
		sc_trace(fp, XDestinationW, "XDestinationW");
		sc_trace(fp, YDestinationW, " YDestinationW");

		sc_trace(fp, MoveUpL, "MoveUpL");
		sc_trace(fp, MoveDownL, "MoveDownL");
		sc_trace(fp, MoveRightL, "MoveRightL");
		sc_trace(fp, MoveLeftL, " MoveLeftL");

		sc_trace(fp, MoveDownN, "MoveDownN");
		sc_trace(fp, MoveRightN, "MoveRightN");
		sc_trace(fp, MoveLeftN, "MoveLeftN");
		sc_trace(fp, MoveCoreN, " MoveCoreN");

		sc_trace(fp, MoveUpS, "MoveUpS");
		sc_trace(fp, MoveRightS, "MoveRightS");
		sc_trace(fp, MoveLeftS, "MoveLeftS");
		sc_trace(fp, MoveCoreS, "MoveCoreS");

		sc_trace(fp, MoveUpE, "MoveUpE");
		sc_trace(fp, MoveDownE, "MoveDownE");
		sc_trace(fp, MoveLeftE, "MoveLeftE");
		sc_trace(fp, MoveCoreE, " MoveCoreE");

		sc_trace(fp, MoveUpW, "MoveUpW");
		sc_trace(fp, MoveDownW, "MoveDownW");
		sc_trace(fp, MoveRightW, "MoveRightW");
		sc_trace(fp, MoveCoreW, "MoveCoreW");

		sc_trace(fp, XDesE, "XDesE");
		sc_trace(fp, YDesE, "YDesE");
		sc_trace(fp, XdiffE, "XdiffE");
		sc_trace(fp, YdiffE, "YdiffE");
		sc_trace(fp, XDesL, "XDesL");
		sc_trace(fp, YDesL, "YDesL");
		sc_trace(fp, XdiffL, "XdiffL");
		sc_trace(fp, YdiffL, "YdiffL");
		sc_trace(fp, XdiffN, "XdiffN");
		sc_trace(fp, YdiffN, "YdiffN");


		SC_METHOD(getnextstateL);
		sensitive << state_signalL << Type_headerL << XDestinationL << YDestinationL;
		SC_METHOD(getnextstateN);
		sensitive << state_signalN << Type_headerN << XDestinationN << YDestinationN;
		SC_METHOD(getnextstateS);
		sensitive << state_signalS << Type_headerS << XDestinationS << YDestinationS;
		SC_METHOD(getnextstateE);
		sensitive << state_signalE << Type_headerE << XDestinationE << YDestinationE;
		SC_METHOD(getnextstateW);
		sensitive << state_signalW << Type_headerW << XDestinationE << YDestinationE;
		SC_METHOD(setnextstate);
		sensitive << clock.pos();
		SC_METHOD(outputL);
		sensitive << state_signalL;
		SC_METHOD(outputN);
		sensitive << state_signalN;
		SC_METHOD(outputS);
		sensitive << state_signalS;
		SC_METHOD(outputE);
		sensitive << state_signalE;
		SC_METHOD(outputW);
		sensitive << state_signalW;
		SC_METHOD(Data_Request);
		sensitive << clock.neg();
	}
	~routing_logic(){
		sc_close_vcd_trace_file(fp);
	}
};