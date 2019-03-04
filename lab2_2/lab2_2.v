module lab2_2(LEDR, SW);
	input[2:0] SW;
	output[2:0] LEDR;
	wire [2:0] A, B, C;
	mux m1(A, 'b000, 'b001, SW[0]);
	mux m2(B, 'b010, 'b011, SW[0]);
	mux m3(C, A, B, SW[1]);
	mux m4(LEDR[2:0], C, 'b100, SW[2]);
endmodule 

module mux(M, X, Y, S);
	input[2:0] X, Y;
	input S;
	output[2:0] M;
	assign M = {{3{~S}}&X}|{{3{S}}&Y};
endmodule 