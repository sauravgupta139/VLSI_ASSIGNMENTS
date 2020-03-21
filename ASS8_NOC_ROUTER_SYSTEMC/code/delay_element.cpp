#include "delay_element.h"

void delay_element::delay_prc1(){
	temp = Input_flit;
}

void delay_element::delay_prc(){
	Output_flit = temp;
}