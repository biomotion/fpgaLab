module lab6_3(LEDR, HEX0, HEX1, HEX2, HEX3, KEY, SW, CLOCK_50);
	input[3:0] KEY, SW;
	input CLOCK_50;
	output reg [0:0] LEDR;
	output[6:0] HEX0, HEX1, HEX2, HEX3;
	
	reg [31:0] q, react, time_set;
	reg clk_1sec;
	reg [2:0] state;
	reg [3:0] mask;
	
	initial begin
		q = 0;
		clk_1sec = 0;
		state = 0;
		LEDR[0] = 0;
		react = 0;
		mask = 4'b1111;
	end
	
	always @ (posedge CLOCK_50) begin
		if (q == 25000)begin
			q <= 0;
			clk_1sec <= ~clk_1sec;
		end
		else
			q <= q+1;
	end
	
	always @ (posedge clk_1sec) begin
		if(state == 0) begin
		//setting sec
			time_set <= SW[3:0]*1000;
			if (!KEY[0]) begin
				state <= 1;
				mask <= 4'b1111;
			end
		end else if(state == 1) begin
		//counting down
			if (time_set > 0)
				time_set <= time_set - 1;
			else begin
				LEDR[0] = 1;
				state <= 2;
				mask <= 4'b0000;
			end
		end else if(state == 2) begin
		//reacting
			react <= react + 1;
			if (!KEY[3]) begin
				state <= 3;
				LEDR[0] = 0;
			end
		end else if(state == 3) begin
		//stoped
			//reset
			if (!KEY[0]) begin
				react <= 0;
				state <= 4;
			end
		end else if(state == 4) begin
		//displaying
			if (!KEY[3]) begin
				state <= 0;
			end
		end
	end
	
	decoder(HEX0, react%10 | mask);
	decoder(HEX1, (react/10)%10 | mask);
	decoder(HEX2, (react/100)%10 | mask);
	decoder(HEX3, (react/1000)%10 | mask);
	
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
			4'b1111: seg <= 7'b1111111; // F
			default: seg <= 7'b0000000; //  
       endcase
    end
endmodule