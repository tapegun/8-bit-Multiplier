module multiplier(
	input logic shift,
	input logic sub_add,
	input logic [7:0] A,
	input logic [7:0] S,
	input logic clk,
	input logic reset,
	
	output logic [7:0] Aout,
	output logic x,
);

	// implement choosing adder or subtr
	logic x_tmp_add;
	logic x_tmp_sub;
	logic [7:0] A_tmp_add;
	logic [7:0] A_tmp_sub;

	ripple_adder		adder (.A(A), .B(S), .cin(1'b0),  .S(A_tmp_add), .cout(), .x(x_tmp_add)
	ripple_adder		subtra (.A(A'), .B(S), .cin(1'b1),  .S(A_tmp_sub), .cout(), .x(x_tmp_sub)

	always_comb
		if(sub_add) begin
			Aout = A_tmp_add;
			x = 1'b0;
		end
		if(!sub_add) begin
			Aout = A_tmp_sub;
			x = x_temp_sub;
		end
	end
endmodule