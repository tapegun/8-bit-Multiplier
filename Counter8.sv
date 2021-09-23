module counter8 (input reset, CLK, cntEn,
						output [2:0] Dout);
						
		always @(posedge CLK)
			if (reset)
				Dout <= 3'b000;
			else if (Dout[2] & Dout[1] & Dout[0])
				Dout <= 3'b000;
			else if (cntEn)
				Dout <= Dout + 1;
			else
				Dout <= Dout;
	
endmodule 