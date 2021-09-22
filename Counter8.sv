module counter8 (input reset, CLK, cntEn,
						output [2:0] Dout);
						
		always @(posedge CLK)
			if (reset)
				Dout <= 3'b000;
			else if (cntEn)
				Dout <= Dout + 1;
	
endmodule 