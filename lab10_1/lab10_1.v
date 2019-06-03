module lab10_1(HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, LEDR, KEY, SW);
	input [1:0] KEY;
	input [7:0] SW;
	
	output [7:0] LEDR;
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	
	wire [7:0] R0, R1;
	
	converter r1l(HEX0, R1[3:0]);
	converter r1h(HEX1, R1[7:4]);
	converter r0l(HEX2, R0[3:0]);
	converter r0h(HEX3, R0[7:4]);
	converter dinl(HEX4, SW[3:0]);
	converter dinh(HEX5, SW[7:4]);
	
endmodule


module proc(DIN, Resetn, Clock, Run, Done, BusWires);
	input [7:0] DIN;
	input Resetn, Clock, Run;
	output Done;
	output [7:0] BusWires;
	
endmodule

module regn(R, Rin, clk, Q);
	input [7:0] R;
	output reg [7:0] Q;
	input Rin, clk;
	
	always @ (posedge clk)
		if(Rin) Q <= R;
		
endmodule

module dec3to8(W, En, Y);
	input [2:0] W;
	input En;
	output reg [7:0] Y;
	
	always @(W or En) begin
		if(En)
			case(W)
				3'b000: Y<=8'b10000000;
				3'b001: Y<=8'b01000000;
				3'b010: Y<=8'b00100000;
				3'b011: Y<=8'b00010000;
				3'b100: Y<=8'b00001000;
				3'b101: Y<=8'b00000100;
				3'b110: Y<=8'b00000010;
				3'b111: Y<=8'b00000001;
			endcase
		else Y<=8'b00000000;
	end
endmodule

module upcount(clear, clk, Q);
	input clear, clk;
	output reg [1:0] Q;
	always @(posedge clk)
		if(clear) 	Q <= 2'b00;
		else			Q <= Q + 1;
endmodule
