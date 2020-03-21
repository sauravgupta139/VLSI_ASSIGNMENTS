#include "Switching_Allocator.h"

void Switching_Allocator::getnextstateL(){
	switch (state_signalL){
	case IDLELocal:
		if (countL != 0) {
			if (MoveCoreN.read() == 1)
				next_stateL = LocalN;
			else if (MoveCoreS.read() == 1)
				next_stateL = LocalS;
			else if (MoveCoreE.read() == 1)
				next_stateL = LocalE;
			else if (MoveCoreW.read() == 1)
				next_stateL = LocalW;
			else
				next_stateL = IDLELocal;
		}
		else
			next_stateL = IDLELocal;
		break;

	case LocalN:
		if (countL != 0){
			if (MoveCoreN.read() == 1)
				next_stateL = LocalN;
			else if (MoveCoreS.read() == 1)
				next_stateL = LocalS;
			else if (MoveCoreE.read() == 1)
				next_stateL = LocalE;
			else if (MoveCoreW.read() == 1)
				next_stateL = LocalW;
			else
				next_stateL = IDLELocal;
		}
		else
			next_stateL = IDLELocal;
		break;

	case LocalS:
		if (countL != 0){
			if (MoveCoreS.read() == 1)
				next_stateL = LocalS;
			else if (MoveCoreN.read() == 1)
				next_stateL = LocalN;
			else if (MoveCoreE.read() == 1)
				next_stateL = LocalE;
			else if (MoveCoreW.read() == 1)
				next_stateL = LocalW;
			else
				next_stateL = IDLELocal;
		}
		else
			next_stateL = IDLELocal;
		break;

	case LocalE:
		if (countL != 0) {
			if (MoveCoreE.read() == 1)
				next_stateL = LocalE;
			else if (MoveCoreN.read() == 1)
				next_stateL = LocalN;
			else if (MoveCoreS.read() == 1)
				next_stateL = LocalS;
			else if (MoveCoreW.read() == 1)
				next_stateL = LocalW;

			else
				next_stateL = IDLELocal;
		}
		else
			next_stateL = IDLELocal;
		break;

	case LocalW:
		if (countL != 0) {
			if (MoveCoreW.read() == 1)
				next_stateL = LocalW;
			else if (MoveCoreN.read() == 1)
				next_stateL = LocalN;
			else if (MoveCoreS.read() == 1)
				next_stateL = LocalS;
			else if (MoveCoreE.read() == 1)
				next_stateL = LocalE;
			else
				next_stateL = IDLELocal;
		}
		else
			next_stateL = IDLELocal;
		break;

	default:
		next_stateL = IDLELocal;
		break;
	}
}

void Switching_Allocator::getnextstateUP(){
	switch (state_signalUp){
	case IDLEUP:
		if (countN != 0){
			if (MoveUpL.read() == 1)
				next_stateUP = UpCore;
			else if (MoveUpS.read() == 1)
				next_stateUP = UpS;
			else if (MoveUpE.read() == 1)
				next_stateUP = UpE;
			else if (MoveUpW.read() == 1)
				next_stateUP = UpW;
			else
				next_stateUP = IDLEUP;
		}
		else
			next_stateUP = IDLEUP;
		break;

	case UpCore:
		if (countN != 0){
			if (MoveUpL.read() == 1)
				next_stateUP = UpCore;
			else if (MoveUpS.read() == 1)
				next_stateUP = UpS;
			else if (MoveUpE.read() == 1)
				next_stateUP = UpE;
			else if (MoveUpW.read() == 1)
				next_stateUP = UpW;
			else
				next_stateUP = IDLEUP;
		}
		else
			next_stateUP = IDLEUP;
		break;

	case UpS:
		if (countN != 0) {
			if (MoveUpS.read() == 1)
				next_stateUP = UpS;
			else if (MoveUpL.read() == 1)
				next_stateUP = UpCore;
			else if (MoveUpE.read() == 1)
				next_stateUP = UpE;
			else if (MoveUpW.read() == 1)
				next_stateUP = UpW;
			else
				next_stateUP = IDLEUP;
		}
		else
			next_stateUP = IDLEUP;
		break;

	case UpE:
		if (countN != 0) {
			if (MoveUpE.read() == 1)
				next_stateUP = UpE;
			else if (MoveUpL.read() == 1)
				next_stateUP = UpCore;
			else if (MoveUpS.read() == 1)
				next_stateUP = UpS;
			else if (MoveUpW.read() == 1)
				next_stateUP = UpW;
			else
				next_stateUP = IDLEUP;
		}
		else
			next_stateUP = IDLEUP;
		break;

	case UpW:
		if (countN != 0){
			if (MoveUpW.read() == 1)
				next_stateUP = UpW;
			else if (MoveUpL.read() == 1)
				next_stateUP = UpCore;
			else if (MoveUpS.read() == 1)
				next_stateUP = UpS;
			else if (MoveUpE.read() == 1)
				next_stateUP = UpE;
			else
				next_stateUP = IDLEUP;
		}
		else
			next_stateUP = IDLEUP;
		break;

	default:
		next_stateUP = IDLEUP;
		break;
	}
}

void Switching_Allocator::getnextstateDN(){
	switch (state_signalDN){
	case IDLEDN:
		if (countS != 0){
			if (MoveDownL.read() == 1)
				next_stateDN = DNCore;
			else if (MoveDownN.read() == 1)
				next_stateDN = DNN;
			else if (MoveDownE.read() == 1)
				next_stateDN = DNE;
			else if (MoveDownW.read() == 1)
				next_stateDN = DNW;
			else
				next_stateDN = IDLEDN;
		}
		else
			next_stateDN = IDLEDN;
		break;

	case DNCore:
		if (countS != 0) {
			if (MoveDownL.read() == 1)
				next_stateDN = DNCore;
			else if (MoveDownN.read() == 1)
				next_stateDN = DNN;
			else if (MoveDownE.read() == 1)
				next_stateDN = DNE;
			else if (MoveDownW.read() == 1)
				next_stateDN = DNW;
			else
				next_stateDN = IDLEDN;
		}
		else
			next_stateDN = IDLEDN;
		break;

	case DNN:
		if (countS != 0){
			if (MoveDownN.read() == 1)
				next_stateDN = DNN;
			else if (MoveDownL.read() == 1)
				next_stateDN = DNCore;
			else if (MoveDownE.read() == 1)
				next_stateDN = DNE;
			else if (MoveDownW.read() == 1)
				next_stateDN = DNW;
			else
				next_stateDN = IDLEDN;
		}
		else
			next_stateDN = IDLEDN;
		break;

	case DNE:
		if (countS != 0) {
			if (MoveDownE.read() == 1)
				next_stateDN = DNE;
			else if (MoveDownL.read() == 1)
				next_stateDN = DNCore;
			else if (MoveDownN.read() == 1)
				next_stateDN = DNN;
			else if (MoveDownW.read() == 1)
				next_stateDN = DNW;
			else
				next_stateDN = IDLEDN;
		}
		else
			next_stateDN = IDLEDN;
		break;

	case DNW:
		if (countS != 0){
			if (MoveDownW.read() == 1)
				next_stateDN = DNW;
			else if (MoveDownL.read() == 1)
				next_stateDN = DNCore;
			else if (MoveDownN.read() == 1)
				next_stateDN = DNN;
			else if (MoveDownE.read() == 1)
				next_stateDN = DNE;
			else
				next_stateDN = IDLEDN;
		}
		else
			next_stateDN = IDLEDN;
		break;

	default:
		next_stateDN = IDLEDN;
		break;
	}
}

void Switching_Allocator::getnextstateRight(){
	switch (state_signalRight){
	case IDLER:
		if (countE != 0) {
			if (MoveRightL.read() == 1)
				next_stateRight = RCore;
			else if (MoveRightN.read() == 1)
				next_stateRight = RN;
			else if (MoveRightS.read() == 1)
				next_stateRight = RS;
			else if (MoveRightW.read() == 1)
				next_stateRight = RW;
			else
				next_stateRight = IDLER;
		}
		else
			next_stateRight = IDLER;
		break;

	case RCore:
		if (countE != 0){
			if (MoveRightL.read() == 1)
				next_stateRight = RCore;
			else if (MoveRightN.read() == 1)
				next_stateRight = RN;
			else if (MoveRightS.read() == 1)
				next_stateRight = RS;
			else if (MoveRightW.read() == 1)
				next_stateRight = RW;
			else
				next_stateRight = IDLER;
		}
		else
			next_stateRight = IDLER;
		break;

	case RN:
		if (countE != 0) {
			if (MoveRightN.read() == 1)
				next_stateRight = RN;
			else if (MoveRightL.read() == 1)
				next_stateRight = RCore;
			else if (MoveRightS.read() == 1)
				next_stateRight = RS;
			else if (MoveRightW.read() == 1)
				next_stateRight = RW;
			else
				next_stateRight = IDLER;
		}
		else
			next_stateRight = IDLER;
		break;

	case RS:
		if (countE != 0){
			if (MoveRightS.read() == 1)
				next_stateRight = RS;
			else if (MoveRightL.read() == 1)
				next_stateRight = RCore;
			else if (MoveRightN.read() == 1)
				next_stateRight = RN;
			else if (MoveRightW.read() == 1)
				next_stateRight = RW;
			else
				next_stateRight = IDLER;
		}
		else
			next_stateRight = IDLER;
		break;

	case RW:
		if (countE != 0) {
			if (MoveRightW.read() == 1)
				next_stateRight = RW;
			else if (MoveRightL.read() == 1)
				next_stateRight = RCore;
			else if (MoveRightN.read() == 1)
				next_stateRight = RN;
			else if (MoveRightS.read() == 1)
				next_stateRight = RS;
			else
				next_stateRight = IDLER;
		}
		else
			next_stateRight = IDLER;
		break;

	default:
		next_stateRight = IDLER;
		break;
	}
}

void Switching_Allocator::getnextstateLeft(){
	switch (state_signalLeft){
	case IDLELeft:
		if (countW != 0) {
			if (MoveLeftL.read() == 1)
				next_stateLeft = LCore;
			else if (MoveLeftN.read() == 1)
				next_stateLeft = LN;
			else if (MoveLeftS.read() == 1)
				next_stateLeft = LS;
			else if (MoveLeftE.read() == 1)
				next_stateLeft = LE;
			else
				next_stateLeft = IDLELeft;
		}
		else
			next_stateLeft = IDLELeft;
		break;

	case LCore:
		if (countW != 0) {
			if (MoveLeftL.read() == 1)
				next_stateLeft = LCore;
			else if (MoveLeftN.read() == 1)
				next_stateLeft = LN;
			else if (MoveLeftS.read() == 1)
				next_stateLeft = LS;
			else if (MoveLeftE.read() == 1)
				next_stateLeft = LE;
			else
				next_stateLeft = IDLELeft;
		}
		else
			next_stateLeft = IDLELeft;
		break;

	case LN:
		if (countW != 0){
			if (MoveLeftN == 1)
				next_stateLeft = LN;
			else if (MoveLeftL == 1)
				next_stateLeft = LCore;
			else if (MoveLeftS == 1)
				next_stateLeft = LS;
			else if (MoveLeftE == 1)
				next_stateLeft = LE;
			else
				next_stateLeft = IDLELeft;
		}
		else
			next_stateLeft = IDLELeft;
		break;

	case LS:
		if (countW != 0){
			if (MoveLeftS.read() == 1)
				next_stateLeft = LS;
			else if (MoveLeftL.read() == 1)
				next_stateLeft = LCore;
			else if (MoveLeftN.read() == 1)
				next_stateLeft = LN;
			else if (MoveLeftE.read() == 1)
				next_stateLeft = LE;
			else
				next_stateLeft = IDLELeft;
		}
		else
			next_stateLeft = IDLELeft;
		break;

	case LE:
		if (countW != 0){
			if (MoveLeftE.read() == 1)
				next_stateLeft = LE;
			else if (MoveLeftL.read() == 1)
				next_stateLeft = LCore;
			else if (MoveLeftN.read() == 1)
				next_stateLeft = LN;
			else if (MoveLeftS.read() == 1)
				next_stateLeft = LS;
			else
				next_stateLeft = IDLELeft;
		}
		else
			next_stateLeft = IDLELeft;
		break;

	default:
		next_stateLeft = IDLELeft;
		break;
	}

}

void Switching_Allocator::setnextstate(){
	state_signalL = next_stateL;
	state_signalUp = next_stateUP;
	state_signalDN = next_stateDN;
	state_signalRight = next_stateRight;
	state_signalLeft = next_stateLeft;

	if (next_stateL.read() == IDLELocal){
		if (credit_inL.read() == 1)
			countL = countL + 1;
	}
	else {
		if (credit_inL.read() != 1)
			countL = countL - 1;
	}

	if (next_stateUP.read() == IDLEUP) {
		if (credit_inN.read() == 1)
			countN = countN + 1;
	}
	else {
		if (credit_inN.read() != 1)
			countN = countN - 1;
	}

	if (next_stateDN.read() == IDLEDN) {
		if (credit_inS.read() == 1)
			countS = countS + 1;
	}
	else {
		if (credit_inS.read() != 1)
			countS = countS - 1;
	}

	if (next_stateRight.read() == IDLER) {
		if (credit_inE.read() == 1)
			countE = countE + 1;
	}
	else {
		if (credit_inE.read() != 1)
			countE = countE - 1;
	}


	if (next_stateLeft.read() == IDLELeft) {
		if (credit_inW.read() == 1)
			countW = countW + 1;
	}
	else {
		if (credit_inW.read() != 1)
			countW = countW - 1;
	}
}

void Switching_Allocator::outputL(){
	switch (state_signalL){
	case IDLELocal:
		Data_RequestLN = 0;
		Data_RequestLS = 0;
		Data_RequestLE = 0;
		Data_RequestLW = 0;

		NSEWtoL = "0000";
		break;

	case LocalN:
		Data_RequestLN = 1;
		Data_RequestLS = 0;
		Data_RequestLE = 0;
		Data_RequestLW = 0;

		NSEWtoL = "1000";
		break;
	case LocalS:
		Data_RequestLN = 0;
		Data_RequestLS = 1;
		Data_RequestLE = 0;
		Data_RequestLW = 0;

		NSEWtoL = "0100";
		break;
	case LocalE:
		Data_RequestLN = 0;
		Data_RequestLS = 0;
		Data_RequestLE = 1;
		Data_RequestLW = 0;

		NSEWtoL = "0010";
		break;
	case LocalW:
		Data_RequestLN = 0;
		Data_RequestLS = 0;
		Data_RequestLE = 0;
		Data_RequestLW = 1;

		NSEWtoL = "0001";
		break;
	default:
		Data_RequestLN = 0;
		Data_RequestLS = 0;
		Data_RequestLE = 0;
		Data_RequestLW = 0;

		NSEWtoL = "0000";
		break;
	}
}

void Switching_Allocator::outputUP(){
	switch (state_signalUp){
	case IDLEUP:
		Data_RequestNL = 0;
		Data_RequestNS = 0;
		Data_RequestNE = 0;
		Data_RequestNW = 0;

		LSEWtoN = "0000";
		break;

	case UpCore:
		Data_RequestNL = 1;
		Data_RequestNS = 0;
		Data_RequestNE = 0;
		Data_RequestNW = 0;

		LSEWtoN = "1000";
		break;

	case UpS:
		Data_RequestNL = 0;
		Data_RequestNS = 1;
		Data_RequestNE = 0;
		Data_RequestNW = 0;

		LSEWtoN = "0100";
		break;

	case UpE:
		Data_RequestNL = 0;
		Data_RequestNS = 0;
		Data_RequestNE = 1;
		Data_RequestNW = 0;

		LSEWtoN = "0010";
		break;

	case UpW:
		Data_RequestNL = 0;
		Data_RequestNS = 0;
		Data_RequestNE = 0;
		Data_RequestNW = 1;

		LSEWtoN = "0001";
		break;
	default:
		Data_RequestNL = 0;
		Data_RequestNS = 0;
		Data_RequestNE = 0;
		Data_RequestNW = 0;

		LSEWtoN = "0000";
		break;
	}

}

void Switching_Allocator::outputDN(){
	switch (state_signalDN){
	case IDLEDN:
		Data_RequestSL = 0;
		Data_RequestSN = 0;
		Data_RequestSE = 0;
		Data_RequestSW = 0;

		LNEWtoS = "0000";
		break;

	case DNCore:
		Data_RequestSL = 1;
		Data_RequestSN = 0;
		Data_RequestSE = 0;
		Data_RequestSW = 0;

		LNEWtoS = "1000";
		break;

	case DNN:
		Data_RequestSL = 0;
		Data_RequestSN = 1;
		Data_RequestSE = 0;
		Data_RequestSW = 0;

		LNEWtoS = "0100";
		break;

	case DNE:
		Data_RequestSL = 0;
		Data_RequestSN = 0;
		Data_RequestSE = 1;
		Data_RequestSW = 0;

		LNEWtoS = "0010";
		break;

	case DNW:
		Data_RequestSL = 0;
		Data_RequestSN = 0;
		Data_RequestSE = 0;
		Data_RequestSW = 1;

		LNEWtoS = "0001";
		break;

	default:
		Data_RequestSL = 0;
		Data_RequestSN = 0;
		Data_RequestSE = 0;
		Data_RequestSW = 0;

		LNEWtoS = "0000";
		break;
	}

}

void Switching_Allocator::outputRight(){
	switch (state_signalRight){
	case IDLER:
		Data_RequestEL = 0;
		Data_RequestEN = 0;
		Data_RequestES = 0;
		Data_RequestEW = 0;

		LNSWtoE = "0000";
		break;

	case RCore:
		Data_RequestEL = 1;
		Data_RequestEN = 0;
		Data_RequestES = 0;
		Data_RequestEW = 0;

		LNSWtoE = "1000";
		break;

	case RN:
		Data_RequestEL = 0;
		Data_RequestEN = 1;
		Data_RequestES = 0;
		Data_RequestEW = 0;

		LNSWtoE = "0100";
		break;

	case RS:
		Data_RequestEL = 0;
		Data_RequestEN = 0;
		Data_RequestES = 1;
		Data_RequestEW = 0;

		LNSWtoE = "0010";
		break;

	case RW:
		Data_RequestEL = 0;
		Data_RequestEN = 0;
		Data_RequestES = 0;
		Data_RequestEW = 1;

		LNSWtoE = "0001";
		break;

	default:
		Data_RequestEL = 0;
		Data_RequestEN = 0;
		Data_RequestES = 0;
		Data_RequestEW = 0;

		LNSWtoE = "0000";
		break;

	}
}

void Switching_Allocator::outputLeft(){
	switch (state_signalLeft){
	case IDLELeft:
		Data_RequestWL = 0;
		Data_RequestWN = 0;
		Data_RequestWS = 0;
		Data_RequestWE = 0;

		LNSEtoW = "0000";
		break;

	case LCore:
		Data_RequestWL = 1;
		Data_RequestWN = 0;
		Data_RequestWS = 0;
		Data_RequestWE = 0;

		LNSEtoW = "1000";
		break;

	case LN:
		Data_RequestWL = 0;
		Data_RequestWN = 1;
		Data_RequestWS = 0;
		Data_RequestWE = 0;

		LNSEtoW = "0100";
		break;

	case LS:
		Data_RequestWL = 0;
		Data_RequestWN = 0;
		Data_RequestWS = 1;
		Data_RequestWE = 0;

		LNSEtoW = "0010";
		break;

	case LE:
		Data_RequestWL = 0;
		Data_RequestWN = 0;
		Data_RequestWS = 0;
		Data_RequestWE = 1;

		LNSEtoW = "0001";
		break;

	default:
		Data_RequestWL = 0;
		Data_RequestWN = 0;
		Data_RequestWS = 0;
		Data_RequestWE = 0;

		LNSEtoW = "0000";
		break;
	}
}

void Switching_Allocator::DataRequest(){
	Data_RequestL = Data_RequestNL | Data_RequestSL | Data_RequestEL | Data_RequestWL;
	Data_RequestN = Data_RequestLN | Data_RequestSN | Data_RequestEN | Data_RequestWN;
	Data_RequestS = Data_RequestLS | Data_RequestNS | Data_RequestES | Data_RequestWS;
	Data_RequestE = Data_RequestLE | Data_RequestNE | Data_RequestSE | Data_RequestWE;
	Data_RequestW = Data_RequestLW | Data_RequestNW | Data_RequestSW | Data_RequestEW;
}