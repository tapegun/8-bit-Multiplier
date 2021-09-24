//module control (	input logic Clk, Reset, Run, M,
//						input logic [2:0] count,
//						output logic LD_XA, LD_B, Shift_EN, Clr_XA, SUB_ADD,
//						output logic [9:0] States
//						);
//						
//enum logic [4:0] {Limbo, Hold, Precompute, ClearALoadB, S1, S2, S3, S4, S5, S6,
// S7, S8, A1, A2, A3, A4, A5, A6, A7, Sub}  curr_state, next_state; //4 more states for 4 more counts
//
//// assign States[8] = Run;
//// assign States[9] = Reset;
// 
//	//updates flip flop, current state is the only one
//    always_ff @ (posedge Clk)  
//    begin
////        if (Reset)
////            curr_state <= ClearALoadB;
////        else 
//            curr_state <= next_state;
//    end
//
//    // Assign outputs based on state
//	always_comb
//    begin
//        
//		  //next_state  = curr_state;	//required because I haven't enumerated all possibilities below
//        unique case (curr_state) 
//				Precompute : 
//				begin
//					if (M)
//						next_state = A1;
//					else
//						next_state = S1;
//				end
//            Hold :
//				begin
//				if (Run)
//               next_state = Precompute;
//				else if (Reset)
//					next_state = ClearALoadB;
//				else 
//					next_state = Hold;
//				end
//				ClearALoadB:
//					next_state = Hold;
//            
//            S1 :
//					begin
//					if(M)
//						next_state = A2;
//					else
//						next_state = S2;
//					end
//            S2 :    
//					begin
//					if (M)
//						next_state = A3;
//					else
//						next_state = S3;
//					end
//            S3 :
//					begin
//					if (M)
//						next_state = A4;
//					else
//						next_state = S4;
//					end
//				S4 :
//					begin
//					if (M)
//						next_state = A5;
//					else
//						next_state = S5;
//					end
//				S5 :
//					begin
//					if (M)
//						next_state = A6;
//					else
//						next_state = S6;
//					end
//				S6 :    
//					begin
//					if (M)
//						next_state = A7;
//					else
//						next_state = S7;
//					end
//				S7 :    
//					begin
//					if (M)
//						next_state = Sub;
//					else
//						next_state = S8;
//					end
//				S8 :
//					next_state = Hold;
//				A1 : next_state = S1;
//				A2 : next_state = S2;
//				A3 : next_state = S3;
//				A4 : next_state = S4;
//				A5 : next_state = S5;
//				A6 : next_state = S6;
//				A7 : next_state = S7;
//				Sub: next_state = S8;
//				default: next_state = Hold;
//							  
//        endcase
//
//		  // Assign outputs based on ‘state’
//        case (curr_state) 
//	   	   Hold:
//				begin
//				LD_XA = 0;
//				LD_B = 0;
//				Shift_EN = 0;
//
//				Clr_XA = 0;
//				SUB_ADD = 0;
//				States = {Reset, Run, 8'b00000001};
//				end
//				ClearALoadB:
//				begin
//				LD_XA = 0;
//				LD_B = 1;
//				Shift_EN = 0;
//				Clr_XA = 1;
//				SUB_ADD = 0;
//				States = {Reset, Run, 8'b00000010};
//				end
//				Precompute:
//				begin
//				LD_XA = 0;
//				LD_B = 0;
//				Shift_EN = 0;
//				Clr_XA = 1;
//				SUB_ADD = 0;
//				States = {Reset, Run, 8'b00000100};
//				end
//				S1, S2, S3, S4, S5, S6, S7, S8:
//				begin
//				LD_XA = 0;
//				LD_B = 0;
//				Shift_EN = 1;
//				Clr_XA = 0;
//				SUB_ADD = 0;
//				States = {Reset, Run, 8'b00001000};
//				end
//				A1, A2, A3, A4, A5, A6, A7:
//				begin
//				LD_XA = 1;
//				LD_B = 0;
//				Shift_EN = 0;
//				Clr_XA = 0;
//				SUB_ADD = 0;
//				States = {Reset, Run, 8'b00010000};
//				end
//				Sub:
//				begin
//				LD_XA = 1;
//				LD_B = 0;
//				Shift_EN = 0;
//				Clr_XA = 0;
//				SUB_ADD = 1;
//				States = {Reset, Run, 8'b10000000};
//				end
//				default:
//				begin
//				LD_XA = 0;
//				LD_B = 0;
//				Shift_EN = 0;
//				Clr_XA = 0;
//				SUB_ADD = 1;
//				States = {Reset, Run, 8'b11111111};
//				end
//				
//        endcase
//    end
//
//						
//endmodule 
module Control (input  Clk, Reset, ClearA_LoadB, Run, M,
                output logic Shift_En, LD_B, LD_XA, Fn, Reset_c);
					
enum logic [4:0] {Idle, R, Load, Start, Done, A, B, C, D, E, F, G, H, A2, B2, C2, D2, E2, F2, G2, H2} curr_state, next_state;

always_ff @ (posedge Clk or posedge Reset)  
    begin
        if (Reset)
            curr_state = R;
        else 
            curr_state = next_state;
    end
	 
always_comb
begin
	next_state = curr_state;
	
	unique case (curr_state)
		R:			next_state = Idle;
		Load: 	next_state = Idle;
		Idle: 	if(Run)
						next_state = Start;
					else if(ClearA_LoadB)
						next_state = Load;
						
		Start: 	next_state = A2;
			A2:	next_state = A;
			A : 	next_state = B2;
			B2:	next_state = B;
			B :   next_state = C2;
			C2:	next_state = C;
			C :   next_state = D2;
			D2:	next_state = D;
			D :   next_state = E2;
			E2:	next_state = E;
			E :   next_state = F2;
			F2:	next_state = F;
			F :   next_state = G2;
			G2:	next_state = G;
			G :   next_state = H2;
			H2:	next_state = H;
			H : 	next_state = Done;
		Done :	if(~Run) next_state = Idle;
	endcase

end

always_comb
begin 
	case (curr_state)
		R:
			begin
				Reset_c <= 1'b1;
				Shift_En <= 1'b0;
				LD_B <= 1'b0;
				LD_XA <= 1'b0;
				Fn <= 1'b0;
			end
		Load:
			begin
				Reset_c <= 1'b0;
				Shift_En <= 1'b0;
				LD_B <= 1'b1;
				LD_XA <= 1'b0;
				Fn <= 1'b0;
			end
		
		A2, B2, C2, D2, E2, F2, G2:
			begin
				Reset_c <= 1'b0;
				Shift_En <= 1'b0;
				LD_B <= 1'b0;
				Fn <= 1'b0;
				
				if(M)
					LD_XA <= 1'b1;
				else
					LD_XA <= 1'b0;
			end
		
		H2:
			begin
				Reset_c <= 1'b0;
				Shift_En <= 1'b0;
				LD_B <= 1'b0;
				Fn <= 1'b1;
				
				if(M)
					LD_XA <= 1'b1;
				else
					LD_XA <= 1'b0;
			end
			
		A, B, C, D, E, F, G, H:
			begin
				Reset_c <= 1'b0;
				Shift_En <= 1'b1;
				LD_B <= 1'b0;
				Fn <= 1'b0;
				LD_XA <= 1'b0;
			end
			
		Idle, Start:
			begin
				Reset_c <= 1'b0;
				Shift_En <= 1'b0;
				LD_B <= 1'b0;
				LD_XA <= 1'b0;
				Fn <= 1'b0;
			end
		Done:
			begin
				Reset_c <= 1'b0;
				Shift_En <= 1'b0;
				LD_B <= 1'b0;
				LD_XA <= 1'b0;
				Fn <= 1'b0;
			end
			
		default:
			begin
				Reset_c <= 1'b0;
				Shift_En <= 1'b0;
				LD_B <= 1'b0;
				LD_XA <= 1'b0;
				Fn <= 1'b0;
			end
	endcase
end
endmodule	