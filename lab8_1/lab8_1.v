module lab8_1(LEDR, SW, KEY);
	input [1:0] SW;
	input [0:0] KEY;
	output [9:0] LEDR;
	wire [8:0] state, next_state;
	
	//States reg
	d_ff a(state[0], , next_state[0], SW[0], KEY[0]);
	d_ff b(state[1], , next_state[1], SW[0], KEY[0]);
	d_ff c(state[2], , next_state[2], SW[0], KEY[0]);
	d_ff d(state[3], , next_state[3], SW[0], KEY[0]);
	d_ff e(state[4], , next_state[4], SW[0], KEY[0]);
	d_ff f(state[5], , next_state[5], SW[0], KEY[0]);
	d_ff g(state[6], , next_state[6], SW[0], KEY[0]);
	d_ff h(state[7], , next_state[7], SW[0], KEY[0]);
	d_ff i(state[8], , next_state[8], SW[0], KEY[0]);

	//describe next state
	assign next_state[0] = ~(state[0]|state[1]|state[2]|state[3]|state[4]|state[5]|state[6]|state[7]|state[8]);
	assign next_state[1] = ~SW[1]&(state[0]|state[5]|state[6]|state[7]|state[8]);
	assign next_state[2] = ~SW[1]&state[1];
	assign next_state[3] = ~SW[1]&state[2];
	assign next_state[4] = ~SW[1]&(state[3]|state[4]);
	assign next_state[5] = SW[1]&(state[0]|state[1]|state[2]|state[3]|state[4]);
	assign next_state[6] = SW[1]&(state[5]);
	assign next_state[7] = SW[1]&(state[6]);
	assign next_state[8] = SW[1]&(state[7]|state[8]);
	
	assign LEDR[8:0] = state[8:0];
	assign LEDR[9] = state[8] | state[4];
	
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
