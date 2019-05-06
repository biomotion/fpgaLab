module lab7_2(LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, SW);
	output [8:0] LEDR;
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	input [1:0] KEY;
	input [9:0] SW;
	reg [7:0] A, B;
	wire [7:0] SUM, P;
	
	always @ (posedge KEY[1] or negedge KEY[0]) begin
		if(~KEY[0]) begin
			A <= 0;
			B <= 0;
		end
		else if(SW[8]) begin
			B <= SW[7:0];
		end else begin
			A <= SW[7:0];
		end
	end
	
	rippleAdder(P, , B^{8{SW[9]}}, 8'b00000001&{8{SW[9]}});
	
	rippleAdder(SUM, LEDR[8], A, P);
	
	assign LEDR[7:0] = SUM;
	converter(HEX0, SUM[3:0]);
	converter(HEX1, SUM[7:4]);
	converter(HEX2, B[3:0]);
	converter(HEX3, B[7:4]);
	converter(HEX4, A[3:0]);
	converter(HEX5, A[7:4]);
	
endmodule

module rippleAdder(S, cout, A, B, cin);
	output [7:0] S;
	output cout;
	input [7:0] A, B;
	input cin;

	wire [7:0] C;

	assign C[0] = cin;

	fullAdder fullAdder1(S[0], C[1], B[0], A[0], C[0]);
	fullAdder fullAdder2(S[1], C[2], B[1], A[1], C[1]);
	fullAdder fullAdder3(S[2], C[3], B[2], A[2], C[2]);
	fullAdder fullAdder4(S[3], C[4], B[3], A[3], C[3]);
	fullAdder fullAdder5(S[4], C[5], B[4], A[4], C[4]);
	fullAdder fullAdder6(S[5], C[6], B[5], A[5], C[5]);
	fullAdder fullAdder7(S[6], C[7], B[6], A[6], C[6]);
	fullAdder fullAdder8(S[7], cout, B[7], A[7], C[7]);

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