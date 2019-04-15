module lab5_1(LEDR, HEX0, HEX1, HEX2, HEX3, SW, KEY);
	input[2:0] SW; //SW1:RST, SW0:ENABLE
	input [0:0]KEY;
	output [7:0]HEX0, HEX1, HEX2, HEX3;
	output [16:0]LEDR;
	wire[15:0] T;
	
	//
	assign LEDR[16] = KEY[0];
	
	assign T[0] = SW[0];
	assign T[1] = T[0] & LEDR[0];
	assign T[2] = T[1] & LEDR[1];
	assign T[3] = T[2] & LEDR[2];
	assign T[4] = T[3] & LEDR[3];
	assign T[5] = T[4] & LEDR[4];
	assign T[6] = T[5] & LEDR[5];
	assign T[7] = T[6] & LEDR[6];
	assign T[8] = T[7] & LEDR[7];
	assign T[9] = T[8] & LEDR[8];
	assign T[10] = T[9] & LEDR[9];
	assign T[11] = T[10] & LEDR[10];
	assign T[12] = T[11] & LEDR[11];
	assign T[13] = T[12] & LEDR[12];
	assign T[14] = T[13] & LEDR[13];
	assign T[15] = T[14] & LEDR[14];
	
	T_flipflop T0(LEDR[0] , , T[0], KEY[0], SW[2]);
	T_flipflop T1(LEDR[1] , , T[1], KEY[0], SW[2]);
	T_flipflop T2(LEDR[2] , , T[2], KEY[0], SW[2]);
	T_flipflop T3(LEDR[3] , , T[3], KEY[0], SW[2]);
	T_flipflop T4(LEDR[4] , , T[4], KEY[0], SW[2]);
	T_flipflop T5(LEDR[5] , , T[5], KEY[0], SW[2]);
	T_flipflop T6(LEDR[6] , , T[6], KEY[0], SW[2]);
	T_flipflop T7(LEDR[7] , , T[7], KEY[0], SW[2]);
	T_flipflop T8(LEDR[8] , , T[8], KEY[0], SW[2]);
	T_flipflop T9(LEDR[9] , , T[9], KEY[0], SW[2]);
	T_flipflop T10(LEDR[10] , , T[10], KEY[0], SW[2]);
	T_flipflop T11(LEDR[11] , , T[11], KEY[0], SW[2]);
	T_flipflop T12(LEDR[12] , , T[12], KEY[0], SW[2]);
	T_flipflop T13(LEDR[13] , , T[13], KEY[0], SW[2]);
	T_flipflop T14(LEDR[14] , , T[14], KEY[0], SW[2]);
	T_flipflop T15(LEDR[15] , , T[15], KEY[0], SW[2]);
	
	decoder d0(HEX0, LEDR[3:0]);
	decoder d1(HEX1, LEDR[7:4]);
	decoder d2(HEX2, LEDR[11:8]);
	decoder d3(HEX3, LEDR[15:12]);
endmodule

module T_flipflop(Q, Qc, T, CLK, RST);
	input T, CLK, RST;
	output Q, Qc;
	
	wire D;
	D_flipflop D0(Q, Qc, D, CLK, RST);
	
	assign D = {Q&~T}|{Qc&T};
	
endmodule

module D_flipflop(Q, Qc, D, CLK, RST);
	input D, CLK, RST;
	output reg Q;
	output Qc;
	
	always @(posedge CLK) begin
		if(RST == 1'b0)
			Q <= 1'b0;
		else
			Q <= D;
	end

	assign Qc = ~Q;

endmodule

//
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