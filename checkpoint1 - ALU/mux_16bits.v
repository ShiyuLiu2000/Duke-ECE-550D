module mux_16bits(a, b, control, out);
	
	//declare inputs and outputs
	input [15:0] a, b;
	input control;
	output [15:0] out;
	
	//connect the circuit, 16 mux with the same comtrol signal
	//0 for a, 1 for b
	mux mux0(a[0], b[0], control, out[0]);
	mux mux1(a[1], b[1], control, out[1]);
	mux mux2(a[2], b[2], control, out[2]);
	mux mux3(a[3], b[3], control, out[3]);
	mux mux4(a[4], b[4], control, out[4]);
	mux mux5(a[5], b[5], control, out[5]);
	mux mux6(a[6], b[6], control, out[6]);
	mux mux7(a[7], b[7], control, out[7]);
	mux mux8(a[8], b[8], control, out[8]);
	mux mux9(a[9], b[9], control, out[9]);
	mux mux10(a[10], b[10], control, out[10]);
	mux mux11(a[11], b[11], control, out[11]);
	mux mux12(a[12], b[12], control, out[12]);
	mux mux13(a[13], b[13], control, out[13]);
	mux mux14(a[14], b[14], control, out[14]);
	mux mux15(a[15], b[15], control, out[15]);

endmodule
