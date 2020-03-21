#include "systemc.h"

enum vm5_state {
	IDLELocal, LocalN, LocalS, LocalE, LocalW
};
enum vm6_state {
	IDLEUP=5, UpCore, UpS, UpE, UpW
};
enum vm7_state {
	IDLEDN=10, DNCore, DNN, DNE, DNW
};
enum vm8_state {
	IDLER=15, RCore, RN, RS, RW
};
enum vm9_state {
	IDLELeft=20, LCore, LN, LS, LE
};

SC_MODULE(Switching_Allocator){
	sc_in_clk clock;
	sc_in<bool> credit_inL, credit_inN, credit_inS, credit_inE, credit_inW;
	sc_in<bool> MoveUpL, MoveDownL, MoveRightL, MoveLeftL;
	sc_in<bool> MoveCoreN, MoveDownN, MoveRightN, MoveLeftN;
	sc_in<bool> MoveCoreS, MoveUpS, MoveRightS, MoveLeftS;
	sc_in<bool> MoveCoreE, MoveUpE, MoveDownE, MoveLeftE;
	sc_in<bool> MoveCoreW, MoveUpW, MoveDownW, MoveRightW;

	sc_out<sc_bv<4> > NSEWtoL;
	sc_out<sc_bv<4> > LSEWtoN;
	sc_out<sc_bv<4> > LNEWtoS;
	sc_out<sc_bv<4> > LNSWtoE;
	sc_out<sc_bv<4> > LNSEtoW;
	sc_out<bool> Data_RequestL, Data_RequestN, Data_RequestS, Data_RequestE, Data_RequestW;

	sc_signal<bool> Data_RequestLN, Data_RequestLS, Data_RequestLE, Data_RequestLW;
	sc_signal<bool> Data_RequestNL, Data_RequestNS, Data_RequestNE, Data_RequestNW;
	sc_signal<bool> Data_RequestSL, Data_RequestSN, Data_RequestSE, Data_RequestSW;
	sc_signal<bool> Data_RequestEL, Data_RequestEN, Data_RequestES, Data_RequestEW;
	sc_signal<bool> Data_RequestWL, Data_RequestWN, Data_RequestWS, Data_RequestWE;

	sc_uint<3> countL = 6, countN = 6, countS = 6, countE = 6, countW = 6;

	sc_signal<vm5_state>state_signalL;
	sc_signal<vm5_state>next_stateL; //Local ouput state
	sc_signal<vm6_state>state_signalUp;
	sc_signal<vm6_state>next_stateUP; //UP ouput state
	sc_signal<vm7_state>state_signalDN;
	sc_signal<vm7_state>next_stateDN; //DN ouput state
	sc_signal<vm8_state>state_signalRight;
	sc_signal<vm8_state>next_stateRight; //Right ouput state
	sc_signal<vm9_state>state_signalLeft;
	sc_signal<vm9_state> next_stateLeft; //Left ouput state

	sc_trace_file *wf;

	void getnextstateL();
	void getnextstateUP();
	void getnextstateDN();
	void getnextstateRight();
	void getnextstateLeft();
	void setnextstate();
	void outputL();
	void outputUP();
	void outputDN();
	void outputRight();
	void outputLeft();
	void DataRequest();

	SC_CTOR(Switching_Allocator){
		wf = sc_create_vcd_trace_file("Switching_Allocator");
		sc_trace(wf, clock, "clock");
		sc_trace(wf, credit_inL, "credit_inL");
		sc_trace(wf, credit_inN, "credit_inN");
		sc_trace(wf, credit_inS, "credit_inS");
		sc_trace(wf, credit_inE, "credit_inE");
		sc_trace(wf, credit_inW, "credit_inW");

		sc_trace(wf, MoveUpL, "MoveUpL");
		sc_trace(wf, MoveDownL, "MoveDownL");
		sc_trace(wf, MoveRightL, "MoveRightL");
		sc_trace(wf, MoveLeftL, " MoveLeftL");

		sc_trace(wf, MoveDownN, "MoveDownN");
		sc_trace(wf, MoveRightN, "MoveRightN");
		sc_trace(wf, MoveLeftN, "MoveLeftN");
		sc_trace(wf, MoveCoreN, " MoveCoreN");

		sc_trace(wf, MoveUpS, "MoveUpSL");
		sc_trace(wf, MoveRightS, "MoveRightS");
		sc_trace(wf, MoveLeftS, "MoveLeftS");
		sc_trace(wf, MoveCoreS, "MoveCoreS");

		sc_trace(wf, MoveUpE, "MoveUpE");
		sc_trace(wf, MoveDownE, "MoveDownE");
		sc_trace(wf, MoveLeftE, "MoveLeftE");
		sc_trace(wf, MoveCoreE, " MoveCoreE");

		sc_trace(wf, MoveUpW, "MoveUpW");
		sc_trace(wf, MoveDownW, "MoveDownW");
		sc_trace(wf, MoveRightW, "MoveRightW");
		sc_trace(wf, MoveCoreW, "MoveCoreW");

		sc_trace(wf, NSEWtoL, "NSEWtoL");
		sc_trace(wf, LSEWtoN, "LSEWtoN");
		sc_trace(wf, LNEWtoS, "LNEWtoS");
		sc_trace(wf, LNSWtoE, "LNSWtoE");
		sc_trace(wf, LNSEtoW, "LNSEtoW");

		sc_trace(wf, Data_RequestL, "Data_RequestL");
		sc_trace(wf, Data_RequestN, "Data_RequestN");
		sc_trace(wf, Data_RequestS, "Data_RequestS");
		sc_trace(wf, Data_RequestE, "Data_RequestE");
		sc_trace(wf, Data_RequestW, "Data_RequestW");

		sc_trace(wf, state_signalL, "state_signalL");
		sc_trace(wf, state_signalUp, "state_signalUp");
		sc_trace(wf, state_signalDN, "state_signalDN");
		sc_trace(wf, state_signalRight, "state_signalRight");
		sc_trace(wf, state_signalLeft, "state_signalLeft");

		SC_METHOD(getnextstateL);
		sensitive << state_signalL << MoveCoreN << MoveCoreS << MoveCoreE << MoveCoreW;// << countL;
		SC_METHOD(getnextstateUP);
		sensitive << state_signalUp << MoveUpL << MoveUpS << MoveUpE << MoveUpW;// << countN;
		SC_METHOD(getnextstateDN);
		sensitive << state_signalDN << MoveDownL << MoveDownN << MoveDownE << MoveDownW;// << countS;
		SC_METHOD(getnextstateRight);
		sensitive << state_signalRight << MoveRightL << MoveRightN << MoveRightS << MoveRightW;// << countE;
		SC_METHOD(getnextstateLeft);
		sensitive << state_signalLeft << MoveLeftL << MoveLeftN << MoveLeftS << MoveLeftE;// << countW;
		SC_METHOD(setnextstate);
		sensitive << clock.neg();
		SC_METHOD(outputL);
		sensitive << state_signalL;
		SC_METHOD(outputUP);
		sensitive << state_signalUp;
		SC_METHOD(outputDN);
		sensitive << state_signalDN;
		SC_METHOD(outputRight);
		sensitive << state_signalRight;
		SC_METHOD(outputLeft);
		sensitive << state_signalLeft;
		SC_METHOD(DataRequest);
		sensitive << Data_RequestLN << Data_RequestLS << Data_RequestLE << Data_RequestLW << Data_RequestNL << Data_RequestNS << Data_RequestNE << Data_RequestNW << Data_RequestSL << Data_RequestSN << Data_RequestSE << Data_RequestSW << Data_RequestEL << Data_RequestEN << Data_RequestES << Data_RequestEW << Data_RequestWL << Data_RequestWN << Data_RequestWS << Data_RequestWE;
	}
	~Switching_Allocator(){
		sc_close_vcd_trace_file(wf);
	}
};