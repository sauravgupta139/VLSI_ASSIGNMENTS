#include "routing_logic.h"

void routing_logic::getnextstateL() {
	XDesL = XDestinationL;
	YDesL = YDestinationL;
	XPres = XPresent;
	YPres = YPresent;
	XdiffL = XDesL - XPres;
	YdiffL = YDesL - YPres;

	switch (state_signalL){
	case IDLEL:
		if (Type_headerL.read() == "01") {
			if (XdiffL < 0)
				next_stateL = MoveWestL;
			else if (XdiffL > 0)
				next_stateL = MoveEastL;
			else {
				if (YdiffL < 0)
					next_stateL = MoveNorthL;
				else if (YdiffL > 0)
					next_stateL = MoveSouthL;
				else
					next_stateL = IDLEL;
			}
		}
		else
			next_stateL = IDLEL;
		break;


	case MoveNorthL:
		if (Type_headerL.read() == "01") {
			if (XdiffL < 0)
				next_stateL = MoveWestL;
			else if (XdiffL > 0)
				next_stateL = MoveEastL;
			else {
				if (YdiffL < 0)
					next_stateL = MoveNorthL;
				else if (YdiffL > 0)
					next_stateL = MoveSouthL;
				else
					next_stateL = IDLEL;
			}
		}
		else if (Type_headerL.read() == "10" || Type_headerL.read() == "11")
			next_stateL = MoveNorthL;
		else
			next_stateL = IDLEL;
		break;

	case MoveSouthL:
		if (Type_headerL.read() == "01") {
			if (XdiffL < 0)
				next_stateL = MoveWestL;
			else if (XdiffL > 0)
				next_stateL = MoveEastL;
			else {
				if (YdiffL < 0)
					next_stateL = MoveNorthL;
				else if (YdiffL > 0)
					next_stateL = MoveSouthL;
				else
					next_stateL = IDLEL;
			}
		}
		else if (Type_headerL.read() == "10" || Type_headerL.read() == "11")
			next_stateL = MoveSouthL;
		else
			next_stateL = IDLEL;
		break;

	case MoveEastL:
		if (Type_headerL.read() == "01") {
			if (XdiffL < 0)
				next_stateL = MoveWestL;
			else if (XdiffL > 0)
				next_stateL = MoveEastL;
			else {
				if (YdiffL < 0)
					next_stateL = MoveNorthL;
				else if (YdiffL > 0)
					next_stateL = MoveSouthL;
				else
					next_stateL = IDLEL;
			}
		}
		else if (Type_headerL.read() == "10" || Type_headerL.read() == "11")
			next_stateL = MoveEastL;
		else
			next_stateL = IDLEL;
		break;

	case MoveWestL:
		if (Type_headerL.read() == "01") {
			if (XdiffL < 0)
				next_stateL = MoveWestL;
			else if (XdiffL > 0)
				next_stateL = MoveEastL;
			else {
				if (YdiffL < 0)
					next_stateL = MoveNorthL;
				else if (YdiffL > 0)
					next_stateL = MoveSouthL;
				else
					next_stateL = IDLEL;
			}
		}
		else if (Type_headerL.read() == "10" || Type_headerL.read() == "11")
			next_stateL = MoveWestL;
		else
			next_stateL = IDLEL;
		break;

	default:
		next_stateL = IDLEL;
		break;
	}

}

void routing_logic::getnextstateN(){
	XDesN = XDestinationN;
	YDesN = YDestinationN;
	XPres = XPresent;
	YPres = YPresent;
	XdiffN = XDesN - XPres;
	YdiffN = YDesN - YPres;

	switch (state_signalN){
	case IDLEN:
		if (Type_headerN.read() == "01") {
			if (XdiffN < 0)
				next_stateN = MoveWestN;
			else if (XdiffN > 0)
				next_stateN = MoveEastN;
			else {
				if (YdiffN < 0)
					next_stateN = IDLEN; //won't happen;
				else if (YdiffN > 0)
					next_stateN = MoveSouthN;
				else
					next_stateN = MoveLocalN;
			}
		}
		else
			next_stateN = IDLEN;
		break;

	case MoveSouthN:
		if (Type_headerN.read() == "01") {
			if (XdiffN < 0)
				next_stateN = MoveWestN;
			else if (XdiffN > 0)
				next_stateN = MoveEastN;
			else {
				if (YdiffN < 0)
					next_stateN = IDLEN; //won't happen;
				else if (YdiffN > 0)
					next_stateN = MoveSouthN;
				else
					next_stateN = MoveLocalN;
			}
		}
		else if (Type_headerN.read() == "10" || Type_headerN.read() == "11")
			next_stateN = MoveSouthN;
		else
			next_stateN = IDLEN;
		break;

	case MoveEastN:
		if (Type_headerN.read() == "01") {
			if (XdiffN < 0)
				next_stateN = MoveWestN;
			else if (XdiffN > 0)
				next_stateN = MoveEastN;
			else {
				if (YdiffN < 0)
					next_stateN = IDLEN; //won't happen;
				else if (YdiffN > 0)
					next_stateN = MoveSouthN;
				else
					next_stateN = MoveLocalN;
			}
		}
		else if (Type_headerN.read() == "10" || Type_headerN.read() == "11")
			next_stateN = MoveEastN;
		else
			next_stateN = IDLEN;
		break;

	case MoveWestN:
		if (Type_headerN.read() == "01") {
			if (XdiffN < 0)
				next_stateN = MoveWestN;
			else if (XdiffN > 0)
				next_stateN = MoveEastN;
			else {
				if (YdiffN < 0)
					next_stateN = IDLEN; //won't happen;
				else if (YdiffN > 0)
					next_stateN = MoveSouthN;
				else
					next_stateN = MoveLocalN;
			}
		}
		else if (Type_headerN.read() == "10" || Type_headerN.read() == "11")
			next_stateN = MoveWestN;
		else
			next_stateN = IDLEN;
		break;

	case MoveLocalN:
		if (Type_headerN.read() == "01") {
			if (XdiffN < 0)
				next_stateN = MoveWestN;
			else if (XdiffN > 0)
				next_stateN = MoveEastN;
			else {
				if (YdiffN < 0)
					next_stateN = IDLEN; //won't happen;
				else if (YdiffN > 0)
					next_stateN = MoveSouthN;
				else
					next_stateN = MoveLocalN;
			}
		}
		else if (Type_headerN.read() == "10" || Type_headerN.read() == "11")
			next_stateN = MoveLocalN;
		else
			next_stateN = IDLEN;
		break;

	default:
		next_stateN = IDLEN;
		break;
	}
}

void routing_logic::getnextstateS(){
	XDesS = XDestinationS;
	YDesS = YDestinationS;
	XPres = XPresent;
	YPres = YPresent;
	XdiffS = XDesS - XPres;
	YdiffS = YDesS - YPres;

	switch (state_signalS){
	case IDLES:
		if (Type_headerS.read() == "01") {
			if (XdiffS < 0)
				next_stateS = MoveWestS;
			else if (XdiffS > 0)
				next_stateS = MoveEastS;
			else {
				if (YdiffS < 0)
					next_stateS = MoveNorthS;
				else if (YdiffS > 0)
					next_stateS = IDLES; //won't happen
				else
					next_stateS = MoveLocalS;
			}
		}
		else
			next_stateS = IDLES;
		break;

	case MoveNorthS:
		if (Type_headerS.read() == "01") {
			if (XdiffS < 0)
				next_stateS = MoveWestS;
			else if (XdiffS > 0)
				next_stateS = MoveEastS;
			else {
				if (YdiffS < 0)
					next_stateS = MoveNorthS;
				else if (YdiffS > 0)
					next_stateS = IDLES; //won't happen
				else
					next_stateS = MoveLocalS;
			}
		}
		else if (Type_headerS.read() == "10" || Type_headerS.read() == "11")
			next_stateS = MoveNorthS;
		else
			next_stateS = IDLES;
		break;

	case MoveEastS:
		if (Type_headerS.read() == "01") {
			if (XdiffS < 0)
				next_stateS = MoveWestS;
			else if (XdiffS > 0)
				next_stateS = MoveEastS;
			else {
				if (YdiffS < 0)
					next_stateS = MoveNorthS;
				else if (YdiffS > 0)
					next_stateS = IDLES; //won't happen
				else
					next_stateS = MoveLocalS;
			}
		}
		else if (Type_headerS.read() == "10" || Type_headerS.read() == "11")
			next_stateS = MoveEastS;
		else
			next_stateS = IDLES;
		break;

	case MoveWestS:
		if (Type_headerS.read() == "01") {
			if (XdiffS < 0)
				next_stateS = MoveWestS;
			else if (XdiffS > 0)
				next_stateS = MoveEastS;
			else {
				if (YdiffS < 0)
					next_stateS = MoveNorthS;
				else if (YdiffS > 0)
					next_stateS = IDLES; //won't happen
				else
					next_stateS = MoveLocalS;
			}
		}
		else if (Type_headerS.read() == "10" || Type_headerS.read() == "11")
			next_stateS = MoveWestS;
		else
			next_stateS = IDLES;
		break;

	case MoveLocalS:
		if (Type_headerS.read() == "01") {
			if (XdiffS < 0)
				next_stateS = MoveWestS;
			else if (XdiffS > 0)
				next_stateS = MoveEastS;
			else {
				if (YdiffS < 0)
					next_stateS = MoveNorthS;
				else if (YdiffS > 0)
					next_stateS = IDLES; //won't happen
				else
					next_stateS = MoveLocalS;
			}
		}
		else if (Type_headerS.read() == "10" || Type_headerS.read() == "11")
			next_stateS = MoveLocalS;
		else
			next_stateS = IDLES;
		break;

	default:
		next_stateS = IDLES;
		break;
	}
}

void routing_logic::getnextstateE(){
	XDesE = XDestinationE;
	YDesE = YDestinationE;
	XPres = XPresent;
	YPres = YPresent;
	XdiffE = XDesE - XPres;
	YdiffE = YDesE - YPres;
	switch (state_signalE){
	case IDLEE:
		if (Type_headerE.read() == "01") {
			if (XdiffE < 0)
				next_stateE = MoveWestE;
			else if (XdiffE > 0)
				next_stateE = IDLEE; //won't happen
			else {
				if (YdiffE < 0)
					next_stateE = MoveNorthE;
				else if (YdiffE > 0)
					next_stateE = MoveSouthE;
				else
					next_stateE = MoveLocalE;
			}
		}
		else
			next_stateE = IDLEE;
		break;

	case MoveNorthE:
		if (Type_headerE.read() == "01") {
			if (XdiffE < 0)
				next_stateE = MoveWestE;
			else if (XdiffE > 0)
				next_stateE = IDLEE; //won't happen
			else {
				if (YdiffE < 0)
					next_stateE = MoveNorthE;
				else if (YdiffE > 0)
					next_stateE = MoveSouthE;
				else
					next_stateE = MoveLocalE;
			}
		}
		else if (Type_headerE.read() == "10" || Type_headerE.read() == "11")
			next_stateE = MoveNorthE;
		else
			next_stateE = IDLEE;
		break;

	case MoveSouthE:
		if (Type_headerE.read() == "01") {
			if (XdiffE < 0)
				next_stateE = MoveWestE;
			else if (XdiffE > 0)
				next_stateE = IDLEE; //won't happen
			else {
				if (YdiffE < 0)
					next_stateE = MoveNorthE;
				else if (YdiffE > 0)
					next_stateE = MoveSouthE;
				else
					next_stateE = MoveLocalE;
			}
		}
		else if (Type_headerE.read() == "10" || Type_headerE.read() == "11")
			next_stateE = MoveSouthE;
		else
			next_stateE = IDLEE;
		break;

	case MoveWestE:
		if (Type_headerE.read() == "01") {
			if (XdiffE < 0)
				next_stateE = MoveWestE;
			else if (XdiffE > 0)
				next_stateE = IDLEE; //won't happen
			else {
				if (YdiffE < 0)
					next_stateE = MoveNorthE;
				else if (YdiffE > 0)
					next_stateE = MoveSouthE;
				else
					next_stateE = MoveLocalE;
			}
		}
		else if (Type_headerE.read() == "10" || Type_headerE.read() == "11")
			next_stateE = MoveWestE;
		else
			next_stateE = IDLEE;
		break;

	case MoveLocalE:
		if (Type_headerE.read() == "01") {
			if (XdiffE < 0)
				next_stateE = MoveWestE;
			else if (XdiffE > 0)
				next_stateE = IDLEE; //won't happen
			else {
				if (YdiffE < 0)
					next_stateE = MoveNorthE;
				else if (YdiffE > 0)
					next_stateE = MoveSouthE;
				else
					next_stateE = MoveLocalE;
			}
		}
		else if (Type_headerE.read() == "10" || Type_headerE.read() == "11")
			next_stateE = MoveLocalE;
		else
			next_stateE = IDLEE;
		break;

	default:
		next_stateE = IDLEE;
		break;
	}
}

void routing_logic::getnextstateW(){
	XDesW = XDestinationW;
	YDesW = YDestinationW;
	XPres = XPresent;
	YPres = YPresent;
	XdiffW = XDesW - XPres;
	YdiffW = YDesW - YPres;
	switch (state_signalW)
	{
	case IDLEW:
		if (Type_headerW.read() == "01"){
			if (XdiffW < 0)
				next_stateW = IDLEW; //won't happen
			else if (XdiffW > 0)
				next_stateW = MoveEastW;
			else {
				if (YdiffW < 0)
					next_stateW = MoveNorthW;
				else if (YdiffW > 0)
					next_stateW = MoveSouthW;
				else
					next_stateW = MoveLocalW;
			}
		}
		else
			next_stateW = IDLEW;
		break;

	case MoveNorthW:
		if (Type_headerW.read() == "01"){
			if (XdiffW < 0)
				next_stateW = IDLEW; //won't happen
			else if (XdiffW > 0)
				next_stateW = MoveEastW;
			else {
				if (YdiffW < 0)
					next_stateW = MoveNorthW;
				else if (YdiffW > 0)
					next_stateW = MoveSouthW;
				else
					next_stateW = MoveLocalW;
			}
		}
		else if (Type_headerW.read() == "10" || Type_headerW.read() == "11")
			next_stateW = MoveNorthW;
		else
			next_stateW = IDLEW;
		break;

	case MoveSouthW:
		if (Type_headerW.read() == "01"){
			if (XdiffW < 0)
				next_stateW = IDLEW; //won't happen
			else if (XdiffW > 0)
				next_stateW = MoveEastW;
			else {
				if (YdiffW < 0)
					next_stateW = MoveNorthW;
				else if (YdiffW > 0)
					next_stateW = MoveSouthW;
				else
					next_stateW = MoveLocalW;
			}
		}
		else if (Type_headerW.read() == "10" || Type_headerW.read() == "11")
			next_stateW = MoveSouthW;
		else
			next_stateW = IDLEW;
		break;

	case MoveEastW:
		if (Type_headerW.read() == "01"){
			if (XdiffW < 0)
				next_stateW = IDLEW; //won't happen
			else if (XdiffW > 0)
				next_stateW = MoveEastW;
			else {
				if (YdiffW < 0)
					next_stateW = MoveNorthW;
				else if (YdiffW > 0)
					next_stateW = MoveSouthW;
				else
					next_stateW = MoveLocalW;
			}
		}
		else if (Type_headerW.read() == "10" || Type_headerW.read() == "11")
			next_stateW = MoveEastW;
		else
			next_stateW = IDLEW;
		break;

	case MoveLocalW:
		if (Type_headerW.read() == "01"){
			if (XdiffW < 0)
				next_stateW = IDLEW; //won't happen
			else if (XdiffW > 0)
				next_stateW = MoveEastW;
			else {
				if (YdiffW < 0)
					next_stateW = MoveNorthW;
				else if (YdiffW > 0)
					next_stateW = MoveSouthW;
				else
					next_stateW = MoveLocalW;
			}
		}
		else if (Type_headerW.read() == "10" || Type_headerW.read() == "11")
			next_stateW = MoveLocalW;
		else
			next_stateW = IDLEW;
		break;

	default:
		next_stateW = IDLEW;
		break;
	}
}

void routing_logic::setnextstate(){
	state_signalL = next_stateL;
	state_signalN = next_stateN;
	state_signalS = next_stateS;
	state_signalE = next_stateE;
	state_signalW = next_stateW;
}

void routing_logic::outputL(){
	switch (state_signalL){
	case IDLEL:
		MoveDownL = 0;
		MoveUpL = 0;
		MoveRightL = 0;
		MoveLeftL = 0;
		break;

	case MoveNorthL:
		MoveDownL = 0;
		MoveUpL = 1;
		MoveRightL = 0;
		MoveLeftL = 0;
		break;

	case MoveSouthL:
		MoveDownL = 1;
		MoveUpL = 0;
		MoveRightL = 0;
		MoveLeftL = 0;
		break;

	case MoveEastL:
		MoveDownL = 0;
		MoveUpL = 0;
		MoveRightL = 1;
		MoveLeftL = 0;
		break;

	case MoveWestL:
		MoveDownL = 0;
		MoveUpL = 0;
		MoveRightL = 0;
		MoveLeftL = 1;
		break;

	default:
		MoveDownL = 0;
		MoveUpL = 0;
		MoveRightL = 0;
		MoveLeftL = 0;
		break;

	}
}

void routing_logic::outputN(){
	switch (state_signalN){
	case IDLEN:
		MoveCoreN = 0;
		MoveDownN = 0;
		MoveRightN = 0;
		MoveLeftN = 0;
		break;

	case MoveSouthN:
		MoveCoreN = 0;
		MoveDownN = 1;
		MoveRightN = 0;
		MoveLeftN = 0;
		break;

	case MoveEastN:
		MoveCoreN = 0;
		MoveDownN = 0;
		MoveRightN = 1;
		MoveLeftN = 0;
		break;
	case MoveWestN:
		MoveCoreN = 0;
		MoveDownN = 0;
		MoveRightN = 0;
		MoveLeftN = 1;
		break;
	case MoveLocalN:
		MoveCoreN = 1;
		MoveDownN = 0;
		MoveRightN = 0;
		MoveLeftN = 0;
		break;
	default:
		MoveCoreN = 0;
		MoveDownN = 0;
		MoveRightN = 0;
		MoveLeftN = 0;
	}
}

void routing_logic::outputS(){
	switch (state_signalS){
	case IDLES:
		MoveCoreS = 0;
		MoveUpS = 0;
		MoveRightS = 0;
		MoveLeftS = 0;
		break;

	case MoveNorthS:
		MoveCoreS = 0;
		MoveUpS = 1;
		MoveRightS = 0;
		MoveLeftS = 0;
		break;

	case MoveEastS:
		MoveCoreS = 0;
		MoveUpS = 0;
		MoveRightS = 1;
		MoveLeftS = 0;
		break;

	case MoveWestS:
		MoveCoreS = 0;
		MoveUpS = 0;
		MoveRightS = 0;
		MoveLeftS = 1;
		break;

	case MoveLocalS:
		MoveCoreS = 1;
		MoveUpS = 0;
		MoveRightS = 0;
		MoveLeftS = 0;
		break;
	default:
		MoveCoreS = 0;
		MoveUpS = 0;
		MoveRightS = 0;
		MoveLeftS = 0;

	}
}

void routing_logic::outputE(){
	switch (state_signalE){
	case IDLEE:
		MoveCoreE = 0;
		MoveUpE = 0;
		MoveDownE = 0;
		MoveLeftE = 0;
		break;

	case MoveNorthE:
		MoveCoreE = 0;
		MoveUpE = 1;
		MoveDownE = 0;
		MoveLeftE = 0;
		break;

	case MoveSouthE:
		MoveCoreE = 0;
		MoveUpE = 0;
		MoveDownE = 1;
		MoveLeftE = 0;
		break;

	case MoveWestE:
		MoveCoreE = 0;
		MoveUpE = 0;
		MoveDownE = 0;
		MoveLeftE = 1;
		break;

	case MoveLocalE:
		MoveCoreE = 1;
		MoveUpE = 0;
		MoveDownE = 0;
		MoveLeftE = 0;
		break;

	}
}

void routing_logic::outputW(){
	switch (state_signalW){
	case IDLEW:
		MoveCoreW = 0;
		MoveUpW = 0;
		MoveDownW = 0;
		MoveRightW = 0;
		break;

	case MoveNorthW:
		MoveCoreW = 0;
		MoveUpW = 1;
		MoveDownW = 0;
		MoveRightW = 0;
		break;

	case MoveSouthW:
		MoveCoreW = 0;
		MoveUpW = 0;
		MoveDownW = 1;
		MoveRightW = 0;
		break;

	case MoveEastW:
		MoveCoreW = 0;
		MoveUpW = 0;
		MoveDownW = 0;
		MoveRightW = 1;
		break;

	case MoveLocalW:
		MoveCoreW = 1;
		MoveUpW = 0;
		MoveDownW = 0;
		MoveRightW = 0;
		break;
	default:
		MoveCoreW = 0;
		MoveUpW = 0;
		MoveDownW = 0;
		MoveRightW = 0;
	}

}

void routing_logic::Data_Request(){
	if (Type_headerL.read() == "11")
		Data_RequestL = 0;
	else
		Data_RequestL = 1;

	if (Type_headerN.read() == "11")
		Data_RequestN = 0;
	else
		Data_RequestN = 1;

	if (Type_headerS.read() == "11")
		Data_RequestS = 0;
	else
		Data_RequestS = 1;

	if (Type_headerE.read() == "11")
		Data_RequestE = 0;
	else
		Data_RequestE = 1;

	if (Type_headerW.read() == "11")
		Data_RequestW = 0;
	else
		Data_RequestW = 1;
}