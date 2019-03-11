module lab2_3(HEX0, SW);
	input[2:0] SW;
	output[6:0] HEX0;
	parameter H = 7'b0001001, E = 7'b0000110, L = 7'b1000111, O = 7'b1000000, B = 7'b1111111;
	wire[6:0] X, Y, Z;
	
	assign X = {{7{~SW[0]}}&H}|{{7{SW[0]}}&E};
	assign Y = {{7{~SW[0]}}&L}|{{7{SW[0]}}&O};
	assign Z = {{7{~SW[1]}}&X}|{{7{SW[1]}}&Y};
	assign HEX0 = {{7{~SW[2]}}&Z}|{{7{SW[2]}}&B};
endmodule