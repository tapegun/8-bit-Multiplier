//4-bit logic processor top level module
//for use with ECE 385 Spring 2021
//last modified by Zuofu Cheng


//Always use input/output logic types when possible, prevents issues with tools that have strict type enforcement

module Processor (input logic   Clk,     // Internal
                                clearALoadB,  
                                Execute,
						input logic	[7:0]  Switches,
				  //Hint for SignalTap, you want to comment out the following 2 lines to hardwire values for F and R
//                  output logic [3:0]  LED,     // DEBUG
                  output logic [7:0]  Aval,    // DEBUG
                                Bval,    // DEBUG
                  output logic [6:0]  AhexL,
                                AhexU,
                                BhexL,
                                BhexU);

	 //local logic variables go here
	 logic Reset_SH, LoadA_SH, LoadB_SH, Execute_SH;
	 logic Ld_XA, Ld_B, newA, newB, opA, opB, bitA, bitB, Shift_En, add, sub
	 logic [3:0] A, B, Din_S;
	 logic x;
	 //logic for counter
	 logic cntEn;
	 logic [2:0] curr_count;
	 
	 
	 //We can use the "assign" statement to do simple combinational logic
	 assign Aval = A;
	 assign Bval = B;
	 
//	 assign LED = {Execute_SH,LoadA_SH,LoadB_SH,Reset_SH}; //Concatenate is a common operation in HDL
	 assign x = 1'b0
	 
	 //Note that you can hardwire F and R here with 'assign'. What to assign them to? Check the demo points!
	 //Remember that when you comment out the ports above, you will need to define F and R as variables
	 //uncomment the following lines when you hardwaire F and R (This was the solution to the problem during Q/A)
	 
	 //Instantiation of modules here
	 register_unit    reg_unit (
                        .Clk(Clk),
                        .Reset(Reset_SH),
								.x,
                        .Ld_XA, //note these are inferred assignments, because of the existence a logic variable of the same name
                        .Ld_B,
                        .Shift_En,
                        .D(Switches),
                        .A(Aval),
                        .B(Bval) );
					
	//inputs: reset, CLK, cntEn
	//outputs: [2:0] Dout
	counter8 counter (.reset(), CLK(Clk), .cntEn(cntEn) //inputs
							, .Dout(curr_count));					//outputs
								
	 control          control_unit (
                        .Clk(Clk),
                        .Reset(Reset_SH),
                        .LoadA(LoadA_SH), 
                        .LoadB(LoadB_SH),
                        .Execute(Execute_SH),
                        .Shift_En,
								.add,
								.sub,
                        .Ld_XA,
                        .Ld_B );
								
								
							//inputs: shift, add, sub, [7:0] A, [7:0] S, clearA_LoadB, clearA, clk, reset
							//outputs: [7:0] Aout, x, m
	 multiplier       values (.shift(Shift_En), .sub_add(sub_add),  .A(A), .S(Switches), .clk(Clk), .Aout(A_val), .x(x))
	 
	 HexDriver        HexAL (
                        .In0(A[3:0]),
                        .Out0(AhexL) );
	 HexDriver        HexBL (
                        .In0(B[3:0]),
                        .Out0(BhexL) );
								
	 //When you extend to 8-bits, you will need more HEX drivers to view upper nibble of registers, for now set to 0
	 HexDriver        HexAU (
                        .In0(4'h0),
                        .Out0(AhexU) );	
	 HexDriver        HexBU (
                       .In0(4'h0),
                        .Out0(BhexU) );
								
	  //Input synchronizers required for asynchronous inputs (in this case, from the switches)
	  //These are array module instantiations
	  //Note: S stands for SYNCHRONIZED, H stands for active HIGH
	  //Note: We can invert the levels inside the port assignments
	  sync button_sync[3:0] (Clk, {~Reset, LoadA, LoadB, ~Execute}, {Reset_SH, LoadA_SH, LoadB_SH, Execute_SH});
	  sync Din_sync[3:0] (Clk, Din, Din_S);
	  sync F_sync[2:0] (Clk, F, F_S);
	  sync R_sync[1:0] (Clk, R, R_S);
	  
endmodule
