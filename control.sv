module control (	input Clk, Reset, Run, M,
						input [2:0] count,
						output logic LD_XA, LD_B, Shift_EN, Cnt_EN, Clr_XA, SUB_ADD,
						output logic [7:0] States
						);
						
enum logic [4:0] {A, B, C, D, E, F, G, H, I, J, K, L, M2, N, O, P, Q, R, S, T}  curr_state, next_state; //4 more states for 4 more counts

	//updates flip flop, current state is the only one
    always_ff @ (posedge Clk)  
    begin
        if (Reset)
            curr_state <= A;
        else 
            curr_state <= next_state;
    end

    // Assign outputs based on state
	always_comb
    begin
        
		  next_state  = curr_state;	//required because I haven't enumerated all possibilities below
        unique case (curr_state) 

            A :
				begin
				if (Run)
                       next_state = B;
				end
            B :    next_state = C;
            C :    next_state = D;
            D :    next_state = E;
            E :    next_state = F;
				F :    next_state = G;
				G :    next_state = H;
				H :    next_state = I;
				I :    
				begin
				next_state = I;
				end
//            J :    
//				K	:
//				L	:
//				M2	:
//				N	:
//				O	:
//				P	:
//				Q	:
//				R	:
//				S	:
//				T	:
							  
        endcase
   
		  // Assign outputs based on ‘state’
        case (curr_state) 
	   	   A: 
				begin
				LD_XA = 1'b0;
				LD_B = 1'b0;
				Shift_EN = 1'b0;
				Cnt_EN = 1'b0;
				Clr_XA = 1'b0;
				SUB_ADD = 1'b0;
				States = 8'b00000001;
						
	         
		      end
				B:
				begin
				LD_XA = 1'b0;
				LD_B = 1'b0;
				Shift_EN = 1'b0;
				Cnt_EN = 1'b0;
				Clr_XA = 1'b0;
				SUB_ADD = 1'b0;
				States = 8'b01111110;
				end
				C:
				begin
				LD_XA = 1'b0;
				LD_B = 1'b0;
				Shift_EN = 1'b0;
				Cnt_EN = 1'b0;
				Clr_XA = 1'b0;
				SUB_ADD = 1'b0;
				States = 8'b01111110;
				end
				D:
				begin
				LD_XA = 1'b0;
				LD_B = 1'b0;
				Shift_EN = 1'b0;
				Cnt_EN = 1'b0;
				Clr_XA = 1'b0;
				SUB_ADD = 1'b0;
				States = 8'b01111110;
				end
				E:
				begin
				LD_XA = 1'b0;
				LD_B = 1'b0;
				Shift_EN = 1'b0;
				Cnt_EN = 1'b0;
				Clr_XA = 1'b0;
				SUB_ADD = 1'b0;
				States = 8'b01111110;
				end
				F:
				begin
				LD_XA = 1'b0;
				LD_B = 1'b0;
				Shift_EN = 1'b0;
				Cnt_EN = 1'b0;
				Clr_XA = 1'b0;
				SUB_ADD = 1'b0;
				States = 8'b01111110;
				end
				G:
				begin
				LD_XA = 1'b0;
				LD_B = 1'b0;
				Shift_EN = 1'b0;
				Cnt_EN = 1'b0;
				Clr_XA = 1'b0;
				SUB_ADD = 1'b0;
				States = 8'b01111110;
				end
				H:
				begin
				LD_XA = 1'b0;
				LD_B = 1'b0;
				Shift_EN = 1'b0;
				Cnt_EN = 1'b0;
				Clr_XA = 1'b0;
				SUB_ADD = 1'b0;
				States = 8'b01111110;
				end
				I:
				begin
				LD_XA = 1'b0;
				LD_B = 1'b0;
				Shift_EN = 1'b0;
				Cnt_EN = 1'b0;
				Clr_XA = 1'b0;
				SUB_ADD = 1'b0;
				States = 8'b10000000;
				end
				//J :    
//				K	:
//				L	:
//				M2	:
//				N	:
//				O	:
//				P	:
//				Q	:
//				R	:
//				S	:
//				T	:
				default:
				begin
				LD_XA = 1'b0;
				LD_B = 1'b0;
				Shift_EN = 1'b0;
				Cnt_EN = 1'b0;
				Clr_XA = 1'b0;
				SUB_ADD = 1'b0;
				States = 8'b00000000;
				end
        endcase
    end

						
endmodule 