module is_not_equal(data_operandA, data_operandB, flag);

	//declare inputs and output
	input [31:0] data_operandA, data_operandB;
	output flag;
	
	//wire intermediate results
	wire [31:0] res_subtraction, equality_or;
	wire c_out_subtraction, overflow_subtraction, or1_out;
	
	//calculate results for subtraction
	subtraction subtraction0(data_operandA, data_operandB, res_subtraction, c_out_subtraction, overflow_subtraction);
	
	//check if A is equal to B
	genvar i;
	generate
		for (i = 0; i <= 31; i = i + 1) begin: sub_loop
			or or0(equality_or[i], res_subtraction[i], 0);
		end
	endgenerate
	or or1(
		or1_out,
		equality_or[0],
		equality_or[1],
		equality_or[2],
		equality_or[3],
		equality_or[4],
		equality_or[5],
		equality_or[6],
		equality_or[7],
		equality_or[8],
		equality_or[9],
		equality_or[10],
		equality_or[11],
		equality_or[12],
		equality_or[13],
		equality_or[14],
		equality_or[15],
		equality_or[16],
		equality_or[17],
		equality_or[18],
		equality_or[19],
		equality_or[20],
		equality_or[21],
		equality_or[22],
		equality_or[23],
		equality_or[24],
		equality_or[25],
		equality_or[26],
		equality_or[27],
		equality_or[28],
		equality_or[29],
		equality_or[30],
		equality_or[31]);
	assign flag = or1_out ? 1 : 0;

endmodule
