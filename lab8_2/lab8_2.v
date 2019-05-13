module lab8_2(LEDR, SW, KEY);
	input [1:0] SW;
	input [0:0] KEY;
	output [9:0] LEDR;
	wire [3:0] state;
	reg [3:0] next_state;
	
	//States reg
	d_ff a(state[0], , next_state[0], SW[0], KEY[0]);
	d_ff b(state[1], , next_state[1], SW[0], KEY[0]);
	d_ff c(state[2], , next_state[2], SW[0], KEY[0]);
	d_ff d(state[3], , next_state[3], SW[0], KEY[0]);


	//describe next state
	always @ (posedge KEY[0]) begin
		case (state)
			4'b0000:	if(~SW[1]) 	next_state <= 4'b0001; 	// A: to B
						else 			next_state <= 4'b0101; 	//	A: to F
			4'b0001:	if(~SW[1])	next_state <= 4'b0010;	// B: to C
						else			next_state <= 4'b0101;	// B: to F
			4'b0010:	if(~SW[1]) 	next_state <= 4'b0011;	// C: to D
						else			next_state <= 4'b0101;	// C: to F
			4'b0011:	if(~SW[1]) 	next_state <= 4'b0100;	// D: to E
						else			next_state <= 4'b0101;	// D: to F
			4'b0100:	if(~SW[1]) 	next_state <= 4'b0100;	// E: to E
						else			next_state <= 4'b0101;	// E: to F
			4'b0101:	if(SW[1]) 	next_state <= 4'b0110;	// F: to G
						else			next_state <= 4'b0001;	// F: to B
			4'b0110:	if(SW[1]) 	next_state <= 4'b0111;	// G: to H
						else			next_state <= 4'b0001;	// G: to B
			4'b0111:	if(SW[1]) 	next_state <= 4'b1000;	// H: to I
						else			next_state <= 4'b0001;	// H: to B
			4'b1000:	if(SW[1]) 	next_state <= 4'b1000;	// I: to I
						else			next_state <= 4'b0001;	// I: to B
			default: next_state <= 4'b0000;
		endcase
	end
	
	assign LEDR[3:0] = state[3:0];
	assign LEDR[9] = (state[3]|state[2])&~state[1]&~state[0];
	
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
