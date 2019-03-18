module lab2_6(HEX0, SW);
	input [3:0]SW;
	output [6:0]HEX0;
	
	parameter [6:0] n0 = 7'b1000000, n1 = 7'b1111001, n2 = 7'b0100100, n3 = 7'b0110000, n4 = 7'b0011001, n5 = 7'b0010010,
						 n6 = 7'b0000010, n7 = 7'b1111000, n8 = 7'b0000000, n9 = 7'b0011000;
	wire [6:0]A0, A1, A2, A3, A4, B0, B1, C0;
	
	assign A0 = {{7{~SW[0]}}&n0}|{{7{SW[0]}}&n1};
	assign A1 = {{7{~SW[0]}}&n2}|{{7{SW[0]}}&n3};
	assign A2 = {{7{~SW[0]}}&n4}|{{7{SW[0]}}&n5};
	assign A3 = {{7{~SW[0]}}&n6}|{{7{SW[0]}}&n7};
	assign A4 = {{7{~SW[0]}}&n8}|{{7{SW[0]}}&n9};
	
	assign B0 = {{7{~SW[1]}}&A0}|{{7{SW[1]}}&A1};
	assign B1 = {{7{~SW[1]}}&A2}|{{7{SW[1]}}&A3};
	
	assign C0 = {{7{~SW[2]}}&B0}|{{7{SW[2]}}&B1};
	
	assign HEX0 = {{7{~SW[3]}}&C0}|{{7{SW[3]}}&A4};

endmodule 