module lab4_2(LEDR, SW);
	input[17:0] SW;
	output[17:0] LEDR;
	
	rs_latch rs1(LEDR[0], , ~SW[0], SW[0], SW[1]);
	
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