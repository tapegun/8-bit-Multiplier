//4-bit logic processor top level module
//for use with ECE 385 Spring 2021
//last modified by Zuofu Cheng


//Always use input/output logic types when possible, prevents issues with tools that have strict type enforcement

module Processor (input logic   Clk,     // Internal
                                clearALoadB,  
                                Execute,
						input logic	[7:0] Switches,
				  //Hint for SignalTap, you want to comment out the following 2 lines to hardwire values for F and R
//                  output logic [3:0]  LED,     // DEBUG
                  output logic [7:0]  Aval,    // DEBUG
                                Bval,			  
						output logic [9:0] States,// DEBUG
                  output logic [6:0]  AhexL,
                                AhexU,
                                BhexL,
                                BhexU);

	 //local logic variables go here
	 logic [7:0] A, B, S;
	 logic [8:0] Sum;
//	 assign Aval = A;
//	 assign Bval = B;
	 logic LD_XA, LD_B, Shift_EN, Clr_XA, SUB_ADD; //outputs of control unit
	 logic [2:0] curr_count; //output of counter
	 logic x, M;
	 
	 logic Shift_En, Clr_Ld, Reset_c, Add, Fn, D_;
	
//	logic Reset_h, ClearA_LoadB_h, Run_h; 
//	always_comb
//	begin
//		Reset_h = ~Reset;
//		ClearA_LoadB_h = ~ClearA_LoadB;
//		Run_h = ~Run;
//	end
	 
	 multiplier Adder(.*,
						.A,
						.B(Switches),
						.sub_add(SUB_ADD),
						.Aout(Sum));
						
	Control	control_unit(.*,
						.Reset(~Reset),
						.ClearA_LoadB(~clearALoadB),
						.Run(~Execute),
						.M (B_Out),
						.Shift_En(Shift_EN),
						.LD_B, 
						.LD_XA, 
						.Fn(SUB_ADD), 
						.Reset_c(~Reset));

	 
	 reg1     soloRegister(.*,
						.Clk,
						.Load(LD_XA),
						.Reset(clearALoadB | Clr_XA),
						.D(Sum[8]),
						.Q(X));
						
	reg_8		Reg_A(.*,
						.Reset(clearALoadB | Clr_XA),
						.Shift_In(X),
						.Load(LD_XA),
						.D(Sum[7:0]),
						.Shift_Out(S),
						.Data_Out(A));
					
	reg_8		Reg_B(.*,
						.Reset(Reset_C),
						.Shift_In(S),
						.Load(LD_B),
						.D(Switches),
						.Shift_Out(),
						.Data_Out(B));	
						
					
	//inputs: reset, CLK, cntEn
	//outputs: [2:0] Dout
//	counter8 counter (.reset(0), .CLK(Clk), .cntEn(cntEn), .Dout(curr_count));					//outputs
//	
//	 control          control_unit (.Clk(Clk), .Reset(~clearALoadB), .Run(~Execute), .M, .count(curr_count),
//						.LD_XA, .LD_B, .Shift_EN, .Clr_XA, .SUB_ADD, .States);
//								
//								
//							//inputs: shift, add, sub, [7:0] A, [7:0] S, clearA_LoadB, clearA, clk, reset
//							//outputs: [7:0] Aout, x, m
//	 multiplier       values (.sub_add(SUB_ADD),  .A(A), .S(Switches),
//										.Aout(A), .x(x));
//										
//	
//										
//	register_unit    reg_unit (
//                        .Clk(Clk),
//                        .Reset(Clr_XA),
//                        .x,
//                        .Ld_XA(LD_XA), //note these are inferred assignments, because of the existence a logic variable of the same name
//                        .Ld_B(LD_B),
//                        .Shift_En(Shift_EN),
//						.Adat(A),
////								.D(8'b00000001),
//                        .D(Switches),
//                        .A(Aval),
//                        .B(Bval),
//						.M(M));

//
//multiplier       values (.sub_add(1'b0),  .A(8'b00000010), .S(Switches),
//										.Aout(Aval), .x(x));
//
//	register_unit    reg_unit (
//                        .Clk(Clk),
//                        .Reset(!Switches[0]),
//                        .x(0),
//                        .Ld_XA(Switches[0]), //note these are inferred assignments, because of the existence a logic variable of the same name
//                        .Ld_B(0),
//                        .Shift_En(0),
//								.Adat(8'b00010101),
//                        .D(8'b00100010),
//                        .A(Aval),
//                        .B(Bval),
//								.M(M));
//	 
	 HexDriver        HexAL (
								//.In0(Switches[3:0]),
                        .In0(Aval[3:0]),
                        .Out0(AhexL) );
	 HexDriver        HexBL (
								//.In0(Switches[3:0]),
                        .In0(Bval[3:0]),
                        .Out0(BhexL) );
								
	 //When you extend to 8-bits, you will need more HEX drivers to view upper nibble of registers, for now set to 0
	 HexDriver        HexAU (
								//.In0(Switches[7:4]),
                        .In0(Aval[7:4]),
                        .Out0(AhexU) );	
	 HexDriver        HexBU (
								//.In0(Switches[7:4]),
                       .In0(Bval[7:4]),
                        .Out0(BhexU) );
								
	  //Input synchronizers required for asynchronous inputs (in this case, from the switches)
	  //These are array module instantiations
	  //Note: S stands for SYNCHRONIZED, H stands for active HIGH
	  //Note: We can invert the levels inside the port assignments
	  //sync button_sync[3:0] (Clk, {~Reset, LoadA, LoadB, ~Execute}, {Reset_SH, LoadA_SH, LoadB_SH, Execute_SH});
	  sync Din_sync[7:0] (Clk, Switches);
	  
endmodule
