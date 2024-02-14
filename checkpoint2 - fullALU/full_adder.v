module full_adder(a, b, c_in, sum, c_out);
	
	// declare inputs and outputs
	input a, b, c_in;
	output sum, c_out;
	
	// wire intermediate gates
	wire xor_out, and0_out, and1_out;
	
	// xor gates
	xor xor0(xor_out, a, b);
	xor xor1(sum, xor_out, c_in);
	
	// and gates
	and and0(and0_out, xor_out, c_in);
	and and1(and1_out, a, b);
	or or0(c_out, and0_out, and1_out);
	
endmodule
