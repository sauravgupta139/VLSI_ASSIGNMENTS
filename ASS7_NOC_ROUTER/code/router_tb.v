`timescale 1us/1ns
module router_tb;
	wire Credit_outL,Credit_outN,Credit_outS,Credit_outE,Credit_outW;
	wire[31:0] Local_output,North_output,South_output,East_output,West_output;
	
	reg clk;
	reg[31:0] input_flit_Local, input_flit_North, input_flit_South, input_flit_East,input_flit_West;
	reg credit_inL,credit_inN,credit_inS,credit_inE,credit_inW;
	
	router DUT(clk,input_flit_Local,input_flit_North, input_flit_South, input_flit_East,input_flit_West,credit_inL,credit_inN,credit_inS,credit_inE,credit_inW,Credit_outL,Credit_outN,Credit_outS,Credit_outE,Credit_outW,Local_output,North_output,South_output,East_output,West_output);  
	
	initial
	begin
		$dumpfile("run.vcd");
		$dumpvars(0,router_tb);
		clk=1'b1;
		credit_inE=1'b0;credit_inL=1'b0;
		credit_inN=1'b0;credit_inS=1'b0; 
		credit_inW=1'b0;
		
		input_flit_Local <= 32'h40FABCDE; //from local to east
		input_flit_West <= 32'h404ABCDE; //from west to north
		input_flit_South <= 32'h404FFFAA; //from south to north
		input_flit_East <= 32'h49612345; //from east to south
		input_flit_North <= 32'h00000000;
		
		
		#80 input_flit_Local <= 32'h856789AB;
			input_flit_West <= 32'h865677AC;
			input_flit_South <= 32'h804FBBAA;
			input_flit_East <= 32'h88912345;
			input_flit_North <= 32'h447ABEFA; //from north to south
			
			
		#80 input_flit_Local <= 32'h91234567;
			input_flit_West <= 32'h912377AC;
			input_flit_South <= 32'h945FFAAA;
			input_flit_East <= 32'h96123457;
			input_flit_North <= 32'h884ABAFF;
			
			
		#80 input_flit_Local <= 32'hAABCDEF1;
			input_flit_West <= 32'hA67897AC;
			input_flit_South <= 32'hC012FBCA;
			input_flit_East <= 32'hCFFA0000;
			input_flit_North <= 32'h944ABAAA;
			
			credit_inN <=1'b1;
			credit_inE <=1'b1;
			credit_inS <=1'b1;
			
		#80 input_flit_Local <= 32'hB3456789;
			input_flit_West <= 32'hB65677AC;
			input_flit_South <= 32'h00000000;
			input_flit_East <= 32'h00000000;
			input_flit_North <= 32'h00000000;
			
			
		#80 input_flit_Local <= 32'hC7891412;
			input_flit_West <= 32'hC65677AC;
			
		#80 input_flit_Local <= 32'h00000000;
			input_flit_West <= 32'h00000000;
		
		#80 input_flit_Local <=32'h406AB567;
		#80 input_flit_Local <=32'h896AB567;
		#80 credit_inE <=1'b0;
			input_flit_Local <=32'hC1230000;
			
		#80 input_flit_Local <=32'h00000000;
		#80	credit_inS <=1'b0;
		#240 credit_inN <=1'b0;
			
		#600 $finish;
	end

	always
	begin
		clk = #40 ~clk;
	end
			
    endmodule