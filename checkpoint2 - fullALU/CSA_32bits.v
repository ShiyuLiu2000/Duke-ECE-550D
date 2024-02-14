module CSA_32bits(a, b, c_in, sum, c_out, overflow);
	
	//declare inputs and outputs
	input [31:0] a, b;
	input c_in;
	output [31:0] sum;
	output c_out, overflow;
	
	//wire intermediate results
	wire control, carry_0, carry_1;
	wire [15:0] sum_0, sum_1;
	
	//construct the 32-bit carry select adder using three 16-bit RCAs and a 16-bit 2:1 mux
	RCA_16bits RCA0(a[15:0], b[15:0], c_in, sum[15:0], control);
	RCA_16bits RCA1(a[31:16], b[31:16], 0, sum_0, carry_0);
	RCA_16bits RCA2(a[31:16], b[31:16], 1, sum_1, carry_1);
	
	mux mux0(carry_0, carry_1, control, c_out);
	mux_16bits mux1(sum_0, sum_1, control, sum[31:16]);
	
	//detect overflow
	//overflow happens when a[31] = b[31] AND sum[31] equals the other bit
	//overflow = (A . B . notS) + (notA . notB. S)
	wire and0_out, and1_out, not_a, not_b, not_sum;
	
	not not0(not_a, a[31]);
	not not1(not_b, b[31]);
	not not2(not_sum, sum[31]);
	
	and and0(and0_out, a[31], b[31], not_sum);
	and and1(and1_out, not_a, not_b, sum[31]);
	or or0(overflow, and0_out, and1_out);

endmodule
