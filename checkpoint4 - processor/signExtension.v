module signExtension(immediate, extended_immediate);

	// declare inputs and outputs
	input [16:0] immediate;
	output [31:0] extended_immediate;
	
	// perform sign extension
	assign extended_immediate[31:17] = immediate[16] ? 15'h7fff : 15'h0000;
	assign extended_immediate[16:0] = immediate;

endmodule
