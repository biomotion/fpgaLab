module lab7_6(LEDR, HEX0, HEX1, HEX2, HEX3, KEY, SW);
	input[3:0] KEY;
	input[9:0] SW;
	output[6:0] HEX0, HEX1, HEX2, HEX3;
	output[9:0] LEDR;
	
	reg [7:0] A, B, C, D;
	wire [15:0] X, Y, S, OUT;
	reg displayResult, displayAC_BD;
	wire [7:0] AC, BD;
	
	initial begin
		A <= 0;
		B <= 0;
		C <= 0;
		D <= 0;
	end
	
	always @ (posedge KEY[1]) begin
		if(SW[9]) begin
			if(~SW[8]) begin
				if(KEY[2])
					A <= SW[7:0];
				else
					B <= SW[7:0];
			end else begin
				if(KEY[2])
					C <= SW[7:0];
				else
					D <= SW[7:0];
			end
		end
	end
	
	always @ (posedge KEY[3]) begin
		displayResult <= ~displayResult;
	end
	
	assign LEDR[7:0] = SW[7:0];
	multiplexer(A, B, X);
	multiplexer(C, D, Y);
	adder(X, Y, LEDR[9], S);
	
	mux_8bit(A, C, SW[8], AC);
	mux_8bit(B, D, SW[8], BD);
	mux_16bit({AC, BD}, S, displayResult, OUT);
	
	converter(HEX0, OUT[3:0]);
	converter(HEX1, OUT[7:4]);
	converter(HEX2, OUT[11:8]);
	converter(HEX3, OUT[15:12]);
	
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