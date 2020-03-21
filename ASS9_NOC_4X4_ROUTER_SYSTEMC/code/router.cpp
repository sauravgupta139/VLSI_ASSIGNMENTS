#include "router.h"

void router:: output(){
	outputL = output_flitL;
	outputN = output_flitN;
	outputS = output_flitS;
	outputE = output_flitE;
	outputW = output_flitW;

	Type_headerL = outputL.range(31,30);
	Type_headerN = outputN.range(31,30);
	Type_headerS = outputS.range(31,30);
	Type_headerE = outputE.range(31,30);
	Type_headerW = outputW.range(31,30);

	XDestinationL = outputL.range(23, 22);
	YDestinationL = outputL.range(21, 20);
	XDestinationN = outputN.range(23, 22);
	YDestinationN = outputN.range(21, 20);
	XDestinationS = outputS.range(23, 22);
	YDestinationS = outputS.range(21, 20);
	XDestinationE = outputE.range(23, 22);
	YDestinationE = outputE.range(21, 20);
	XDestinationW = outputW.range(23, 22);
	YDestinationW = outputW.range(21, 20);
}