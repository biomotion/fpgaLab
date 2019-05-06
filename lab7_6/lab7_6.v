module lab7_6(HEX0, HEX1, HEX2, HEX3, LEDR, SW, KEY);
	input [9:0] SW;
	input [3:0] KEY;
	output [6:0] HEX0, HEX1, HEX2, HEX3;
	output [9:9] LEDR;
	reg [7:0]A, B, C, D;
	wire [15:0] S, X, Y;
	reg [7:0] out1, out0;
	reg toggle;
	
	always @ (posedge KEY[1] or negedge KEY[0]) begin
		if(~KEY[0]) begin
			A <= 0;
			B <= 0;
			C <= 0;
			D <= 0;
		end
		else if(SW[9]) begin
			if(SW[8]) begin
				if(~KEY[2])
					A <= SW[7:0];
				else
					B <= SW[7:0];
			end else begin
				if(~KEY[2])
					C <= SW[7:0];
				else
					D <= SW[7:0];
			end
		end
	end
	
	always @(posedge KEY[3]) begin
		toggle <= ~toggle;
		if(toggle) begin
			out1 <= S[15:8];
			out0 <= S[7:0];
		end else begin
			
			if(SW[8]) begin
				out1 <= A;
				out0 <= B;
			end else begin
				out1 <= C;
				out0 <= D;
			end
		end
	end
	
	multiplier(A, B, X);
	multiplier(C, D, Y);
	adder(X, Y, S, LEDR[9]);
	
	converter(HEX0, out0[3:0]);
	converter(HEX1, out0[7:4]);
	converter(HEX2, out1[3:0]);
	converter(HEX3, out1[7:4]);
	

	
endmodule

module converter(seg, num);
	 input [3:0] num;
	 output reg [6:0] seg;
    always @(num) begin
        case (num)
			4'b0000: seg <= 7'b1000000; // 0
			4'b0001: seg <= 7'b1111001; // 1
			4'b0010: seg <= 7'b0100100; // 2
			4'b0011: seg <= 7'b0110000; // 3
			4'b0100: seg <= 7'b0011001; // 4
			4'b0101: seg <= 7'b0010010; // 5
			4'b0110: seg <= 7'b0000010; // 6
			4'b0111: seg <= 7'b1111000; // 7
			4'b1000: seg <= 7'b0000000; // 8
			4'b1001: seg <= 7'b0011000; // 9
			4'b1010: seg <= 7'b0001000; // A
			4'b1011: seg <= 7'b0000000; // B
			4'b1100: seg <= 7'b1000110; // C
			4'b1101: seg <= 7'b1000000; // D
			4'b1110: seg <= 7'b0000110; // E
			4'b1111: seg <= 7'b0001110; // F
			default: seg <= 7'b0000000; //  
       endcase
    end
endmodule