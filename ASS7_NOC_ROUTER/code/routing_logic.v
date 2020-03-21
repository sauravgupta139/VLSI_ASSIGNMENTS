module routing_logic(clk,Type_headerL,Type_headerN,Type_headerS,Type_headerE,Type_headerW,XDestinationL,YDestinationL,XDestinationN,YDestinationN,XDestinationS,YDestinationS,XDestinationE,YDestinationE,XDestinationW,YDestinationW,MoveUpL,MoveDownL,MoveRightL,MoveLeftL,MoveDownN,MoveRightN,MoveLeftN,MoveCoreN,MoveUpS,MoveRightS,MoveLeftS,MoveCoreS,MoveUpE,MoveDownE,MoveLeftE,MoveCoreE,MoveUpW,MoveDownW,MoveRightW,MoveCoreW,Data_requestL,Data_requestN,Data_requestS,Data_requestE,Data_requestW);
        input clk;
		input[1:0] Type_headerL,Type_headerN,Type_headerS,Type_headerE,Type_headerW;
		input[1:0] XDestinationL,YDestinationL;
		input[1:0] XDestinationN,YDestinationN;
		input[1:0] XDestinationS,YDestinationS;
		input[1:0] XDestinationE,YDestinationE;
		input[1:0] XDestinationW,YDestinationW;
		output reg MoveUpL,MoveDownL,MoveRightL,MoveLeftL;
		output reg MoveDownN,MoveRightN,MoveLeftN,MoveCoreN;
		output reg MoveUpS,MoveRightS,MoveLeftS,MoveCoreS;
		output reg MoveUpE,MoveDownE,MoveLeftE,MoveCoreE;
		output reg MoveUpW,MoveDownW,MoveRightW,MoveCoreW;
        output reg Data_requestL,Data_requestN,Data_requestS,Data_requestE,Data_requestW;
		
		reg[2:0] XdiffL,YdiffL,XdiffN,YdiffN,XdiffS,YdiffS,XdiffE,YdiffE,XdiffW,YdiffW;
		reg[1:0] XPresent=2'b01,YPresent=2'b01;
		
		parameter IDLEL = 0, MoveNorthL = 1, MoveSouthL = 2, MoveEastL = 3, MoveWestL =4;
		parameter IDLEN = 5, MoveSouthN = 6, MoveEastN = 7, MoveWestN =8, MoveLocalN =9;
		parameter IDLES = 10, MoveNorthS = 11,  MoveEastS = 12, MoveWestS =13, MoveLocalS =14;
		parameter IDLEE = 15, MoveNorthE = 16, MoveSouthE = 17, MoveWestE =18, MoveLocalE =19;
		parameter IDLEW = 20, MoveNorthW = 21, MoveSouthW = 22, MoveEastW = 23, MoveLocalW =24;
		
		reg[2:0] state_signalL=IDLEL,next_stateL; //Local input states
		reg[3:0] state_signalN=IDLEN,next_stateN; //North input states
		reg[3:0] state_signalS=IDLES,next_stateS; //South input states
		reg[4:0] state_signalE=IDLEE,next_stateE; //East input states
		reg[4:0] state_signalW=IDLEW,next_stateW; //West input states
		
		
		always @(state_signalL,Type_headerL,XdiffL,YdiffL)
		begin
		case(state_signalL)
		IDLEL: begin
			if(Type_headerL== 2'b01) begin
				if($signed(XdiffL) < 0)
					next_stateL = MoveWestL;
				else if($signed(XdiffL) > 0)
					next_stateL = MoveEastL;
				else begin
					if($signed(YdiffL) < 0)
						next_stateL = MoveNorthL;
					else if($signed(YdiffL) >0)
						next_stateL = MoveSouthL;
					else
						next_stateL = IDLEL;
				end
			end
			else
				next_stateL = IDLEL;			
		end
		
		MoveNorthL: begin
			if(Type_headerL== 2'b01) begin
				if($signed(XdiffL) < 0)
					next_stateL = MoveWestL;
				else if($signed(XdiffL) > 0)
					next_stateL = MoveEastL;
				else begin
					if($signed(YdiffL) < 0)
						next_stateL = MoveNorthL;
					else if($signed(YdiffL) >0)
						next_stateL = MoveSouthL;
					else
						next_stateL = IDLEL;
				end
			end
			else if(Type_headerL== 2'b10||Type_headerL== 2'b11)
				next_stateL = MoveNorthL;
			else
				next_stateL = IDLEL;
		end
		
		MoveSouthL: begin
			if(Type_headerL== 2'b01) begin
				if($signed(XdiffL) < 0)
					next_stateL = MoveWestL;
				else if($signed(XdiffL) > 0)
					next_stateL = MoveEastL;
				else begin
					if($signed(YdiffL) < 0)
						next_stateL = MoveNorthL;
					else if($signed(YdiffL) >0)
						next_stateL = MoveSouthL;
					else
						next_stateL = IDLEL;
				end
			end
			else if(Type_headerL== 2'b10 || Type_headerL== 2'b11)
				next_stateL = MoveSouthL;
			else
				next_stateL = IDLEL;
		end
		
		MoveEastL: begin
			if(Type_headerL== 2'b01) begin
				if($signed(XdiffL) < 0)
					next_stateL = MoveWestL;
				else if($signed(XdiffL) > 0)
					next_stateL = MoveEastL;
				else begin
					if($signed(YdiffL) < 0)
						next_stateL = MoveNorthL;
					else if($signed(YdiffL) >0)
						next_stateL = MoveSouthL;
					else
						next_stateL = IDLEL;
				end
			end
			else if(Type_headerL== 2'b10 || Type_headerL== 2'b11)
				next_stateL = MoveEastL;
			else
				next_stateL = IDLEL;
		end
		
		MoveWestL: begin
			if(Type_headerL== 2'b01) begin
				if($signed(XdiffL) < 0)
					next_stateL = MoveWestL;
				else if($signed(XdiffL) > 0)
					next_stateL = MoveEastL;
				else begin
					if($signed(YdiffL) < 0)
						next_stateL = MoveNorthL;
					else if($signed(YdiffL) >0)
						next_stateL = MoveSouthL;
					else
						next_stateL = IDLEL;
				end
			end
			else if(Type_headerL== 2'b10 || Type_headerL== 2'b11)
				next_stateL = MoveWestL;
			else
				next_stateL = IDLEL;
		end
		
		endcase
		end
	
		always @(state_signalN,Type_headerN,XdiffN,YdiffN)
		begin
		case(state_signalN)
		IDLEN :begin
			if(Type_headerN== 2'b01) begin
				if($signed(XdiffN) < 0)
					next_stateN = MoveWestN;
				else if($signed(XdiffN) > 0)
					next_stateN = MoveEastN;
				else begin
					if($signed(YdiffN) < 0)
						next_stateN = IDLEN; //won't happen;
					else if($signed(YdiffN) > 0)
						next_stateN = MoveSouthN;
					else
						next_stateN = MoveLocalN;
				end
			end
			else
				next_stateN = IDLEN;			
		end
		
		MoveSouthN: begin
			if(Type_headerN== 2'b01) begin
				if($signed(XdiffN) < 0)
					next_stateN = MoveWestN;
				else if($signed(XdiffN) > 0)
					next_stateN = MoveEastN;
				else begin
					if($signed(YdiffN) < 0)
						next_stateN = IDLEN; //won't happen;
					else if($signed(YdiffN) > 0)
						next_stateN = MoveSouthN;
					else
						next_stateN = MoveLocalN;
				end
			end
			else if(Type_headerN== 2'b10 || Type_headerN== 2'b11)
				next_stateN = MoveSouthN;
			else
				next_stateN = IDLEN;
		end
		
		MoveEastN: begin
			if(Type_headerN== 2'b01) begin
				if($signed(XdiffN) < 0)
					next_stateN = MoveWestN;
				else if($signed(XdiffN) > 0)
					next_stateN = MoveEastN;
				else begin
					if($signed(YdiffN) < 0)
						next_stateN = IDLEN; //won't happen;
					else if($signed(YdiffN) > 0)
						next_stateN = MoveSouthN;
					else
						next_stateN = MoveLocalN;
				end
			end
			else if(Type_headerN== 2'b10 || Type_headerN== 2'b11)
				next_stateN = MoveEastN;
			else
				next_stateN = IDLEN;
		end
		
		MoveWestN: begin
			if(Type_headerN== 2'b01) begin
				if($signed(XdiffN) < 0)
					next_stateN = MoveWestN;
				else if($signed(XdiffN) > 0)
					next_stateN = MoveEastN;
				else begin
					if($signed(YdiffN) < 0)
						next_stateN = IDLEN; //won't happen;
					else if($signed(YdiffN) > 0)
						next_stateN = MoveSouthN;
					else
						next_stateN = MoveLocalN;
				end
			end
			else if(Type_headerN== 2'b10 || Type_headerN== 2'b11)
				next_stateN = MoveWestN;
			else
				next_stateN = IDLEN;
		end
		
		MoveLocalN: begin
			if(Type_headerN== 2'b01) begin
				if($signed(XdiffN) < 0)
					next_stateN = MoveWestN;
				else if($signed(XdiffN) > 0)
					next_stateN = MoveEastN;
				else begin
					if($signed(YdiffN) < 0)
						next_stateN = IDLEN; //won't happen;
					else if($signed(YdiffN) > 0)
						next_stateN = MoveSouthN;
					else
						next_stateN = MoveLocalN;
				end
			end
			else if(Type_headerN== 2'b10 || Type_headerN== 2'b11)
				next_stateN = MoveLocalN;
			else
				next_stateN = IDLEN;
		end
		endcase
		end
		
		always @(state_signalS,Type_headerS,XdiffS,YdiffS)
		begin
		case(state_signalS)
		IDLES :begin
			if(Type_headerS== 2'b01) begin
				if($signed(XdiffS) < 0)
					next_stateS = MoveWestS;
				else if($signed(XdiffS) > 0)
					next_stateS = MoveEastS;
				else begin
					if($signed(YdiffS) < 0)
						next_stateS = MoveNorthS;
					else if($signed(YdiffS) > 0)
						next_stateS = IDLES; //won't happen
					else
						next_stateS = MoveLocalS;
				end
			end
			else
				next_stateS = IDLES;			
		end
		
		MoveNorthS: begin
		/* XdiffS = XDestinationS - XPresent;
		YdiffS = YDestinationS - YPresent; */
			if(Type_headerS== 2'b01) begin
				if($signed(XdiffS) < 0)
					next_stateS = MoveWestS;
				else if($signed(XdiffS) > 0)
					next_stateS = MoveEastS;
				else begin
					if($signed(YdiffS) < 0)
						next_stateS = MoveNorthS;
					else if($signed(YdiffS) > 0)
						next_stateS = IDLES; //won't happen
					else
						next_stateS = MoveLocalS;
				end
			end
			else if(Type_headerS== 2'b10 || Type_headerS== 2'b11)
				next_stateS = MoveNorthS;
			else
				next_stateS = IDLES;
		end
		
		MoveEastS: begin
		/* XdiffS = XDestinationS - XPresent;
		YdiffS = YDestinationS - YPresent; */
			if(Type_headerS== 2'b01) begin
				if($signed(XdiffS) < 0)
					next_stateS = MoveWestS;
				else if($signed(XdiffS) > 0)
					next_stateS = MoveEastS;
				else begin
					if($signed(YdiffS) < 0)
						next_stateS = MoveNorthS;
					else if($signed(YdiffS) > 0)
						next_stateS = IDLES; //won't happen
					else
						next_stateS = MoveLocalS;
				end
			end
			else if(Type_headerS== 2'b10|| Type_headerS== 2'b11)
				next_stateS = MoveEastS;
			else
				next_stateS = IDLES;
		end
		
		MoveWestS: begin
		/* XdiffS = XDestinationS - XPresent;
		YdiffS = YDestinationS - YPresent; */
			if(Type_headerS== 2'b01) begin
				if($signed(XdiffS) < 0)
					next_stateS = MoveWestS;
				else if($signed(XdiffS) > 0)
					next_stateS = MoveEastS;
				else begin
					if($signed(YdiffS) < 0)
						next_stateS = MoveNorthS;
					else if($signed(YdiffS) > 0)
						next_stateS = IDLES; //won't happen
					else
						next_stateS = MoveLocalS;
				end
			end
			else if(Type_headerS== 2'b10|| Type_headerS== 2'b11)
				next_stateS = MoveWestS;
			else
				next_stateS = IDLES;
		end
		
		MoveLocalS: begin
		/* XdiffS = XDestinationS - XPresent;
		YdiffS = YDestinationS - YPresent; */
			if(Type_headerS== 2'b01) begin
				if($signed(XdiffS) < 0)
					next_stateS = MoveWestS;
				else if($signed(XdiffS) > 0)
					next_stateS = MoveEastS;
				else begin
					if($signed(YdiffS) < 0)
						next_stateS = MoveNorthS;
					else if($signed(YdiffS) > 0)
						next_stateS = IDLES; //won't happen
					else
						next_stateS = MoveLocalS;
				end
			end
			else if(Type_headerS== 2'b10|| Type_headerS== 2'b11)
				next_stateS = MoveLocalS;
			else
				next_stateS = IDLES;
		end
		endcase
	end
	
		always @(state_signalE,Type_headerE,XdiffE,YdiffE)
		begin
		case(state_signalE)
		IDLEE :begin
			if(Type_headerE== 2'b01) begin
				if($signed(XdiffE) < 0)
					next_stateE = MoveWestE;
				else if($signed(XdiffE) > 0)
					next_stateE = IDLEE; //won't happen
				else begin
					if($signed(YdiffE) < 0)
						next_stateE = MoveNorthE;
					else if($signed(YdiffE) > 0)
						next_stateE = MoveSouthE;
					else
						next_stateE = MoveLocalE;
				end
			end
			else
				next_stateE = IDLEE;			
		end
		
		MoveNorthE: begin
		/* XdiffE = XDestinationE - XPresent;
		YdiffE = YDestinationE - YPresent; */
			if(Type_headerE== 2'b01) begin
				if($signed(XdiffE) < 0)
					next_stateE = MoveWestE;
				else if($signed(XdiffE) > 0)
					next_stateE = IDLEE; //won't happen
				else begin
					if($signed(YdiffE) < 0)
						next_stateE = MoveNorthE;
					else if($signed(YdiffE) > 0)
						next_stateE = MoveSouthE;
					else
						next_stateE = MoveLocalE;
				end
			end
			else if(Type_headerE== 2'b10 || Type_headerE== 2'b11)
				next_stateE = MoveNorthE;
			else
				next_stateE = IDLEE;
		end
		
		MoveSouthE: begin
		/* XdiffE = XDestinationE - XPresent;
		YdiffE = YDestinationE - YPresent; */
			if(Type_headerE== 2'b01) begin
				if($signed(XdiffE) < 0)
					next_stateE = MoveWestE;
				else if($signed(XdiffE) > 0)
					next_stateE = IDLEE; //won't happen
				else begin
					if($signed(YdiffE) < 0)
						next_stateE = MoveNorthE;
					else if($signed(YdiffE) > 0)
						next_stateE = MoveSouthE;
					else
						next_stateE = MoveLocalE;
				end
			end
			else if(Type_headerE== 2'b10 || Type_headerE== 2'b11)
				next_stateE = MoveSouthE;
			else
				next_stateE = IDLEE;
		end
		
		MoveWestE: begin
		/* XdiffE = XDestinationE - XPresent;
		YdiffE = YDestinationE - YPresent; */
			if(Type_headerE== 2'b01) begin
				if($signed(XdiffE) < 0)
					next_stateE = MoveWestE;
				else if($signed(XdiffE) > 0)
					next_stateE = IDLEE; //won't happen
				else begin
					if($signed(YdiffE) < 0)
						next_stateE = MoveNorthE;
					else if($signed(YdiffE) > 0)
						next_stateE = MoveSouthE;
					else
						next_stateE = MoveLocalE;
				end
			end
			else if(Type_headerE== 2'b10 || Type_headerE== 2'b11)
				next_stateE = MoveWestE;
			else
				next_stateE = IDLEE;
		end
		
		MoveLocalE: begin
		/* XdiffE = XDestinationE - XPresent;
		YdiffE = YDestinationE - YPresent; */
			if(Type_headerE== 2'b01) begin
				if($signed(XdiffE) < 0)
					next_stateE = MoveWestE;
				else if($signed(XdiffE) > 0)
					next_stateE = IDLEE; //won't happen
				else begin
					if($signed(YdiffE) < 0)
						next_stateE = MoveNorthE;
					else if($signed(YdiffE) > 0)
						next_stateE = MoveSouthE;
					else
						next_stateE = MoveLocalE;
				end
			end
			else if(Type_headerE== 2'b10 || Type_headerE== 2'b11)
				next_stateE = MoveLocalE;
			else
				next_stateE = IDLEE;
		end
		endcase
	end
	
		always @(state_signalW,Type_headerW,XdiffW,YdiffW)
		begin
		case(state_signalW)
		IDLEW :begin
			if(Type_headerW== 2'b01) begin
				if($signed(XdiffW) < 0)
					next_stateW = IDLEW; //won't happen
				else if($signed(XdiffW) > 0)
					next_stateW = MoveEastW;
				else begin
					if($signed(YdiffW) < 0)
						next_stateW = MoveNorthW;
					else if($signed(YdiffW) > 0)
						next_stateW = MoveSouthW;
					else
						next_stateW = MoveLocalW;
				end
			end
			else
				next_stateW = IDLEW;			
		end
		
		MoveNorthW: begin
		/* XdiffW = XDestinationW - XPresent;
		YdiffW = YDestinationW - YPresent; */
			if(Type_headerW== 2'b01) begin
				if($signed(XdiffW) < 0)
					next_stateW = IDLEW; //won't happen
				else if($signed(XdiffW) > 0)
					next_stateW = MoveEastW;
				else begin
					if($signed(YdiffW) < 0)
						next_stateW = MoveNorthW;
					else if($signed(YdiffW) > 0)
						next_stateW = MoveSouthW;
					else
						next_stateW = MoveLocalW;
				end
			end
			else if(Type_headerW== 2'b10 || Type_headerW== 2'b11)
				next_stateW = MoveNorthW;
			else
				next_stateW = IDLEW;
		end
		
		MoveSouthW: begin
		/* XdiffW = XDestinationW - XPresent;
		YdiffW = YDestinationW - YPresent; */
			if(Type_headerW== 2'b01) begin
				if($signed(XdiffW) < 0)
					next_stateW = IDLEW; //won't happen
				else if($signed(XdiffW) > 0)
					next_stateW = MoveEastW;
				else begin
					if($signed(YdiffW) < 0)
						next_stateW = MoveNorthW;
					else if($signed(YdiffW) > 0)
						next_stateW = MoveSouthW;
					else
						next_stateW = MoveLocalW;
				end
			end
			else if(Type_headerW== 2'b10 || Type_headerW== 2'b11)
				next_stateW = MoveSouthW;
			else
				next_stateW = IDLEW;
		end
		
		MoveEastW: begin
		/* XdiffW = XDestinationW - XPresent;
		YdiffW = YDestinationW - YPresent; */
			if(Type_headerW== 2'b01) begin
				if($signed(XdiffW) < 0)
					next_stateW = IDLEW; //won't happen
				else if($signed(XdiffW) > 0)
					next_stateW = MoveEastW;
				else begin
					if($signed(YdiffW) < 0)
						next_stateW = MoveNorthW;
					else if($signed(YdiffW) > 0)
						next_stateW = MoveSouthW;
					else
						next_stateW = MoveLocalW;
				end
			end
			else if(Type_headerW== 2'b10 || Type_headerW== 2'b11)
				next_stateW = MoveEastW;
			else
				next_stateW = IDLEW;
		end
		
		MoveLocalW: begin
		/* XdiffW = XDestinationW - XPresent;
		YdiffW = YDestinationW - YPresent; */
			if(Type_headerW== 2'b01) begin
				if($signed(XdiffW) < 0)
					next_stateW = IDLEW; //won't happen
				else if($signed(XdiffW) > 0)
					next_stateW = MoveEastW;
				else begin
					if($signed(YdiffW) < 0)
						next_stateW = MoveNorthW;
					else if($signed(YdiffW) > 0)
						next_stateW = MoveSouthW;
					else
						next_stateW = MoveLocalW;
				end
			end
			else if(Type_headerW== 2'b10 || Type_headerW== 2'b11)
				next_stateW = MoveLocalW;
			else
				next_stateW = IDLEW;
		end
		endcase
	end
	
		always @(posedge clk)
		begin
			state_signalL <= next_stateL;
			state_signalN <= next_stateN;
			state_signalS <= next_stateS;
			state_signalE <= next_stateE;
			state_signalW <= next_stateW;
			
		end
		
		always @(state_signalL)
		begin
			case(state_signalL)
			IDLEL : begin
				MoveDownL<=1'b0;
				MoveUpL<=1'b0;
				MoveRightL<=1'b0;
				MoveLeftL<=1'b0; 
			end
			
			MoveNorthL :begin
				MoveDownL<=1'b0;
				MoveUpL<=1'b1;
				MoveRightL<=1'b0;
				MoveLeftL<=1'b0; 
			end
			
			MoveSouthL :begin
				MoveDownL<=1'b1;
				MoveUpL<=1'b0;
				MoveRightL<=1'b0;
				MoveLeftL<=1'b0; 
			end
			
			MoveEastL :begin
				MoveDownL<=1'b0;
				MoveUpL<=1'b0;
				MoveRightL<=1'b1;
				MoveLeftL<=1'b0; 
			end
			
			MoveWestL :begin	
				MoveDownL<=1'b0;
				MoveUpL<=1'b0;
				MoveRightL<=1'b0;
				MoveLeftL<=1'b1; 
			end
			
			endcase
			
		end
		
		always @(state_signalN)
		begin
			case(state_signalN)
			IDLEN : begin
				MoveCoreN <= 1'b0;	
				MoveDownN<=1'b0;
				MoveRightN<=1'b0;
				MoveLeftN<=1'b0; 
			end
			
			MoveSouthN :begin
				MoveCoreN <= 1'b0;	
				MoveDownN<=1'b1;
				MoveRightN<=1'b0;
				MoveLeftN<=1'b0; 
			end
			
			MoveEastN :begin
				MoveCoreN <= 1'b0;	
				MoveDownN<=1'b0;
				MoveRightN<=1'b1;
				MoveLeftN<=1'b0; 
			end
			
			MoveWestN :begin
				MoveCoreN <= 1'b0;	
				MoveDownN<=1'b0;
				MoveRightN<=1'b0;
				MoveLeftN<=1'b1; 
			end
			
			MoveLocalN :begin
				MoveCoreN <= 1'b1;	
				MoveDownN<=1'b0;
				MoveRightN<=1'b0;
				MoveLeftN<=1'b0; 
			end
			endcase
			
		end
		
		always @(state_signalS)
		begin
			case(state_signalS)
			IDLES : begin
				MoveCoreS <= 1'b0;	
				MoveUpS<=1'b0;
				MoveRightS<=1'b0;
				MoveLeftS<=1'b0; 
			end
			
			MoveNorthS :begin
				MoveCoreS <= 1'b0;	
				MoveUpS<=1'b1;
				MoveRightS<=1'b0;
				MoveLeftS<=1'b0; 
			end
			
			MoveEastS :begin
				MoveCoreS <= 1'b0;	
				MoveUpS<=1'b0;
				MoveRightS<=1'b1;
				MoveLeftS<=1'b0; 
			end
			
			MoveWestS :begin
				MoveCoreS <= 1'b0;	
				MoveUpS<=1'b0;
				MoveRightS<=1'b0;
				MoveLeftS<=1'b1; 
			end
			
			MoveLocalS :begin
				MoveCoreS <= 1'b1;	
				MoveUpS<=1'b0;
				MoveRightS<=1'b0;
				MoveLeftS<=1'b0; 
			end
			endcase
			
		end
		
		always @(state_signalE)
		begin
			case(state_signalE)
			IDLEE : begin
				MoveCoreE <= 1'b0;	
				MoveDownE<=1'b0;
				MoveUpE<=1'b0;
				MoveLeftE<=1'b0; 
			end
			
			MoveNorthE :begin
				MoveCoreE <= 1'b0;	
				MoveDownE<=1'b0;
				MoveUpE<=1'b1;
				MoveLeftE<=1'b0; 
			end
			
			MoveSouthE :begin
				MoveCoreE <= 1'b0;	
				MoveDownE<=1'b1;
				MoveUpE<=1'b0;
				MoveLeftE<=1'b0; 
			end
			
			MoveWestE :begin
				MoveCoreE <= 1'b0;	
				MoveDownE<=1'b0;
				MoveUpE<=1'b0;
				MoveLeftE<=1'b1; 
			end
			
			MoveLocalE :begin
				MoveCoreE <= 1'b1;	
				MoveDownE<=1'b0;
				MoveUpE<=1'b0;
				MoveLeftE<=1'b0; 
			end
			endcase
			
		end
		
		always @(state_signalW)
		begin
			case(state_signalW)
			IDLEW : begin
				MoveCoreW <= 1'b0;	
				MoveDownW<=1'b0;
				MoveUpW<=1'b0;
				MoveRightW<=1'b0;
			end
			
			MoveNorthW :begin
				MoveCoreW <= 1'b0;	
				MoveDownW<=1'b0;
				MoveUpW<=1'b1;
				MoveRightW<=1'b0;
			end
			
			MoveSouthW :begin
				MoveCoreW <= 1'b0;	
				MoveDownW<=1'b1;
				MoveUpW<=1'b0;
				MoveRightW<=1'b0;
			end
			
			MoveEastW :begin
				MoveCoreW <= 1'b0;	
				MoveDownW<=1'b0;
				MoveUpW<=1'b0;
				MoveRightW<=1'b1;
			end
			
			MoveLocalW :begin
				MoveCoreW <= 1'b1;	
				MoveDownW<=1'b0;
				MoveUpW<=1'b0;
				MoveRightW<=1'b0;
			end
			endcase
			
		end
		
		always @(XDestinationL,YDestinationL,XDestinationN,YDestinationN,XDestinationS,YDestinationS,XDestinationE,YDestinationE,XDestinationW,YDestinationW)
		begin
			XdiffL <= XDestinationL - XPresent;
			YdiffL <= YDestinationL - YPresent;
			XdiffN <= XDestinationN - XPresent;
			YdiffN <= YDestinationN - YPresent;
			XdiffS <= XDestinationS - XPresent;
			YdiffS <= YDestinationS - YPresent;
			XdiffE <= XDestinationE - XPresent;
			YdiffE <= YDestinationE - YPresent;
			XdiffW <= XDestinationW - XPresent;
			YdiffW <= YDestinationW - YPresent;
		end
		
		always @(negedge clk)
		begin
			if(Type_headerL== 2'b11)
				Data_requestL=1'b0;
			else
				Data_requestL=1'b1;
				
			if(Type_headerN== 2'b11)
				Data_requestN=1'b0;
			else
				Data_requestN=1'b1;
				
			if(Type_headerS== 2'b11)
				Data_requestS=1'b0;
			else
				Data_requestS=1'b1;
				
			if(Type_headerE== 2'b11)
				Data_requestE=1'b0;
			else
				Data_requestE=1'b1;
				
			if(Type_headerW== 2'b11)
				Data_requestW=1'b0;
			else
				Data_requestW=1'b1;
		end
 endmodule