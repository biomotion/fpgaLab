module lab5_2(HEX0, HEX1, HEX2, HEX3, SW, KEY);
	input [2:0] SW;
	input [0:0] KEY;
	output [6:0]HEX0, HEX1, HEX2, HEX3;
	
	wire [15:0]num;
	counter_16bit(num, SW[0], KEY[0], SW[2]);
	
	decoder d0(HEX0, num[3:0]);
	decoder d1(HEX1, num[7:4]);
	decoder d2(HEX2, num[11:8]);
	decoder d3(HEX3, num[15:12]);
	
endmodule

module counter_16bit(num, enable, clk, rst);
	input clk, rst, enable;
	output reg [15:0]num;
	
	always @ (posedge clk or negedge rst) begin
		if (rst==1'b0)
			num <= 0;
		else if (enable==1'b1)
			num <= num+1;
	end
endmodule

module decoder(seg, num);
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