module lab8_4(HEX0, SW, KEY, LEDR);
	input [2:0] SW;
	input [1:0] KEY;
	output [7:0] HEX0;
	output [9:0] LEDR;
	reg [3:0] num;
	
	always @ (posedge KEY[1]) begin
		if(~SW[0]) num <= 4'b0000;
		else begin
			case(SW[2:1])
				2'b00: num <= num;
				2'b01: 	if(num < 9)num <= num +1;
							else num <= 0;
				2'b10: 	if(num < 8) num <= num +2;
							else if(num==8) num <= 4'b0000;
							else num <= 4'b0001;
				2'b11: 	if(num>0) num <= num -1;
							else	num <= 4'b1001;
				default: num <= 4'b0000;
			endcase
		end
	end
	
	assign LEDR[2:0] = SW[2:0];
	assign LEDR[3] = KEY[1];
	
	converter(HEX0, num);
	
endmodule


module d_ff(Q, Qc, D, RST, CLK);
	input D, RST, CLK;
	output reg Q;
	output Qc;
	
	assign Qc = ~Q;
	
	initial Q <= 0;
	
	always @ (posedge CLK or negedge RST) begin
		if(~RST)
			Q <= 0;
		else
			Q <= D;
	end
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