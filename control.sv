module control (	input Clk, Reset, Run, M,
						input [2:0] count,
						output logic shift_en, Ld_A, //same as adding 
						output logic Ld_x, ClearAX_LoadB, Sub, CntEn
						);
						
		enum logic [3:0] {ResetState, Add, Shift, SubState,Hold} curr_state, next_state; // States
		// Assign 'next_state' based on 'state' and 'Execute'
		always_ff @ (posedge Clk) 
		begin
				if (Reset)
					curr_state <= ResetState; 
				else
					curr_state <= next_state;
		end
		// Assign outputs based on ‘state’
		always_comb
		begin
		// Default to be self-looping 		
				next_state = curr_state; 
				
				unique case (curr_state)
						ResetState : if (Run & M)
									next_state = Add;
									else if (Reset)
										next_state = Hold;
								  else 
									next_state = Shift;
									
						Add : next_state = Shift;
						
						Shift: if (count[2] & count[1] & !count[0] & M)
									next_state = SubState;
								else if (count[2] & count[1] & !count[0])
									next_state = Shift;
								else if (count[2] & count[1] & count[0])
									next_state = ResetState;
								else 
									next_state = Shift;
									
						SubState: next_state = Shift;
						
						Hold: next_state = ResetState;
				
				endcase
		end
		// Assign outputs based on ‘state’
		always_comb
		begin
				case (curr_state)
						ResetState: 
							begin
								Ld_A = 1'b0;
								ClearAX_LoadB = 1'b0;
								Shift_En = 1'b0;
								Sub = 1'b0;
								CntEn = 1'b0;
							end
						Add:
							begin
								Ld_A = 1'b1;
								ClearAX_LoadB = 1'b0;
								Shift_En = 1'b0;
								Sub = 1'b0;
								CntEn = 1'b0;
							end
						Shift:
							begin
								Ld_A = 1'b0;
								ClearAX_LoadB = 1'b0;
								Shift_En = 1'b1;
								Sub = 1'b0;
								CntEn = 1'b1;
							end
						SubState:
							begin
								Ld_A = 1'b0;
								ClearAX_LoadB = 1'b0;
								Shift_En = 1'b0;
								Sub = 1'b1;
								CntEn = 1'b0;
							end
						Hold:
							begin
								Ld_A = 1'b0;
								ClearAX_LoadB = 1'b1;
								Shift_En = 1'b0;
								Sub = 1'b0;
								CntEn = 1'b0;
							end
						default:
							begin
								
							end
				endcase
		end
		
endmodule