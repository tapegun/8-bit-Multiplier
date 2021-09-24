module control (	input Clk, Reset, Run, M,
						input [2:0] count,
						output logic LD_XA, LD_B, Shift_EN, Cnt_EN, Clr_XA, SUB_ADD
						);
						
		enum logic [3:0] {Hold, ClearA_LdB, Precompute, FirstAdd, FirstShift,
		Add, Shift, Sub} curr_state, next_state; // States
		// Assign 'next_state' based on 'state' and 'Execute'
		always_ff @ (posedge Clk) 
		begin
				if (Reset)
					curr_state <= ClearA_LdB; 
				else
					curr_state <= next_state;
		end
		// Assign outputs based on ‘state’
		always_comb
		begin
		// Default to be self-looping 		
				next_state = curr_state; 
				
				unique case (curr_state)
				
						Hold:
						begin
						if (Reset)
							next_state = ClearA_LdB;
						else if (Run)
							next_state = Precompute;
						
						ClearA_LdB:
							next_state = Hold;
						end
						Precompute:
						begin
							if (M)
								next_state = FirstAdd;
							else
								next_state = FirstShift;
						end
						FirstAdd:
						begin
							next_state = FirstShift;
						end
						FirstShift:
						begin
							if (M)
								next_state = Add;
							else
								next_state = Shift;
						end
						Add:
						begin
							next_state = Shift;
						end
						Shift:
						begin
							if (M & count[2] & count[1] & count[0])
								next_state = Sub;
							else if (~count[2] & ~count[1] & ~count[0])
								next_state = Hold;
							else if (M)
								next_state = Add;
							else if (~M)
								next_state = Shift;
						end
						Sub:
						begin
							next_state = Shift;
						end
				endcase

		// Assign outputs based on ‘state’

				case (curr_state)
						
						Hold:
						begin
						LD_XA = 0;
						LD_B = 0;
						Shift_EN = 0;
						Cnt_EN = 0;
						Clr_XA = 0;
						SUB_ADD = 0;
						
						end
						
						ClearA_LdB:
						begin
						LD_XA = 0;
						LD_B = 1;
						Shift_EN = 0;
						Cnt_EN = 0;
						Clr_XA = 1;
						SUB_ADD = 0;
						end
						
						Precompute:
						begin
						LD_XA = 0;
						LD_B = 0;
						Shift_EN = 0;
						Cnt_EN = 0;
						Clr_XA = 1;
						SUB_ADD = 0;
						end
						
						FirstAdd:
						begin
						LD_XA = 1;
						LD_B = 0;
						Shift_EN = 0;
						Cnt_EN = 0;
						Clr_XA = 0;
						SUB_ADD = 0;
						end
						
						FirstShift:
						begin
						LD_XA = 0;
						LD_B = 0;
						Shift_EN = 1;
						Cnt_EN = 1;
						Clr_XA = 0;
						SUB_ADD = 0;
						end
						
						Add:
						begin
						LD_XA = 1;
						LD_B = 0;
						Shift_EN = 0;
						Cnt_EN = 0;
						Clr_XA = 0;
						SUB_ADD = 0;
						end
						
						Shift:
						begin
						LD_XA = 0;
						LD_B = 0;
						Shift_EN = 1;
						Cnt_EN = 1;
						Clr_XA = 0;
						SUB_ADD = 0;
						end
						
						Sub:
						begin
						LD_XA = 1;
						LD_B = 0;
						Shift_EN = 0;
						Cnt_EN = 0;
						Clr_XA = 0;
						SUB_ADD = 1;
						end
						
						
						default:
							begin
							LD_XA = 0;
						LD_B = 0;
						Shift_EN = 0;
						Cnt_EN = 0;
						Clr_XA = 0;
						SUB_ADD = 0;
							end
				endcase
		end
		
endmodule 