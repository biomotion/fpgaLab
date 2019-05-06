module lab7_4(HEX0, HEX1, HEX4, HEX5, SW);
	input[7:0] SW;
	output[6:0] HEX0, HEX1, HEX4, HEX5;
	wire [7:0]product;
	
	multiplier(product, SW[7:4], SW[3:0]);
	
	converter(HEX5, SW[7:4]);
	converter(HEX4, SW[3:0]);
	converter(HEX1, product[7:4]);
	converter(HEX0, product[3:0]);
	
endmodule

module multiplier(PRODUCT, A, B);
	input [3:0] A, B;
	output [7:0] PRODUCT;
	wire[3:0] S0, S1, S2, S3;
	wire[3:0] P1, P2, P3;
	wire c1, c2, c3;
	
	assign S0 = A[3:0] & {4{B[0]}};
	assign S1 = A[3:0] & {4{B[1]}};
	assign S2 = A[3:0] & {4{B[2]}};
	assign S3 = A[3:0] & {4{B[3]}};
	
	rippleAdder(P1, c1, {1'b0, S0[3:1]}, S1, 0);
	rippleAdder(P2, c2, {c1, P1[3:1]}, S2, 0);
	rippleAdder(P3, c3, {c2, P2[3:1]}, S3, 0);
	
	assign PRODUCT[0] = S0[0];
	assign PRODUCT[1] = P1[0];
	assign PRODUCT[2] = P2[0];
	assign PRODUCT[6:3] = P3;
	assign PRODUCT[7] = c3;
	
endmodule

module rippleAdder(S, cout, A, B, cin);
	output [3:0] S;
	output cout;
	input [3:0] A, B;
	input cin;

	wire [3:0] C;

	assign C[0] = cin;

	fullAdder fullAdder1(S[0], C[1], B[0], A[0], C[0]);
	fullAdder fullAdder2(S[1], C[2], B[1], A[1], C[1]);
	fullAdder fullAdder3(S[2], C[3], B[2], A[2], C[2]);
	fullAdder fullAdder8(S[3], cout, B[3], A[3], C[3]);

endmodule 

module fullAdder(s, cout, a, b, cin);
	output s, cout;
	input a, b, cin;

	wire p;

	assign p = a^b;
	assign s = cin^p;
	assign cout = (p&cin)|(a&b);

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
