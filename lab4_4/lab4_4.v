module lab4_4(Qa, Qb, Qc, D, Clk);
	input D, Clk;
	output Qa, Qb, Qc;
	
	D_latch d1(Qa, D, Clk);
	D_flipflop d2(Qb, D, Clk);
	D_flipflop d3(Qc, D, ~Clk);
	
endmodule

module D_flipflop(Q, D, Clk);
	input D, Clk;
	output reg Q;
	
	always @(posedge Clk)
		if(Clk)
			Q = D;
	
endmodule

module D_latch(Q, D, Clk);
	input D, Clk;
	output Q;
	
	rs_latch rs1(Q, , ~D, D, Clk);
	
endmodule

module rs_latch(Qa, Qb, R, S, Clk);
	input R, S, Clk;
	output Qa, Qb;
	
	wire S_g, R_g;
	
	assign S_g = ~{S&Clk};
	assign R_g = ~{R&Clk};
	
	assign Qa = ~{Qb&S_g};
	assign Qb = ~{Qa&R_g};
	
endmodule