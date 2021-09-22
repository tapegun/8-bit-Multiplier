module full_adder(
	input logic A, B, Cin,
	output logic S, C
);

	assign S = A^B^Cin;						// S is the addition based on A B and Cin 
	assign C = (A&B)|(A&Cin)|(B&Cin);	// C is the next bits C in if this "overflows"

endmodule 