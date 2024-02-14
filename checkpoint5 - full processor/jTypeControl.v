module jTypeControl(is_j, is_bne, is_jal, is_jr, is_blt, is_bex, is_setx, opcode);
	
	// declare inputs and outputs
	input [4:0] opcode;
	output is_j, is_bne, is_jal, is_jr, is_blt, is_bex, is_setx;
	
	// j T 00001, type JI
	and and0(is_j, ~opcode[4], ~opcode[3], ~opcode[2], ~opcode[1], opcode[0]);
	
	// bne $rd, $rs, N 00010, type I
	and and1(is_bne, ~opcode[4], ~opcode[3], ~opcode[2], opcode[1], ~opcode[0]);
	
	// jal T 00011, type JI
	and and2(is_jal, ~opcode[4], ~opcode[3], ~opcode[2], opcode[1], opcode[0]);
	
	// jr $rd 00100, type JII
	and and3(is_jr, ~opcode[4], ~opcode[3], opcode[2], ~opcode[1], ~opcode[0]);
	
	// blt $rd, $rs, N 00110, type I
	and and4(is_blt, ~opcode[4], ~opcode[3], opcode[2], opcode[1], ~opcode[0]);
	
	// bex T 10110, type JI
	and and5(is_bex, opcode[4], ~opcode[3], opcode[2], opcode[1], ~opcode[0]);
	
	// setx T 10101, type JI
	and and6(is_setx, opcode[4], ~opcode[3], opcode[2], ~opcode[1], opcode[0]);

endmodule
