module Switch_Allocator(clk,credit_inL,credit_inN,credit_inS,credit_inE,credit_inW,MoveUpL,MoveDownL,MoveRightL,MoveLeftL,MoveCoreN,MoveDownN,MoveRightN,MoveLeftN,MoveCoreS,MoveUpS,MoveRightS,MoveLeftS,MoveCoreE,MoveUpE,MoveDownE,MoveLeftE,MoveCoreW,MoveUpW,MoveDownW,MoveRightW,NSEWtoL,LSEWtoN,LNEWtoS,LNSWtoE,LNSEtoW,Data_RequestL,Data_RequestN,Data_RequestS,Data_RequestE,Data_RequestW);
	input clk;
	input credit_inL,credit_inN,credit_inS,credit_inE,credit_inW;
	input MoveUpL,MoveDownL,MoveRightL,MoveLeftL;
	input MoveCoreN,MoveDownN,MoveRightN,MoveLeftN;
	input MoveCoreS,MoveUpS,MoveRightS,MoveLeftS;
	input MoveCoreE,MoveUpE,MoveDownE,MoveLeftE;
	input MoveCoreW,MoveUpW,MoveDownW,MoveRightW;
	
	output reg[3:0] NSEWtoL;
	output reg[3:0] LSEWtoN;
	output reg[3:0] LNEWtoS;
	output reg[3:0] LNSWtoE;
	output reg[3:0] LNSEtoW;
	
	output reg Data_RequestL,Data_RequestN,Data_RequestS,Data_RequestE,Data_RequestW;	
	
	reg Data_RequestLN, Data_RequestLS, Data_RequestLE,  Data_RequestLW;
	reg Data_RequestNL, Data_RequestNS, Data_RequestNE, Data_RequestNW;
	reg Data_RequestSL, Data_RequestSN, Data_RequestSE,Data_RequestSW;
	reg Data_RequestEL,Data_RequestEN, Data_RequestES, Data_RequestEW;
	reg Data_RequestWL,Data_RequestWN, Data_RequestWS,Data_RequestWE;
	
	integer countL = 6,countN = 6,countS=6,countE =6,countW = 6;
	
	parameter IDLELocal=0,LocalN=1, LocalS=2, LocalE =3,LocalW = 4; 
	parameter IDLEUP=5,UpCore = 6, UpS=7, UpE = 8,UpW = 9; 
	parameter IDLEDN=10,DNCore = 11, DNN=12, DNE = 13,DNW = 14;
	parameter IDLER=15,RCore = 16, RN=17, RS = 18,RW = 19;
	parameter IDLEL=20,LCore = 21, LN=22, LS = 23,LE = 24;
	
	reg[2:0] state_signalL=IDLELocal, next_stateL; //Local ouput state
	reg[3:0] state_signalUp=IDLEUP, next_stateUP; //UP ouput state
	reg[3:0] state_signalDN=IDLEDN, next_stateDN; //DN ouput state
	reg[4:0] state_signalRight=IDLER, next_stateRight; //Right ouput state
	reg[4:0] state_signalLeft=IDLEL, next_stateLeft; //Left ouput state
	
	always @(state_signalL,MoveCoreN,MoveCoreS,MoveCoreE,MoveCoreW,countL)
	begin
	case(state_signalL)
	IDLELocal: begin
		if(countL>1) begin
			if(MoveCoreN==1'b1 )
				next_stateL = LocalN;
			else if(MoveCoreS==1'b1 )
				next_stateL = LocalS;
			else if(MoveCoreE==1'b1 )
				next_stateL = LocalE;
			else if(MoveCoreW==1'b1 )
				next_stateL = LocalW;
			else
				next_stateL = IDLELocal;
		end
		else
			next_stateL = IDLELocal;
	end
	
	
	LocalN: begin
		if(countL>1) begin
			if(MoveCoreN==1'b1 )
				next_stateL = LocalN;
			else if(MoveCoreS==1'b1 )
				next_stateL = LocalS;
			else if(MoveCoreE==1'b1 )
				next_stateL = LocalE;
			else if(MoveCoreW==1'b1 )
				next_stateL = LocalW;
			else
				next_stateL = IDLELocal;
		end
		else
			next_stateL = IDLELocal;
	end
	
	LocalS: begin
		if(countL>1) begin
			if(MoveCoreS==1'b1 )
				next_stateL = LocalS;
			else if(MoveCoreN==1'b1 )
				next_stateL = LocalN;
			else if(MoveCoreE==1'b1 )
				next_stateL = LocalE;
			else if(MoveCoreW==1'b1 )
				next_stateL = LocalW;
			else
				next_stateL = IDLELocal;
		end
		else
			next_stateL = IDLELocal;
	end
	
	LocalE: begin
		if(countL>1) begin
			if(MoveCoreE==1'b1 )
				next_stateL = LocalE;
			else if(MoveCoreN==1'b1 )
				next_stateL = LocalN;
			else if(MoveCoreS==1'b1 )
				next_stateL = LocalS;
			else if(MoveCoreW==1'b1 )
				next_stateL = LocalW;
			else 
				next_stateL = IDLELocal;
		end
		else
			next_stateL = IDLELocal;
	end
	
	LocalW: begin
		if(countL>1) begin
			if(MoveCoreW==1'b1 )
				next_stateL = LocalW;
			else if(MoveCoreN==1'b1 )
				next_stateL = LocalN;
			else if(MoveCoreS==1'b1 )
				next_stateL = LocalS;
			else if(MoveCoreE==1'b1 )
				next_stateL = LocalE; 
			else
				next_stateL = IDLELocal;
		end
		else
			next_stateL = IDLELocal;
	end
	
	endcase
	end
	
	always @(state_signalUp,MoveUpL,MoveUpS,MoveUpE,MoveUpW,countN)
	begin
	case(state_signalUp)
	
	IDLEUP: begin
		if(countN>1) begin
			if(MoveUpL==1'b1 )
				next_stateUP = UpCore;
			else if(MoveUpS==1'b1 )
				next_stateUP = UpS;
			else if(MoveUpE==1'b1 )
				next_stateUP = UpE;
			else if(MoveUpW==1'b1 )
				next_stateUP = UpW;
			else
				next_stateUP = IDLEUP;
		end
		else
			next_stateUP = IDLEUP;
	end
	
	UpCore: begin
		if(countN>1) begin
			if(MoveUpL==1'b1 )
				next_stateUP = UpCore;
			else if(MoveUpS==1'b1 )
				next_stateUP = UpS;
			else if(MoveUpE==1'b1 )
				next_stateUP = UpE;
			else if(MoveUpW==1'b1 )
				next_stateUP = UpW; 
			else
				next_stateUP = IDLEUP;
		end
		else
			next_stateUP = IDLEUP;
	end
	
	UpS: begin
		if(countN>1) begin
			if(MoveUpS==1'b1 )
				next_stateUP = UpS;
			else if(MoveUpL==1'b1 )
				next_stateUP = UpCore;
			else if(MoveUpE==1'b1 )
				next_stateUP = UpE;
			else if(MoveUpW==1'b1 )
				next_stateUP = UpW;
			else
				next_stateUP = IDLEUP;
		end
		else
			next_stateUP = IDLEUP;
	end
	
	UpE: begin
		if(countN>1) begin
			if(MoveUpE==1'b1 )
				next_stateUP = UpE;
			else if(MoveUpL==1'b1 )
				next_stateUP = UpCore;
			else if(MoveUpS==1'b1 )
				next_stateUP = UpS;
			else if(MoveUpW==1'b1 )
				next_stateUP = UpW;
			else
				next_stateUP = IDLEUP;
		end
		else
			next_stateUP = IDLEUP;
	end
	
	UpW: begin
		if(countN>1) begin
			if(MoveUpW==1'b1 )
				next_stateUP = UpW;
			else if(MoveUpL==1'b1 )
				next_stateUP = UpCore;
			else if(MoveUpS==1'b1 )
				next_stateUP = UpS;
			else if(MoveUpE==1'b1 )
				next_stateUP = UpE; 
			else
				next_stateUP = IDLEUP;
		end
		else
			next_stateUP = IDLEUP;
	end
	
	endcase
	end
	
	always @(state_signalDN,MoveDownL,MoveDownN,MoveDownE,MoveDownW,countS)
	begin
	case(state_signalDN)
	
	IDLEDN: begin
		if(countS>1) begin
			if(MoveDownL==1'b1)
				next_stateDN = DNCore;
			else if(MoveDownN==1'b1)
				next_stateDN = DNN;
			else if(MoveDownE==1'b1)
				next_stateDN = DNE;
			else if(MoveDownW==1'b1)
				next_stateDN = DNW;
			else
				next_stateDN = IDLEDN;
		end
		else
			next_stateDN = IDLEDN;
	end
	
	DNCore: begin
		if(countS>1) begin
			if(MoveDownL==1'b1)
				next_stateDN = DNCore;
			else if(MoveDownN==1'b1)
				next_stateDN = DNN;
			else if(MoveDownE==1'b1)
				next_stateDN = DNE;
			else if(MoveDownW==1'b1)
				next_stateDN = DNW;
			else
				next_stateDN = IDLEDN;
		end
		else
			next_stateDN = IDLEDN;
	end
	
	DNN: begin
		if(countS>1) begin
			if(MoveDownN==1'b1)
				next_stateDN = DNN;
			else if(MoveDownL==1'b1)
				next_stateDN = DNCore;
			else if(MoveDownE==1'b1)
				next_stateDN = DNE;
			else if(MoveDownW==1'b1)
				next_stateDN = DNW;
			else
				next_stateDN = IDLEDN;
		end
		else
			next_stateDN = IDLEDN;
	end
	
	DNE: begin
		if(countS>1) begin
			if(MoveDownE==1'b1)
				next_stateDN = DNE;
			else if(MoveDownL==1'b1)
				next_stateDN = DNCore;
			else if(MoveDownN==1'b1)
				next_stateDN = DNN; 
			else if(MoveDownW==1'b1)
				next_stateDN = DNW;
			else
				next_stateDN = IDLEDN;
		end
		else
			next_stateDN = IDLEDN;
	end
	
	DNW: begin
		if(countS>1) begin
			if(MoveDownW==1'b1)
				next_stateDN = DNW;
			else if(MoveDownL==1'b1)
				next_stateDN = DNCore;
			else if(MoveDownN==1'b1)
				next_stateDN = DNN;
			else if(MoveDownE==1'b1)
				next_stateDN = DNE; 
			else
				next_stateDN = IDLEDN;
		end
		else
			next_stateDN = IDLEDN;
	end
	
	endcase
	end
	
	always @(state_signalRight,MoveRightL,MoveRightN,MoveRightS,MoveRightW,countE)
	begin
	case(state_signalRight)
		IDLER: begin
			if(countE>1) begin
				if(MoveRightL==1'b1 )
					next_stateRight = RCore;
				else if(MoveRightN==1'b1 )
					next_stateRight = RN;
				else if(MoveRightS==1'b1 )
					next_stateRight = RS;
				else if(MoveRightW==1'b1 )
					next_stateRight = RW;
				else
					next_stateRight = IDLER;
			end
			else
				next_stateRight = IDLER;
		end
		
		RCore:begin
			if(countE>1) begin
				if(MoveRightL==1'b1 )
					next_stateRight = RCore;
				else if(MoveRightN==1'b1 )
					next_stateRight = RN;
				else if(MoveRightS==1'b1 )
					next_stateRight = RS;
				else if(MoveRightW==1'b1 )
					next_stateRight = RW;
				else
					next_stateRight = IDLER;
			end
			else
				next_stateRight = IDLER;
		end
		
		RN: begin
			if(countE>1) begin
				if(MoveRightN==1'b1 )
					next_stateRight = RN;
				else if(MoveRightL==1'b1 )
					next_stateRight = RCore;
				else if(MoveRightS==1'b1 )
					next_stateRight = RS;
				else if(MoveRightW==1'b1 )
					next_stateRight = RW;
				else
					next_stateRight = IDLER;
			end
			else
				next_stateRight = IDLER;
		end
		
		RS: begin
			if(countE>1) begin
				if(MoveRightS==1'b1 )
					next_stateRight = RS;
				else if(MoveRightL==1'b1 )
					next_stateRight = RCore;
				else if(MoveRightN==1'b1 )
					next_stateRight = RN;
				else if(MoveRightW==1'b1 )
					next_stateRight = RW; 
				else
					next_stateRight = IDLER;
			end
			else
				next_stateRight = IDLER;
		end
		
		RW: begin
			if(countE>1) begin
				if(MoveRightW==1'b1 )
					next_stateRight = RW;
				else if(MoveRightL==1'b1 )
					next_stateRight = RCore;
				else if(MoveRightN==1'b1 )
					next_stateRight = RN;
				else if(MoveRightS==1'b1 )
					next_stateRight = RS;
				else
					next_stateRight = IDLER;
			end
			else
				next_stateRight = IDLER;
		end
	endcase
	end
	
	always @(state_signalLeft,MoveLeftL,MoveLeftN,MoveLeftS,MoveLeftE,countW)
	begin
	case(state_signalLeft)
	IDLEL: begin
		if(countW>1) begin
			if(MoveLeftL==1'b1 )
				next_stateLeft = LCore;
			else if(MoveLeftN==1'b1 )
				next_stateLeft = LN;
			else if(MoveLeftS==1'b1 )
				next_stateLeft = LS;
			else if(MoveLeftE==1'b1 )
				next_stateLeft = LE;
			else
					next_stateLeft = IDLEL;	
		end
		else
			next_stateLeft = IDLEL;
	end
	
	LCore: begin
		if(countW>1) begin
			if(MoveLeftL==1'b1 )
				next_stateLeft = LCore;
			else if(MoveLeftN==1'b1 )
				next_stateLeft = LN;
			else if(MoveLeftS==1'b1 )
				next_stateLeft = LS;
			else if(MoveLeftE==1'b1 )
				next_stateLeft = LE;
			else
					next_stateLeft = IDLEL;	
		end
		else
			next_stateLeft = IDLEL;
	end
	
	LN: begin
		if(countW>1) begin
			if(MoveLeftN==1'b1 )
				next_stateLeft = LN;
			else if(MoveLeftL==1'b1 )
				next_stateLeft = LCore;
			else if(MoveLeftS==1'b1 )
				next_stateLeft = LS;
			else if(MoveLeftE==1'b1 )
				next_stateLeft = LE;
			else
				next_stateLeft = IDLEL;	
		end
		else
			next_stateLeft = IDLEL;
	end
	
	LS: begin
		if(countW>1) begin
			if(MoveLeftS==1'b1 )
				next_stateLeft = LS;
			else if(MoveLeftL==1'b1 )
				next_stateLeft = LCore;
			else if(MoveLeftN==1'b1 )
				next_stateLeft = LN;
			else if(MoveLeftE==1'b1 )
				next_stateLeft = LE;
			else
					next_stateLeft = IDLEL;	
		end
		else
			next_stateLeft = IDLEL;
	end
	
	LE: begin
		if(countW>1) begin
			if(MoveLeftE==1'b1 )
				next_stateLeft = LE;
			else if(MoveLeftL==1'b1 )
				next_stateLeft = LCore;
			else if(MoveLeftN==1'b1 )
				next_stateLeft = LN;
			else if(MoveLeftS==1'b1 )
				next_stateLeft = LS;
			else
					next_stateLeft = IDLEL;	
		end
		else
			next_stateLeft = IDLEL;
	end
	
	endcase
	end
	
	always @(negedge clk)
	begin
		state_signalL <= next_stateL;
		state_signalUp <= next_stateUP;
		state_signalDN <= next_stateDN;
		state_signalRight <= next_stateRight;
		state_signalLeft <= next_stateLeft;
		
		if(next_stateL==IDLELocal) begin
			if(credit_inL==1'b1)
				countL <= countL+1;
		end
		else begin
			if(credit_inL!=1'b1)
				countL <= countL-1;
		end
			
		if(next_stateUP==IDLEUP) begin
			if(credit_inN==1'b1)
				countN <= countN+1;
		end
		else begin
			if(credit_inN!=1'b1)
				countN <= countN-1;
		end
			
		if(next_stateDN==IDLEDN) begin
			if(credit_inS==1'b1)
				countS <= countS+1;
		end
		else begin
			if(credit_inS!=1'b1)
				countS <= countS-1;
		end
		
		if(next_stateRight==IDLER) begin
			if(credit_inE==1'b1)
				countE <= countE+1;
		end
		else begin
			if(credit_inE!=1'b1)
				countE <= countE-1;
		end
			
			
		if(next_stateLeft==IDLEL) begin
			if(credit_inW==1'b1)
				countW <= countW+1;
		end
		else begin
			if(credit_inW!=1'b1)
				countW <= countW-1;
		end
	
	end
	
	always @(state_signalL)
	begin
	case(state_signalL)
		IDLELocal: begin
			Data_RequestLN <= 1'b0;
			Data_RequestLS <= 1'b0;
			Data_RequestLE <= 1'b0;
			Data_RequestLW <= 1'b0;
			
			NSEWtoL <= 4'b0000;
		end
		
		LocalN: begin
			Data_RequestLN <=1'b1;
			Data_RequestLS <= 1'b0;
			Data_RequestLE <= 1'b0;
			Data_RequestLW <= 1'b0;
			
			NSEWtoL <= 4'b1000;
			
		end
		
		LocalS: begin
			Data_RequestLN <=1'b0;
			Data_RequestLS <= 1'b1;
			Data_RequestLE <= 1'b0;
			Data_RequestLW <= 1'b0;
			
			NSEWtoL <= 4'b0100;
			
			
		end
		
		LocalE: begin
			Data_RequestLN <=1'b0;
			Data_RequestLS <= 1'b0;
			Data_RequestLE <= 1'b1;
			Data_RequestLW <= 1'b0;
			
			NSEWtoL <= 4'b0010;
			
			
		end
		
		LocalW: begin
			Data_RequestLN <=1'b0;
			Data_RequestLS <= 1'b0;
			Data_RequestLE <= 1'b1;
			Data_RequestLW <= 1'b1;
			
			NSEWtoL <= 4'b0001;
			
			
		end
	endcase
	end
	
	always @(state_signalUp)
	begin
	case(state_signalUp)
		IDLEUP: begin
			Data_RequestNL <=1'b0; 
			Data_RequestNS <=1'b0; 
			Data_RequestNE <=1'b0; 
			Data_RequestNW <=1'b0; 
			
			LSEWtoN = 4'b0000;
		end
		
		UpCore:begin
			Data_RequestNL <=1'b1; 
			Data_RequestNS <=1'b0; 
			Data_RequestNE <=1'b0; 
			Data_RequestNW <=1'b0;
			
			LSEWtoN <= 4'b1000;
			
			
		end
		
		UpS: begin
			Data_RequestNL <=1'b0; 
			Data_RequestNS <=1'b1; 
			Data_RequestNE <=1'b0; 
			Data_RequestNW <=1'b0;
			
			LSEWtoN <= 4'b0100;
			
			
			
		end
		
		UpE: begin
			Data_RequestNL <=1'b0; 
			Data_RequestNS <=1'b0; 
			Data_RequestNE <=1'b1; 
			Data_RequestNW <=1'b0;
			
			LSEWtoN <= 4'b0010;
			
			
			
		end
		
		UpW: begin
			Data_RequestNL <=1'b0; 
			Data_RequestNS <=1'b0; 
			Data_RequestNE <=1'b0; 
			Data_RequestNW <=1'b1;
			
			LSEWtoN <= 4'b0001;
			
			
			
		end
	endcase
	end
	
	always @(state_signalDN)
	begin
	case(state_signalDN)
	IDLEDN: begin
		Data_RequestSL <=1'b0; 
		Data_RequestSN <=1'b0; 
		Data_RequestSE <=1'b0; 
		Data_RequestSW <=1'b0;
			
		LNEWtoS <= 4'b0000;
	end
	
	DNCore: begin
		Data_RequestSL <=1'b1; 
		Data_RequestSN <=1'b0; 
		Data_RequestSE <=1'b0; 
		Data_RequestSW <=1'b0;
		
		LNEWtoS <= 4'b1000;
		
		
	end
	
	DNN: begin
		Data_RequestSL <=1'b0; 
		Data_RequestSN <=1'b1; 
		Data_RequestSE <=1'b0; 
		Data_RequestSW <=1'b0;
		
		LNEWtoS <= 4'b0100;
		
		
	end
	
	DNE: begin
		Data_RequestSL <=1'b0; 
		Data_RequestSN <=1'b0; 
		Data_RequestSE <=1'b1; 
		Data_RequestSW <=1'b0;
		
		LNEWtoS <= 4'b0010;
		
		
	end
	
	DNW: begin
		Data_RequestSL <=1'b0; 
		Data_RequestSN <=1'b0; 
		Data_RequestSE <=1'b0; 
		Data_RequestSW <=1'b1;
		
		LNEWtoS <= 4'b0001;
		
		
	end
	
	endcase
	end
	
	always @(state_signalRight)
	begin
	case(state_signalRight)
		IDLER: begin
			Data_RequestEL <=1'b0; 
			Data_RequestEN <=1'b0; 
			Data_RequestES <=1'b0; 
			Data_RequestEW <=1'b0;
		
			LNSWtoE <= 4'b0000;
		end
		
		RCore: begin
			Data_RequestEL <=1'b1; 
			Data_RequestEN <=1'b0; 
			Data_RequestES <=1'b0; 
			Data_RequestEW <=1'b0;
			
			LNSWtoE <= 4'b1000;
		
		end
		
		RN: begin
			Data_RequestEL <=1'b0; 
			Data_RequestEN <=1'b1; 
			Data_RequestES <=1'b0; 
			Data_RequestEW <=1'b0;
			
			LNSWtoE <= 4'b0100;
			
		
		end
		
		RS: begin
			Data_RequestEL <=1'b0; 
			Data_RequestEN <=1'b0; 
			Data_RequestES <=1'b1; 
			Data_RequestEW <=1'b0;
			
			LNSWtoE <= 4'b0010;
			
		end
		
		RW: begin
			Data_RequestEL <=1'b0; 
			Data_RequestEN <=1'b0; 
			Data_RequestES <=1'b0; 
			Data_RequestEW <=1'b1;
			
			LNSWtoE <= 4'b0001;
		
		end
		
	endcase
	end
	
	always @(state_signalLeft)
	begin
	case(state_signalLeft)
		IDLEL: begin
			Data_RequestWL <=1'b0; 
			Data_RequestWN <=1'b0; 
			Data_RequestWS <=1'b0; 
			Data_RequestWE <=1'b0;
			
			LNSEtoW <= 4'b0000;
		end
		
		LCore: begin
			Data_RequestWL <=1'b1; 
			Data_RequestWN <=1'b0; 
			Data_RequestWS <=1'b0; 
			Data_RequestWE <=1'b0;
			
			LNSEtoW <= 4'b1000;
			
			
		end
		
		LN: begin
			Data_RequestWL <=1'b0; 
			Data_RequestWN <=1'b1; 
			Data_RequestWS <=1'b0; 
			Data_RequestWE <=1'b0;
			
			LNSEtoW <= 4'b0100;
			
			
		end
		
		LS: begin
			Data_RequestWL <=1'b0; 
			Data_RequestWN <=1'b0; 
			Data_RequestWS <=1'b1; 
			Data_RequestWE <=1'b0;
			
			LNSEtoW <= 4'b0010;
			
			
		end
		
		LE: begin
			Data_RequestWL <=1'b0; 
			Data_RequestWN <=1'b0; 
			Data_RequestWS <=1'b0; 
			Data_RequestWE <=1'b1;
			
			LNSEtoW <= 4'b0001;
			
			
		end
		
	endcase
	end
	

	always @(Data_RequestLN,Data_RequestLS,Data_RequestLE ,Data_RequestLW,Data_RequestNL,Data_RequestNS,Data_RequestNE,Data_RequestNW,Data_RequestSL,Data_RequestSN,Data_RequestSE,Data_RequestSW,Data_RequestEL,Data_RequestEN,Data_RequestES,Data_RequestEW,Data_RequestWL,Data_RequestWN,Data_RequestWS,Data_RequestWE)
	begin
		Data_RequestL <= Data_RequestNL | Data_RequestSL | Data_RequestEL | Data_RequestWL;
		Data_RequestN <= Data_RequestLN | Data_RequestSN | Data_RequestEN | Data_RequestWN;
		Data_RequestS <= Data_RequestLS | Data_RequestNS | Data_RequestES | Data_RequestWS;
		Data_RequestE <= Data_RequestLE | Data_RequestNE | Data_RequestSE | Data_RequestWE;
		Data_RequestW <= Data_RequestLW | Data_RequestNW | Data_RequestSW | Data_RequestEW;
	end
	
	endmodule
	