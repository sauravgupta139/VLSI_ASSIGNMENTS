#include "crossbar_switch.h"

void crossbar_switch::cross_switch() {
	if (NSEWtoL.read() == "1000"){
		Local_output_temp = North_Input;
	}
	else if (NSEWtoL.read() == "0100") {
		Local_output_temp = South_Input;
	}
	else if (NSEWtoL.read() == "0010") {
		Local_output_temp = East_Input;
	}
	else if (NSEWtoL.read() == "0001") {
		Local_output_temp = West_Input;
	}
	else
		Local_output_temp = 0x00000000;

	if (LSEWtoN.read() == "1000") {
		North_output_temp = Local_Input;
	}
	else if (LSEWtoN.read() == "0100") {
		North_output_temp = South_Input;
	}
	else if (LSEWtoN.read() == "0010") {
		North_output_temp = East_Input;
	}
	else if (LSEWtoN.read() == "0001") {
		North_output_temp = West_Input;
	}
	else
		North_output_temp = 0x00000000;

	if (LNEWtoS.read() == "1000") {
		South_output_temp = Local_Input;
	}
	else if (LNEWtoS.read() == "0100") {
		South_output_temp = North_Input;
	}
	else if (LNEWtoS.read() == "0010") {
		South_output_temp = East_Input;
	}
	else if (LNEWtoS.read() == "0001") {
		South_output_temp = West_Input;
	}
	else
		South_output_temp = 0x00000000;

	if (LNSWtoE.read() == "1000"){
		East_output_temp = Local_Input;
	}
	else if (LNSWtoE.read() == "0100") {
		East_output_temp = North_Input;
	}
	else if (LNSWtoE.read() == "0010") {
		East_output_temp = South_Input;
	}
	else if (LNSWtoE.read() == "0001") {
		East_output_temp = West_Input;
	}
	else
		East_output_temp = 0x00000000;

	if (LNSEtoW.read() == "1000") {
		West_output_temp = Local_Input;
	}
	else if (LNSEtoW.read() == "0100") {
		West_output_temp = North_Input;
	}
	else if (LNSEtoW.read() == "0010") {
		West_output_temp = South_Input;
	}
	else if (LNSEtoW.read() == "0001") {
		West_output_temp = East_Input;
	}
	else
		West_output_temp = 0x00000000;
}

void crossbar_switch::output_flits(){
	if (Local_output_temp.range(31, 30) == "01"){
		Local_output = temp1;
		temp1 = Local_output_temp;
	}
	else {
		Local_output = Local_output_temp;
		temp1 = 0x00000000;
	}

	if (North_output_temp.range(31, 30) == "01"){
		North_output = temp2;
		temp2 = North_output_temp;
	}
	else {
		North_output = North_output_temp;
		temp2 = 0x00000000;
	}


	if (South_output_temp.range(31, 30) == "01"){
		South_output = temp3;
		temp3 = South_output_temp;
	}
	else {
		South_output = South_output_temp;
		temp3 = 0x00000000;
	}

	if (East_output_temp.range(31, 30) == "01"){
		East_output = temp4;
		temp4 = East_output_temp;
	}
	else {
		East_output = East_output_temp;
		temp4 = 0x00000000;
	}

	if (West_output_temp.range(31, 30) == "01"){
		West_output = temp5;
		temp5 = West_output_temp;
	}
	else {
		West_output = West_output_temp;
		temp5 = 0x00000000;
	}
}