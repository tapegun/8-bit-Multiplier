module multiplier(
	input logic sub_add,
	input logic [7:0] A,
	input logic [7:0] S,
	
	output logic [8:0] Aout,
	output logic x
);

	// implement choosing adder or subtr
//	logic x_tmp_add;
//	logic x_tmp_sub;
//	logic [7:0] A_tmp_add;
//	logic [7:0] A_tmp_sub;
//	
//	
//
//	ripple_adder		adder (.A(A), .B(S), .cin(1'b0),  .S(A_tmp_add), .cout(), .x(x_tmp_add));
//	ripple_adder		subtra (.A(~A), .B(S), .cin(1'b1),  .S(A_tmp_sub), .cout(), .x(x_tmp_sub));
//
//	always_comb
//	begin
//		if(sub_add) 
//		begin
//			Aout = A_tmp_sub;
//			x = x_tmp_sub;
//		end
//		else
//		begin
//			Aout = A_tmp_add;
//			x = 1'b0;
//		end
//	end

//module ADD_SUB9 ( input [7:0] A, B, input Fn, output [8:0] S);

logic c0,c1,c2,c3,c4,c5,c6,c7;
logic [7:0] Breal;
logic A9, BB9;
assign Breal = (S ^ {8{sub_add}});
assign A9 = A[7]; assign BB9 = Breal[7];
logic tmp;

//ripple_adder		adder (.A(A), .B(Breal), .cin(sub_add),  .S(Aout), .cout(tmp), .x(x));

full_adder FA0(.A(A[0]), .B(Breal[0]), .Cin(sub_add), .S(Aout[0]),.C(c0));
full_adder FA1(.A(A[1]), .B(Breal[1]), .Cin(c0), .S(Aout[1]), .C(c1));
full_adder FA2(.A(A[2]), .B(Breal[2]), .Cin(c1), .S(Aout[2]), .C(c2));
full_adder FA3(.A(A[3]), .B(Breal[3]), .Cin(c2), .S(Aout[3]), .C(c3));
full_adder FA4(.A(A[4]), .B(Breal[4]), .Cin(c3), .S(Aout[4]), .C(c4));
full_adder FA5(.A(A[5]), .B(Breal[5]), .Cin(c4), .S(Aout[5]), .C(c5));
full_adder FA6(.A(A[6]), .B(Breal[6]), .Cin(c5), .S(Aout[6]), .C(c6));
full_adder FA7(.A(A[7]), .B(Breal[7]), .Cin(c6), .S(Aout[7]), .C(c7));
full_adder FA8(.A(A9), .B(BB9), .Cin(c7), .S(Aout[8]), .C()); 

endmodule