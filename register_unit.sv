module register_unit (input  logic Clk, Reset, x, Ld_XA, Ld_B, 
                            Shift_En,
                      input  logic [7:0]  D,  
                      output logic [7:0]  A,
                      output logic [7:0]  B
							 output logic M);

	 logic x_;
	 logic tmp_A_to_B;
	 assign M = B[0];
	
    reg_8  reg_A (.*, 				.Shift_In(x_), 		  .Load(Ld_XA), .Shift_Out(tmp_A_to_B), .Data_Out(A));
    reg_8  reg_B (.*, .Reset(0), .Shift_In(tmp_A_to_B), .Load(Ld_B),  .Data_Out(B));
						
	  always_ff @ (posedge Clk)
		 begin
			 if (Reset) //notice, this is a sycnrhonous reset, which is recommended on the FPGA
				  x_ <= 1'b0; //() changed from 4 to 8
			 else if (Ld_XA)
				  x_ <= x;
			 else if (Shift_En)	
				  x_ <= x_
		end	
		
		

endmodule
