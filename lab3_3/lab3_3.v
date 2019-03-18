module lab3_3(LEDR, SW);
	output [4:0] LEDR; 
	input [9:0] SW;

	wire [3:0]G, P, C;

	assign P = SW[3:0]^SW[7:4];
	assign G = SW[3:0]&SW[7:4];

	assign C[0] = SW[9];
	assign C[1] = G[0] | (P[0]&SW[9]);
	assign C[2] = G[1] | (P[1]&G[0]) | (P[1]&P[2]&SW[9]);
	assign C[3] = G[2] | (P[2]&G[1]) | (P[2]&P[1]&G[0]) | (P[2]&P[1]&P[0]&SW[9]);
	assign LEDR[4] = G[3] | (P[3]&G[2]) | (P[3]&P[2]&G[1]) | (P[3]&P[2]&P[1]&G[0]) | (P[3]&P[2]&P[1]&P[0]&SW[9]);
	
	assign LEDR[3:0] = P^C;
endmodule 