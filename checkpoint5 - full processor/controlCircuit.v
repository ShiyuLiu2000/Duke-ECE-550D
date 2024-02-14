module controlCircuit(Rwe, Rtar, ALUinB, DMwe, Rwd, opcode, ALUop);

	/* 
		All these control signals are for project 4.
		We accomodate the new J-type commands in processor.v
	*/

	// declare input and outputs
    input [4:0] opcode, ALUop;
    output Rwe, Rtar, ALUinB, DMwe, Rwd;

	 // wire intermediate results
	 wire is_sw, is_alu, is_not_shift, is_lw, is_addi;
	 
	 // Rwe == 0 only when sw <=> Rwe == 0 if opcode == 00111
	 and and0(is_sw, ~opcode[4], ~opcode[3], opcode[2], opcode[1], opcode[0]);
	 and and4(is_addi, ~opcode[4], ~opcode[3], opcode[2], ~opcode[1], opcode[0]);
	 or or0(Rwe, is_alu, is_addi, is_lw);
	 //assign Rwe =  ? 0 : 1;
	 
	 // Rtar == 1 only when save word operation is used 
	 and and1(is_alu, ~opcode[0], ~opcode[1], ~opcode[2], ~opcode[3], ~opcode[4]);
	 //and and2(is_not_shift, ~ALUop[2]);
	 assign Rtar = is_sw ? 1 : 0;
	 
	 // ALUinB == 1 only when I-type <=> ALUinB == 1 if opcode != 00000
	 or or1(ALUinB, is_addi, is_lw, is_sw);
	 //assign ALUinB = is_alu ? 0 : 1;
	 
	 // DMwe == 1 only when sw <=> DMwe == 1 if opcode == 00111
	 assign DMwe = is_sw ? 1 : 0;
	 
	 // Rwd == 1 only when lw <=> Rwd == 1 if opcode == 01000
	 and and3(is_lw, ~opcode[4], opcode[3], ~opcode[2], ~opcode[1], ~opcode[0]);
	 assign Rwd = is_lw ? 1 : 0;

endmodule
