module lab2_5(HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, SW);
	output[6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	input [2:0] SW;
	wire[2:0] h0, h1, h2, h3, h4, h5;
	
	mux_3bit_6to1 m0(h0, SW, 3'b011, 3'b100, 3'b000, 3'b001, 3'b010, 3'b010);
	mux_3bit_6to1 m1(h1, SW, 3'b010, 3'b011, 3'b100, 3'b000, 3'b001, 3'b010);
	mux_3bit_6to1 m2(h2, SW, 3'b010, 3'b010, 3'b011, 3'b100, 3'b000, 3'b001);
	mux_3bit_6to1 m3(h3, SW, 3'b001, 3'b010, 3'b010, 3'b011, 3'b100, 3'b000);
	mux_3bit_6to1 m4(h4, SW, 3'b000, 3'b001, 3'b010, 3'b010, 3'b011, 3'b100);
	mux_3bit_6to1 m5(h5, SW, 3'b100, 3'b000, 3'b001, 3'b010, 3'b010, 3'b011);
	
	
	decoder d0(HEX0, h0);
	decoder d1(HEX1, h1);
	decoder d2(HEX2, h2);
	decoder d3(HEX3, h3);
	decoder d4(HEX4, h4);
	decoder d5(HEX5, h5);
	
	
endmodule

module mux_3bit_6to1(OUT, S, U, V, W, X, Y, Z);
	input[2:0] S;
	input [2:0] U, V, W, X, Y, Z;
	output[2:0] OUT;
	wire [2:0] A, B, C, D, E;
	mux m1(A, U, V, S[0]);
	mux m2(B, W, X, S[0]);
	mux m3(C, A, B, S[1]);
	mux m4(D, Y, Z, S[0]);
	mux m5(E, D, Z, S[1]);
	mux m6(OUT, C, E, S[2]);
endmodule 

module mux(M, X, Y, S);
	input[2:0] X, Y;
	input S;
	output[2:0] M;
	assign M = {{3{~S}}&X}|{{3{S}}&Y};
endmodule

module decoder(display, S);
	output[6:0] display;
	input[2:0] S;
	parameter H = 7'b0001001, E = 7'b0000110, L = 7'b1000111, O = 7'b1000000, B = 7'b1111111;
	wire[6:0] X, Y, Z;
	
	assign X = {{7{~S[0]}}&H}|{{7{S[0]}}&E};
	assign Y = {{7{~S[0]}}&L}|{{7{S[0]}}&O};
	assign Z = {{7{~S[1]}}&X}|{{7{S[1]}}&Y};
	assign display = {{7{~S[2]}}&Z}|{{7{S[2]}}&B};
endmodule 