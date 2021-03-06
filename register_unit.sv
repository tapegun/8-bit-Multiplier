module register_unit (input  logic Clk, Reset, x, Ld_XA, Ld_B, 
                            Shift_En,
                      input  logic [7:0]  D, 
					  input  logic [7:0]  Adat,
                      output logic [7:0]  A,
                      output logic [7:0]  B,
							 output logic M);

	 logic x_;
	 logic tmp_A_to_B;
	 assign M = B[0];
	
    reg_8  reg_A (.*, .Reset(Reset), .D(Adat),.Shift_In(x_), .Load(Ld_XA),
		.Shift_Out(tmp_A_to_B), .Data_Out(A));
		
    reg_8  reg_B (.*, .Reset(0), .Shift_In(tmp_A_to_B), .Load(Ld_B), .Shift_Out(), .Data_Out(B));
	 
//	 reg1   reg_X (.Clk(Clk), .Load(Ld_XA), .Reset(Reset), .D(x), .Q(x_));
						
	  always_ff @ (posedge Clk)
		 begin
			 if (Reset) //notice, this is a sycnrhonous reset, which is recommended on the FPGA
				  x_ <= 1'b0; //() changed from 4 to 8
			 else if (Ld_XA)
				  x_ <= x;
			 else if (Shift_En)	
				  x_ <= x_;
		end	
		
		

endmodule
