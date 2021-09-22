module control (	input Clk, Reset, Run, 
						output logic shift,
						output logic add,
						output logic sub
						);
						
		enum logic [3:0] {A, B, C, D, E, F, G, H, I, J} curr_state, next_state; // States
		// Assign 'next_state' based on 'state' and 'Execute'
		always_ff @ (posedge Clk or posedge Reset ) 
		begin
				if (Reset)
					curr_state = A; 
				else
					curr_state = next_state;
		end
		// Assign outputs based on ‘state’
		always_comb
		begin
		// Default to be self-looping 		
				next_state = curr_state; 
				
				unique case (curr_state)
						A : if (Run)
								next_state = B;
						B : next_state = C;
						C : if (~Run)
								next_state = A;
				endcase
		end
		// Assign outputs based on ‘state’
		always_comb
		begin
				case (curr_state)
						A: 
							begin
									Run_O <= 1'b0;
							end
						B: 
							begin
									Run_O <= 1'b1;
							end
						C:
							begin
									Run_O <= 1'b0;
							end
				endcase
		end
		
endmodule