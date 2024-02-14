module mux_5bits(a, b, control, out);
	
	// declare inputs and outputs
	input [4:0] a, b;
	input control;
	output [4:0] out;
	
	// connect the circuit, 16 mux with the same comtrol signal
	// 0 for a, 1 for b
	mux mux0(a[0], b[0], control, out[0]);
	mux mux1(a[1], b[1], control, out[1]);
	mux mux2(a[2], b[2], control, out[2]);
	mux mux3(a[3], b[3], control, out[3]);
	mux mux4(a[4], b[4], control, out[4]);

endmodule
