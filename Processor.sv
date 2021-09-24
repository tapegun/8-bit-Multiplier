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
	 
	 logic LD_XA, LD_B, Shift_EN, Cnt_EN, Clr_XA, SUB_ADD; //outputs of control unit
	 logic [2:0] curr_count; //output of counter
	 logic x, M;

					
	//inputs: reset, CLK, cntEn
	//outputs: [2:0] Dout
	counter8 counter (.reset(), CLK(Clk), .cntEn(cntEn) //inputs
							, .Dout(curr_count));					//outputs
								
	 control          control_unit (.Clk(Clk), .Reset(ClearALoadB), .Run(Execute), .M(M), .count(curr_count),
						.LD_XA(LD_XA), .LD_B(LD_B), .Shift_EN(Shift_EN), .Cnt_EN(Cnt_EN), .Clr_XA(Clr_XA), .SUB_ADD(SUB_ADD));
								
								
							//inputs: shift, add, sub, [7:0] A, [7:0] S, clearA_LoadB, clearA, clk, reset
							//outputs: [7:0] Aout, x, m
	 multiplier       values (.shift(Shift_En), .sub_add(SUB_ADD),  .A(Aval), .S(Switches), .clk(Clk),
										.Aout(A_val), .x(x));
										
	register_unit    reg_unit (
                        .Clk(Clk),
                        .Reset(Clr_XA),
                        .x,
                        .Ld_XA, //note these are inferred assignments, because of the existence a logic variable of the same name
                        .Ld_B,
                        .Shift_En,
                        .D(Switches),
                        .A(Aval),
                        .B(Bval) );
	 
	 HexDriver        HexAL (
                        .In0(Aval[3:0]),
                        .Out0(AhexL) );
	 HexDriver        HexBL (
                        .In0(Bval[3:0]),
                        .Out0(BhexL) );
								
	 //When you extend to 8-bits, you will need more HEX drivers to view upper nibble of registers, for now set to 0
	 HexDriver        HexAU (
                        .In0(Aval[7:4]),
                        .Out0(AhexU) );	
	 HexDriver        HexBU (
                       .In0(Bval[7:4]),
                        .Out0(BhexU) );
								
	  //Input synchronizers required for asynchronous inputs (in this case, from the switches)
	  //These are array module instantiations
	  //Note: S stands for SYNCHRONIZED, H stands for active HIGH
	  //Note: We can invert the levels inside the port assignments
	  //sync button_sync[3:0] (Clk, {~Reset, LoadA, LoadB, ~Execute}, {Reset_SH, LoadA_SH, LoadB_SH, Execute_SH});
	  sync Din_sync[7:0] (Clk, Switches);
	  
endmodule
