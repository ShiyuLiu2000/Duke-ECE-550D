module is_less_than(data_operandA, data_operandB, flag);
	
	//declare inputs and outputs
	input [31:0] data_operandA, data_operandB;
	output flag;
	
	//wire intermediate results
	wire [31:0] res_subtraction;
	wire c_out_subtraction, overflow_subtraction, and0_out;
	
	//calculate results for subtraction
	subtraction subtraction0(data_operandA, data_operandB, res_subtraction, c_out_subtraction, overflow_subtraction);
	
	//check if A is strictly less than B
	and and0(and0_out, res_subtraction[31], 1);
	assign flag = and0_out ? 1 : 0;

endmodule
