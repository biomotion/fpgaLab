module lab3_4(HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, SW, LEDR);
	input [8:0] SW;
	output [9:0]LEDR;
	output [7:0]HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	
	wire [3:0]add, result;
	wire cout, ov, resultOut;
	
	//carryLookahead(add, cout, SW[7:4], SW[3:0], SW[8]);
	fourBitAdder(add, cout, SW[7:4], SW[3:0], SW[8]);
	//assign {cout, add} = SW[7:4] + SW[3:0] + SW[8];
	
	assign ov = result[3]&{result[2]|result[1]}|cout;
	fourBitAdder(result, resultOut, add, {1'b0, ov, ov, 1'b0}, 1'b0);
	decoder res0(HEX4, result);
	decoder res1(HEX5, cout|resultOut);
	twoDigit a(HEX2, HEX3, SW[7:4]);
	twoDigit b(HEX0, HEX1, SW[3:0]);
	assign LEDR[9] = cout&(add[3]|add[2]);
endmodule

module carryLookahead(S, Cout, A, B, Cin);
	output [3:0] S; 
	output Cout;
	input [3:0] A, B;
	input Cin;

	wire [3:0]G, P, C;

	assign P = A^B;
	assign G = A&B;

	assign C[0] = Cin;
	assign C[1] = G[0] | (P[0]&Cin);
	assign C[2] = G[1] | (P[1]&G[0]) | (P[1]&P[2]&Cin);
	assign C[3] = G[2] | (P[2]&G[1]) | (P[2]&P[1]&G[0]) | (P[2]&P[1]&P[0]&Cin);
	assign Cout = G[3] | (P[3]&G[2]) | (P[3]&P[2]&G[1]) | (P[3]&P[2]&P[1]&G[0]) | (P[3]&P[2]&P[1]&P[0]&Cin);
	
	assign S = P^C;
endmodule
//
module fourBitAdder(S, cout, A, B, cin);
output [3:0] S;
output cout;
input [3:0] A, B;
input cin;

wire [3:0] P, C;

assign C[0] = cin;
fullAdder fullAdder1(S[0], C[1], B[0], A[0], C[0]);
fullAdder fullAdder2(S[1], C[2], B[1], A[1], C[1]);
fullAdder fullAdder3(S[2], C[3], B[2], A[2], C[2]);
fullAdder fullAdder4(S[3], cout, B[3], A[3], C[3]);

endmodule 

module fullAdder(s, cout, a, b, cin);
output s, cout;
input a, b, cin;

wire p;

assign p = a^b;
assign s = cin^p;
assign cout = (p&cin)|(a&b);

endmodule 
//
module twoDigit(D0, D1, NUM);
	input [3:0] NUM;
	output [6:0]D0, D1;
	
	wire ov = NUM[3]&{NUM[2]|NUM[1]};
	
	decoder DEC0(D0, NUM);
	decoder DEC1(D1, ov);
endmodule
//
module decoder(SEG, NUM);
	input [3:0]NUM;
	output [6:0]SEG;
	
	parameter [6:0] n0 = 7'b1000000, n1 = 7'b1111001, n2 = 7'b0100100, n3 = 7'b0110000, n4 = 7'b0011001, n5 = 7'b0010010,
						 n6 = 7'b0000010, n7 = 7'b1111000, n8 = 7'b0000000, n9 = 7'b0011000;
	wire [6:0]A0, A1, A2, A3, A4, A5, A6, A7, B0, B1, B2, B3, C0, C1;
	
	assign A0 = {{7{~NUM[0]}}&n0}|{{7{NUM[0]}}&n1};
	assign A1 = {{7{~NUM[0]}}&n2}|{{7{NUM[0]}}&n3};
	assign A2 = {{7{~NUM[0]}}&n4}|{{7{NUM[0]}}&n5};
	assign A3 = {{7{~NUM[0]}}&n6}|{{7{NUM[0]}}&n7};
	assign A4 = {{7{~NUM[0]}}&n8}|{{7{NUM[0]}}&n9};
	assign A5 = {{7{~NUM[0]}}&n0}|{{7{NUM[0]}}&n1};
	assign A6 = {{7{~NUM[0]}}&n2}|{{7{NUM[0]}}&n3};
	assign A7 = {{7{~NUM[0]}}&n4}|{{7{NUM[0]}}&n5};
	
	
	assign B0 = {{7{~NUM[1]}}&A0}|{{7{NUM[1]}}&A1};
	assign B1 = {{7{~NUM[1]}}&A2}|{{7{NUM[1]}}&A3};
	assign B2 = {{7{~NUM[1]}}&A4}|{{7{NUM[1]}}&A5};
	assign B3 = {{7{~NUM[1]}}&A6}|{{7{NUM[1]}}&A7};
	
	assign C0 = {{7{~NUM[2]}}&B0}|{{7{NUM[2]}}&B1};
	assign C1 = {{7{~NUM[2]}}&B2}|{{7{NUM[2]}}&B3};
	
	assign SEG = {{7{~NUM[3]}}&C0}|{{7{NUM[3]}}&C1};

endmodule 