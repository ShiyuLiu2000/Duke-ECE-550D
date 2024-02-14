module decoder2to4(out, in, enable);
	
	// declare inputs and outputs
	input [1:0] in;
	input enable;
	output [3:0] out;
	
	// wire intermediate outputs
	wire [1:0] not_in;
	wire [3:0] decoder_res;
	
	// build the circuit
	assign not_in = ~in;
	
	and and0(decoder_res[0], not_in[0], not_in[1]);
	and and1(decoder_res[1], in[0], not_in[1]);
	and and2(decoder_res[2], not_in[0], in[1]);
	and and3(decoder_res[3], in[0], in[1]);
	
	// check if this decoder is enabled
	genvar i;
	generate
		for (i = 0; i < 4; i = i + 1) begin : sub_loop
			assign out[i] = enable ? decoder_res[i] : 0;
		end
	endgenerate

endmodule
