module lab9_5(LEDR, HEX2, HEX3, HEX0, CLOCK_50, KEY, SW);
	input CLOCK_50;
	input [0:0] KEY;
	input [9:0] SW;
	output [0:0] LEDR;
	output [6:0] HEX0, HEX2, HEX3;
	
	reg [31:0] q;
	reg [4:0] address;
	wire [3:0]out;
	
	always @ (posedge CLOCK_50 or negedge KEY[0]) begin
		if(!KEY[0]) begin
			q <= 0;
		end else begin
			if (q == 25000000)begin
				q <= 0;
				// all process here
					address <= address+1;
			end else
				q <= q+1;
			
		end
	end
	
	converter(HEX0, out);
	converter(HEX2, address[3:0]);
	converter(HEX3, address[4]);
	
	ram2port(CLOCK_50, SW[8:5], address, SW[4:0], SW[9], out);
	
	assign LEDR[0] = SW[9];
	
endmodule

module ram2port(clock, data, rdaddress, wraddress, wren, q);
	input	  clock;
	input	[3:0]  data;
	input	[4:0]  rdaddress;
	input	[4:0]  wraddress;
	input	  wren;
	output	[3:0]  q;
	reg [4:0]addr;
	
	always @(wren) begin
		case(wren)
			1'b0: addr <= rdaddress;
			1'b1:	addr <= wraddress;
		endcase
	end
	
	ram(addr, clock, data, wren, q);
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