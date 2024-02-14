module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);

   input [31:0] data_operandA, data_operandB;
   input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

   output [31:0] data_result;
   output isNotEqual, isLessThan, overflow;

   // YOUR CODE HERE //
	
	//wire intermediate results
	wire [31:0] res_addition, res_subtraction;
	wire c_out_addition, c_out_subtraction, overflow_addition, overflow_subtraction;
	
	//calculate results for addition
	addition addition0(data_operandA, data_operandB, res_addition, c_out_addition, overflow_addition);
	
	//calculate results for subtraction
	subtraction subtraction0(data_operandA, data_operandB, res_subtraction, c_out_subtraction, overflow_subtraction);
	
	//use mux to select according to the lease significant bit of ALUopcode
	mux mux0(overflow_addition, overflow_subtraction, ctrl_ALUopcode[0], overflow);
	mux_32bits mux1(res_addition, res_subtraction, ctrl_ALUopcode[0], data_result);

endmodule
