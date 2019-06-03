module lab10_1(HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, LEDR, KEY, SW);
	input [1:0] KEY;
	input [7:0] SW;
	
	output [7:0] LEDR;
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	
	wire [7:0] R0, R1;
	
	converter(HEX0, R1[3:0]);
	converter(HEX1, R1[7:4]);
	converter(HEX2, R0[3:0]);
	converter(HEX3, R0[7:4]);
	converter(HEX4, SW[3:0]);
	converter(HEX5, SW[7:4]);
	
endmodule


module proc(DIN, Resetn, Clock, Run, Done, BusWires);
	input [7:0] DIN;
	input Resetn, Clock, Run;
	output Done;
	output [7:0] BusWires;
	
endmodule
