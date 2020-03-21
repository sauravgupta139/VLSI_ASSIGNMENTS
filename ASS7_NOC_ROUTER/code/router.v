module router(clk,input_flit_Local,input_flit_North, input_flit_South, input_flit_East,input_flit_West,credit_inL,credit_inN,credit_inS,credit_inE,credit_inW,Credit_outL,Credit_outN,Credit_outS,Credit_outE,Credit_outW,Local_output,North_output,South_output,East_output,West_output);
	input clk;
	input[31:0] input_flit_Local, input_flit_North, input_flit_South, input_flit_East,input_flit_West;
	input credit_inL,credit_inN,credit_inS,credit_inE,credit_inW;
	output Credit_outL,Credit_outN,Credit_outS,Credit_outE,Credit_outW;
	output[31:0] Local_output,North_output,South_output,East_output,West_output;
	
	wire[31:0] output_flitL,output_flitN,output_flitS,output_flitE,output_flitW;
	wire[31:0] Output_flitL_delayed,Output_flitN_delayed,Output_flitS_delayed,Output_flitE_delayed,Output_flitW_delayed;
	wire Data_RequestL,Data_RequestN,Data_RequestS,Data_RequestE,Data_RequestW;
	wire MoveUpL,MoveDownL,MoveRightL,MoveLeftL,MoveDownN,MoveRightN,MoveLeftN,MoveCoreN,MoveUpS,MoveRightS,MoveLeftS,MoveCoreS,MoveUpE,MoveDownE,MoveLeftE,MoveCoreE,MoveUpW,MoveDownW,MoveRightW,MoveCoreW;
	wire[3:0] NSEWtoL,LSEWtoN,LNEWtoS,LNSWtoE,LNSEtoW;
	wire Data_requestLR,Data_requestNR,Data_requestSR,Data_requestER,Data_requestWR;
	
	input_port input_portL(clk,Data_RequestL,Data_requestLR,input_flit_Local,Credit_outL,output_flitL);
	input_port input_portN(clk,Data_RequestN,Data_requestNR,input_flit_North,Credit_outN,output_flitN);
	input_port input_portS(clk,Data_RequestS,Data_requestSR,input_flit_South,Credit_outS,output_flitS);
	input_port input_portE(clk,Data_RequestE,Data_requestER,input_flit_East,Credit_outE,output_flitE);
	input_port input_portW(clk,Data_RequestW,Data_requestWR,input_flit_West,Credit_outW,output_flitW);
	routing_logic routing_logic_1(clk,output_flitL[31:30],output_flitN[31:30],output_flitS[31:30],output_flitE[31:30],output_flitW[31:30],output_flitL[23:22],output_flitL[21:20],output_flitN[23:22],output_flitN[21:20],output_flitS[23:22],output_flitS[21:20],output_flitE[23:22],output_flitE[21:20],output_flitW[23:22],output_flitW[21:20],MoveUpL,MoveDownL,MoveRightL,MoveLeftL,MoveDownN,MoveRightN,MoveLeftN,MoveCoreN,MoveUpS,MoveRightS,MoveLeftS,MoveCoreS,MoveUpE,MoveDownE,MoveLeftE,MoveCoreE,MoveUpW,MoveDownW,MoveRightW,MoveCoreW,Data_requestLR,Data_requestNR,Data_requestSR,Data_requestER,Data_requestWR);
	Switch_Allocator Switch_Allocator_1(clk,credit_inL,credit_inN,credit_inS,credit_inE,credit_inW,MoveUpL,MoveDownL,MoveRightL,MoveLeftL,MoveCoreN,MoveDownN,MoveRightN,MoveLeftN,MoveCoreS,MoveUpS,MoveRightS,MoveLeftS,MoveCoreE,MoveUpE,MoveDownE,MoveLeftE,MoveCoreW,MoveUpW,MoveDownW,MoveRightW,NSEWtoL,LSEWtoN,LNEWtoS,LNSWtoE,LNSEtoW,Data_RequestL,Data_RequestN,Data_RequestS,Data_RequestE,Data_RequestW);
	delay_element delay_element1(clk,output_flitL,Output_flitL_delayed);
	delay_element delay_element2(clk,output_flitN,Output_flitN_delayed);
	delay_element delay_element3(clk,output_flitS,Output_flitS_delayed);
	delay_element delay_element4(clk,output_flitE,Output_flitE_delayed);
	delay_element delay_element5(clk,output_flitW,Output_flitW_delayed);
	crossbar_switch crossbar_switch_1(clk,Output_flitL_delayed,Output_flitN_delayed,Output_flitS_delayed,Output_flitE_delayed,Output_flitW_delayed,NSEWtoL,LSEWtoN,LNEWtoS,LNSWtoE,LNSEtoW,Local_output,North_output,South_output,East_output,West_output);
endmodule