module lab3_2(HEX0, HEX1, SW);
	input [3:0] SW;
	output [6:0]HEX0, HEX1;
	
	wire ov = SW[3]&{SW[2]|SW[1]};
	
	decoder DEC0(HEX0, SW);
	decoder DEC1(HEX1, ov);
endmodule

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