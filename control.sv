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
						if (!Run & Reset)
							next_state = ClearA_LdB;
						else if (Run & !Reset)
							next_state = Precompute;
						
						ClearA_LdB:
							next_state = Hold;
						
						Precompute:
							if (M)
								next_state = FirstAdd;
							else if (!M)
								next_state = FirstShift;
						
						FirstAdd:
							next_state = FirstShift;
						
						FirstShift:
							next_state = Shift;
						
						Add:
							next_state = Shift;
						
						Shift:
							if (M & count[2] & count[1] & count[0])
								next_state = Sub;
							else if (!count[2] & !count[1] & !count[0])
								next_state = Hold;
							else if (M)
								next_state = Add;
							else if (!M)
								next_state = Shift;
						
						Sub:
							next_state = Shift;
				
				endcase
		end
		// Assign outputs based on ‘state’
		always_comb
		begin
				case (curr_state)
						
						Hold:
						begin
						LD_XA = 0
						LD_B = 0
						Shift_EN = 0
						Cnt_EN = 0
						Clr_XA = 0
						SUB_ADD = 0
						
						end
						
						ClearA_LdB:
						begin
						LD_XA = 0
						LD_B = 1
						Shift_EN = 0
						Cnt_EN = 0
						Clr_XA = 1
						SUB_ADD = 0
						end
						
						Precompute:
						begin
						LD_XA = 0
						LD_B = 0
						Shift_EN = 0
						Cnt_EN = 0
						Clr_XA = 1
						SUB_ADD = 0
						end
						
						FirstAdd:
						begin
						LD_XA = 1
						LD_B = 0
						Shift_EN = 0
						Cnt_EN = 0
						Clr_XA = 0
						SUB_ADD = 0
						end
						
						FirstShift:
						begin
						LD_XA = 1
						LD_B = 0
						Shift_EN = 1
						Cnt_EN = 1
						Clr_XA = 0
						SUB_ADD = 0
						end
						
						Add:
						begin
						LD_XA = 1
						LD_B = 0
						Shift_EN = 0
						Cnt_EN = 0
						Clr_XA = 0
						SUB_ADD = 0
						end
						
						Shift:
						begin
						LD_XA = 0
						LD_B = 0
						Shift_EN = 1
						Cnt_EN = 1
						Clr_XA = 0
						SUB_ADD = 0
						end
						
						Sub:
						begin
						LD_XA = 1
						LD_B = 0
						Shift_EN = 0
						Cnt_EN = 0
						Clr_XA = 0
						SUB_ADD = 1
						end
						
						
						default:
							begin
								
							end
				endcase
		end
		
endmodule 