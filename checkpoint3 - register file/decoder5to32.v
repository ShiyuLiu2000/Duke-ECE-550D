module decoder5to32(out, in);

	// declare inputs and outputs
	input [4:0] in;
	output [31:0] out;
	
	// wire intermediate results
	wire [3:0] enable;
	
	// build the circuit using one 2-to-4 decoder and four 3-to-8 decoder
	decoder2to4 decoder0(enable, in[4:3], 1'b1);
	decoder3to8 decoder1(out[7:0], in[2:0], enable[0]);
	decoder3to8 decoder2(out[15:8], in[2:0], enable[1]);
	decoder3to8 decoder3(out[23:16], in[2:0], enable[2]);
	decoder3to8 decoder4(out[31:24], in[2:0], enable[3]);
	
endmodule
