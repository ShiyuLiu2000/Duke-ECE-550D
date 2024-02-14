module addition(a, b, sum, c_out, overflow);
	
	//declare inputs and outputs
	input [31:0] a, b;
	output [31:0] sum;
	output c_out, overflow;
	
	CSA_32bits CSA0(a, b, 0, sum, c_out, overflow);

endmodule
