module multiplier(
	input logic shift,
	input logic add,
	input logic sub,
	input logic [7:0] A,
	input logic [7:0] S,
//	input logic clearA_LoadB,
//	input logic clearA,
	input logic clk,
	input logic reset,
	
	output logic [7:0] Aout,
	output logic x,
	output logic m
);

// implement choosing adder or subtr

ripple_adder		adder (.A(A), .B(S), .cin(1'b0),  .S(Aout), .cout(x))
ripple_adder		subtra (.A(A'), .B(S), .cin(1'b1),  .S(Aout), .cout(x))



