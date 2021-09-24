module register_unit (input  logic Clk, Reset, x, Ld_XA, Ld_B, 
                            Shift_En,
                      input  logic [7:0]  D, 
                      output logic A_out, B_out, 
                      output logic [3:0]  A,
                      output logic [3:0]  B);

	 logic x_;
	
    reg_8  reg_A (.*, .Shift_In(x_), .Load(Ld_A),
	               .Shift_Out(A_out), .Data_Out(A));
    reg_8  reg_B (.*, .Shift_In(B_In), .Load(Ld_B),
	               .Shift_Out(B_out), .Data_Out(B));
						
	  always_ff @ (posedge Clk)
		 begin
			 if (Reset) //notice, this is a sycnrhonous reset, which is recommended on the FPGA
				  x_ <= 8'h0; //() changed from 4 to 8
			 else if (Ld_XA)
				  x_ <= x;
			 else if (Shift_En)	
				  x_ <= x_
		end	
	

endmodule
