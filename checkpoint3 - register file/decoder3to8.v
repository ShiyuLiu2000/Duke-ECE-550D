module decoder3to8(out, in, enable);
	
	// declare inputs and outputs
	input [2:0] in;
	input enable;
	output [7:0] out;
	
	// wire intermediate output
	wire not_in2;
	wire [7:0] decoder_res;
	
	// build the circuit with two 2-to-4 decoders
	not not0(not_in2, in[2]);
	decoder2to4 decoder0(decoder_res[7:4], in[1:0], in[2]);
	decoder2to4 decoder1(decoder_res[3:0], in[1:0], not_in2);
	
	// check if this decoder is enabled
	genvar i;
	generate
		for (i = 0; i < 8; i = i + 1) begin : sub_loop
			assign out[i] = enable ? decoder_res[i] : 0;
		end
	endgenerate
	
endmodule
