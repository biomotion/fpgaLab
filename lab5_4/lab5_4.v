module lab5_4(HEX0, CLOCK_50);
	input CLOCK_50;
	output [6:0]HEX0;
	reg [3:0] num;

	reg clk_1sec;
	reg [27:0] q;
	
	
	decoder d0(HEX0, num[3:0]);
	
	always @ (posedge CLOCK_50) begin
		if (q == 70000000)begin
			q <= 0;
			clk_1sec <= ~clk_1sec;
		end
		else
			q <= q+1;
	end
	
	always @ (posedge clk_1sec) begin
		if (num == 4'b1001)
			num <= 0;
		else
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