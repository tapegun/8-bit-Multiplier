module multiplier(
	input logic shift,
	input logic sub_add,
	input logic [7:0] A,
	input logic [7:0] S,
	input logic clk,
	input logic Ld_XA,
	input logic Ld_B,
	input logic Clr_XA,
	input logic reset,
	
	output logic [7:0] Aout,
	output logic x,
	output logic m
);

// implement choosing adder or subtr

ripple_adder		adder (.A(A), .B(S), .cin(1'b0),  .S(Aout), .cout(x))
ripple_adder		subtra (.A(A'), .B(S), .cin(1'b1),  .S(Aout), .cout(x))

always_ff @ (posedge clk)
	begin
		
		if(reset) begin
			Areset <= 1'b1;
			Breset <= 1'b1;
			Aloaden <= 1'b0;
			Bloaden <= 1'b0;
			Ashiften <= 1'b0;
			Bshiften <= 1'b0;
			
			x <= 1'b0;
		end
		
		else if (clearA) begin
			Areset <= 1'b0;
			Breset <= 1'b0;
			Aloaden <= 1'b1;
			Bloaden <= 1'b0;
			Ashiften <= 1'b0;
			Bshiften <= 1'b0;
			
			ALoadData <= 8'h00;
			
			x <= 1'b0;

		end
		
		else if (clearA_LoadB) begin
			Areset <= 1'b1;
			
			Breset <= 1'b0;
			Bshiften <= 1'b0;
			Bloaden <= 1'b1;
			BLoadData <= S;
			
			x = S[7];
			
		end
		
		else if (shift) begin
			Areset <= 1'b0;
			Breset <= 1'b0;
			
			Ashiften <= 1'b1;
			Bshiften <= 1'b1;
			
			Aloaden <= 1'b0;
			Bloaden <= 1'b0;
			
		end
		
		else if (add) begin
			Areset <= 1'b0;
			Breset <= 1'b0;
			Ashiften <= 1'b0;
			Bshiften <= 1'b0;

			Aloaden <= 1'b1;
			Bloaden <= 1'b0;
			
			ALoadData = AplusS;
			x = S[7];
		end
		
		else if (sub) begin
			Areset <= 1'b0;
			Breset <= 1'b0;
			Ashiften <= 1'b0;
			Bshiften <= 1'b0;

			Aloaden <= 1'b1;
			Bloaden <= 1'b0;

			ALoadData = AminusS;
			x = ~S[7];
		end
		
		else begin
			Areset <= 1'b0;
			Breset <= 1'b0;
			Ashiften <= 1'b0;
			Bshiften <= 1'b0;
			Aloaden <= 1'b0;
			Bloaden <= 1'b0;
		end
		
	end

