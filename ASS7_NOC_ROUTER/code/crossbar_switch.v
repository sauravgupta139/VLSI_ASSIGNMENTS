module crossbar_switch(clk,Local_Input,North_Input,South_Input,East_Input,West_Input,NSEWtoL,LSEWtoN,LNEWtoS,LNSWtoE,LNSEtoW,Local_output,North_output,South_output,East_output,West_output);
        input clk;
		input[31:0] Local_Input,North_Input,South_Input,East_Input,West_Input;
		input[3:0] NSEWtoL;
		input[3:0] LSEWtoN;
		input[3:0] LNEWtoS;
		input[3:0] LNSWtoE;
		input[3:0] LNSEtoW;
		output reg[31:0] Local_output,North_output,South_output,East_output,West_output;
		reg[31:0] Local_output_temp,North_output_temp,South_output_temp,East_output_temp,West_output_temp;
		reg[31:0] temp1=32'h00000000,temp2=32'h00000000,temp3=32'h00000000,temp4=32'h00000000,temp5=32'h00000000;
		
		always @(posedge clk)
		begin
		if (NSEWtoL==4'b1000) 
			Local_output_temp <= North_Input;
		else if (NSEWtoL==4'b0100) 
			Local_output_temp <= South_Input;
		else if (NSEWtoL==4'b0010) 
			Local_output_temp <= East_Input;
		else if (NSEWtoL==4'b0001) 
			Local_output_temp <= West_Input;
		else
			Local_output_temp <= 32'h00000000;
			
		if (LSEWtoN==4'b1000) 
			North_output_temp<=Local_Input;
		else if (LSEWtoN==4'b0100) 
			North_output_temp<=South_Input;
		else if (LSEWtoN==4'b0010) 
			North_output_temp<=East_Input;
		else if (LSEWtoN==4'b0001) 
			North_output_temp<=West_Input;
		else 
			North_output_temp<=32'h00000000;
			
		if (LNEWtoS==4'b1000) 
			South_output_temp<=Local_Input;
		else if (LNEWtoS==4'b0100) 
			South_output_temp<=North_Input;
		else if (LNEWtoS==4'b0010) 
			South_output_temp<=East_Input;
		else if (LNEWtoS==4'b0001) 
			South_output_temp<=West_Input;
		else 
			South_output_temp<=32'h00000000;
			
		if (LNSWtoE==4'b1000) 
			East_output_temp<=Local_Input;
		else if (LNSWtoE==4'b0100) 
			East_output_temp<=North_Input;
		else if (LNSWtoE==4'b0010) 
			East_output_temp<=South_Input;
		else if (LNSWtoE==4'b0001) 
			East_output_temp<=West_Input;
		else 
			East_output_temp<=32'h00000000;
			
		if (LNSEtoW==4'b1000) 
			West_output_temp<=Local_Input;
		else if (LNSEtoW==4'b0100) 
			West_output_temp<=North_Input;
		else if (LNSEtoW==4'b0010) 
			West_output_temp<=South_Input;
		else if (LNSEtoW==4'b0001) 
			West_output_temp<=East_Input;
		else 
			West_output_temp<=32'h00000000;
		end
		
		always @(posedge clk)
		begin
			if(Local_output_temp[31:30] == 2'b01)begin
				temp1 <= Local_output_temp;
				Local_output <= temp1;
			end
			else begin
				Local_output <= Local_output_temp;
				temp1 <= 32'h00000000;
			end
				
				
			if(North_output_temp[31:30] == 2'b01)begin
				temp2 <= North_output_temp;
				North_output <= temp2;
			end
			else begin
				North_output <= North_output_temp;
				temp2 <= 32'h00000000;
			end
				
				
			if(South_output_temp[31:30] == 2'b01)begin
				temp3 <= South_output_temp;
				South_output <= temp3;
			end
			else begin
				South_output <= South_output_temp;
				temp3 <= 32'h00000000;
			end
				
			if(East_output_temp[31:30] == 2'b01)begin
				temp4 <= East_output_temp;
				East_output <= temp4;
			end
			else begin
				East_output <= East_output_temp;
				temp4 <= 32'h00000000;
			end
				
			if(West_output_temp[31:30] == 2'b01)begin
				temp5 <= West_output_temp;
				West_output <= temp5;
			end
			else begin
				West_output <= West_output_temp;
				temp5 <= 32'h00000000;
			end
				
			
		end
		
    endmodule