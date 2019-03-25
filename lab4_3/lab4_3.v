module lab4_3(LEDR, SW);
	input[17:0] SW;
	output[17:0] LEDR;

	wire Qm;
	
	rs_latch rs1(Qm, , ~SW[0], SW[0], ~SW[1]);
	rs_latch rs2(LEDR[0], , ~Qm, Qm, SW[1]);
	
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