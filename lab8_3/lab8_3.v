module lab8_3(LEDR, SW, KEY);
	input [1:0] SW;
	input [0:0] KEY;
	output [9:0] LEDR;
	wire [7:0] state;
	
	//States reg
	d_ff a(state[0], , 1, SW[0]&~SW[1], KEY[0]);
	d_ff b(state[1], , state[0], SW[0]&~SW[1], KEY[0]);
	d_ff c(state[2], , state[1], SW[0]&~SW[1], KEY[0]);
	d_ff d(state[3], , state[2], SW[0]&~SW[1], KEY[0]);
	d_ff e(state[4], , 1, SW[0]&SW[1], KEY[0]);
	d_ff f(state[5], , state[4], SW[0]&SW[1], KEY[0]);
	d_ff g(state[6], , state[5], SW[0]&SW[1], KEY[0]);
	d_ff h(state[7], , state[6], SW[0]&SW[1], KEY[0]);

	
	assign LEDR[7:0] = state[7:0];
	assign LEDR[9] = (state[0]&state[1]&state[2]&state[3])|(state[4]&state[5]&state[6]&state[7]);
	
endmodule

module d_ff(Q, Qc, D, RST, CLK);
	input D, RST, CLK;
	output reg Q;
	output Qc;
	
	assign Qc = ~Q;
	
	initial Q <= 0;
	
	always @ (posedge CLK) begin
		if(~RST)
			Q <= 0;
		else
			Q <= D;
	end
endmodule
