module bitwise_and(data_operandA, data_operandB, res);
	
	//declare inputs and output
	input [31:0] data_operandA, data_operandB;
	output [31:0] res;
	
	//generate for
	genvar i;
	generate
		for (i = 0; i <= 31; i = i + 1) begin : sub_loop
			and and0(res[i], data_operandA[i], data_operandB[i]);
		end
	endgenerate

endmodule
