module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);

   input [31:0] data_operandA, data_operandB;
   input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

   output [31:0] data_result;
   output isNotEqual, isLessThan, overflow;

   // YOUR CODE HERE //
	
	//wire intermediate results
	wire [31:0] res_addition, res_subtraction;
	wire c_out_addition, c_out_subtraction, overflow_addition, overflow_subtraction;
	wire [31:0] bit_or, bit_and;
	wire [31:0] res_shiftLeft, res_shiftRight;
	
	//calculate results for addition
	addition addition0(data_operandA, data_operandB, res_addition, c_out_addition, overflow_addition);
	
	//calculate results for subtraction
	subtraction subtraction0(data_operandA, data_operandB, res_subtraction, c_out_subtraction, overflow_subtraction);
	
	//calculate overflow
	mux mux0(overflow_addition, overflow_subtraction, ctrl_ALUopcode[0], overflow);
	
	//calculate isLessThan (check if A is strictly less than B)
	is_less_than less0(data_operandA, data_operandB, isLessThan);
	
	//calculate isNotEqual (check if A is equal to B)
	is_not_equal not_equal0(data_operandA, data_operandB, isNotEqual);
	
	//bitwise or, bitwise and
	bitwise_or bit0(data_operandA, data_operandB, bit_or);
	bitwise_and bit1(data_operandA, data_operandB, bit_and);
	
	//logical left shift on A
	shift_left left0(data_operandA, ctrl_shiftamt, res_shiftLeft);
	
	//arithmetic right shift on A
	shift_right right0(data_operandA, ctrl_shiftamt, res_shiftRight);
	
	//use (cond)?res1:res2 to determine the final output of ALU with opcode
	assign data_result = ctrl_ALUopcode[2] ? (ctrl_ALUopcode[0] ? res_shiftRight : res_shiftLeft) : (ctrl_ALUopcode[1] ? (ctrl_ALUopcode[0] ? bit_or : bit_and) : (ctrl_ALUopcode? res_subtraction : res_addition));

endmodule
