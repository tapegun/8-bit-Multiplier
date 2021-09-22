module ripple_adder
(
	input logic  [15:0] A, B,
	input logic        cin,
	output logic [15:0] S,
	output logic       cout
);

    /* TODO
     *
     * Insert code here to implement a ripple adder.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
	  
	  logic c0, c1, c2;
	  
	  //(4bit_rp) inputs: A[3:0] B[3:0] cin outputs: S C
	  fourbit_rp rp1 (.A(A[3:0]), .B(B[3:0]), .cin(cin), .S(S[3:0]), .cout(C0));    //chain our 4 4bit adders together like we chained our full adders
	  fourbit_rp rp2 (.A(A[7:4]), .B(B[7:4]), .cin(c0), .S(S[7:4]), .cout(C1));
	  fourbit_rp rp3 (.A(A[11:8]), .B(B[11:8]), .cin(c1), .S(S[11:8]), .cout(C2));
	  fourbit_rp rp4 (.A(A[15:12]), .B(B[15:12]), .cin(c2), .S(S[15:12]), .cout(cout));
     
endmodule

