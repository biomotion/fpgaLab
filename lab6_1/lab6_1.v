module lab6_1(HEX0, HEX1, HEX2, KEY, CLOCK_50, LEDR);
	input[0:0] KEY;
	input CLOCK_50;
	output [7:0] HEX0, HEX1, HEX2;
	output [0:0] LEDR;
	reg clk_1sec;
	reg [31:0] q;
	reg [3:0] dig0, dig1, dig2;
	
	assign LEDR[0] = KEY[0];
	
	initial begin
		q = 0;
		clk_1sec = 0;
		dig0 = 0;
		dig1 = 0;
		dig2 = 0;
	end
	
	//generate 1 sec clock
	always @ (posedge CLOCK_50) begin
		if (q == 25000000)begin
			q <= 0;
			clk_1sec <= ~clk_1sec;
		end
		else
			q <= q+1;
			
	end
	
	//setup the BCD numbers
	always @ (posedge clk_1sec) begin
		if (dig0 < 9)
			dig0 <= dig0+1;
		else begin
			dig0 <= 0;
			if (dig1 < 9)
				dig1 <= dig1+1;
			else begin
				dig1 <= 0;
				if (dig2 < 9)
					dig2 <= dig2+1;
				else
					dig2 <= 0;
			end
		end
		if (KEY[0] == 1'b0) begin
			dig0 <= 0;
			dig1 <= 0;
			dig2 <= 0;
		end
	end
	
	decoder(HEX0, dig0);
	decoder(HEX1, dig1);
	decoder(HEX2, dig2);
	
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