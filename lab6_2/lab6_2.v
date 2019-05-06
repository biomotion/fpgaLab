module lab6_2(HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, SW, CLOCK_50);
	input[9:0] SW;
	input CLOCK_50;
	output [7:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	reg clk_1sec;
	reg [31:0] q;
	reg [7:0] sec, min, hr;

	
	initial begin
		q = 0;
		clk_1sec = 0;
		sec = 0;
		min = 0;
		hr = 0;
	end
	
	//generate 1 sec clock
	always @ (posedge CLOCK_50) begin
		if (q == 70000000)begin
			q <= 0;
			clk_1sec <= ~clk_1sec;
		end
		else
			q <= q+1;
	end
	
	//count the numbers
	always @ (posedge clk_1sec) begin
		if (!SW[9]) begin
			if (sec < 59)
				sec <= sec + 1;
			else begin
				sec <= 0;
				if(min < 59)
					min <= min + 1;
				else begin
					min <= 0;
					if(hr < 23)
						hr <= hr + 1;
					else
						hr <= 0;
				end
			end
		end else begin
		//setting time
			if (SW[8] == 1'b0)
				if(SW[7:0] > 59)
					min <= 59;
				else
					min <= SW[7:0];
			else
				if(SW[7:0] > 23)
					hr <= 23;
				else
					hr <= SW[7:0];
		end
	end

	
	two_digit(HEX0, HEX1, sec);
	two_digit(HEX2, HEX3, min);
	two_digit(HEX4, HEX5, hr);
	
endmodule

module two_digit(seg0, seg1, num);
	input [7:0] num;
	output [6:0] seg0, seg1;
	
	decoder(seg0, num%10);
	decoder(seg1, num/10);
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