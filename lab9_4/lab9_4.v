module lab9_4(LEDR, HEX0, HEX2, HEX3, CLOCK_50, KEY, SW);
	input [9:0] SW;
	input CLOCK_50;
	input [0:0] KEY;
	output [0:0] LEDR;
	output [6:0] HEX0, HEX2, HEX3;
	
	reg clk_1sec;
	reg [31:0] q;
	reg [4:0] address;
	wire [3:0]out;
	
	initial begin
		clk_1sec = 0;
		q = 0;
		address = 0;
	end
	
	always @ (posedge CLOCK_50) begin
		if (q == 5000000)begin
			q <= 0;
			clk_1sec <= ~clk_1sec;
		end
		else
			q <= q+1;

			
			
	end
	
	always @(posedge clk_1sec) begin

		if (address < 31)
			address <= address+1;
		else
			address <= 0;

			
	end
	
	ram(CLOCK_50, SW[8:5], address, SW[4:0], SW[9], out);
	
	converter(HEX0, out);
	converter(HEX2, address[3:0]);
	converter(HEX3, address[4]);
	
	assign LEDR[0] = SW[9];
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