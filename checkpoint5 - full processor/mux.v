module mux(a, b, control, out);
	 
	 //declare inputs and outputs
	 input a, b, control;
	 output out;
	 
	 //wire intermediate outputs
	 wire not_out;
	 wire and0_out, and1_out;
	 //control = 0 for a, and0_out = a
	 //control = 1 for b, and1_out = b
	 
	 //make the circuit
	 not not0(not_out, control);
	 and and0(and0_out, a, not_out);
	 and and1(and1_out, b, control);
	 or or0(out, and0_out, and1_out);

endmodule