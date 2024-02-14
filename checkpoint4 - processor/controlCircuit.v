module controlCircuit(Rwe, Rtar, ALUinB, DMwe, Rwd, opcode, ALUop);

	// declare input and outputs
    input [4:0] opcode, ALUop;
    output Rwe, Rtar, ALUinB, DMwe, Rwd;

	 // wire intermediate results
	 wire is_sw, is_alu, is_not_shift, is_lw;
	 
	 // Rwe == 0 only when sw <=> Rwe == 0 if opcode == 00111
	 and and0(is_sw, ~opcode[4], ~opcode[3], opcode[2], opcode[1], opcode[0]);
	 assign Rwe = is_sw ? 0 : 1;
	 
	 // Rtar == 1 only if the Save ward operation is used 
	 and and1(is_alu, ~opcode[0], ~opcode[1], ~opcode[2], ~opcode[3], ~opcode[4]);
	 //and and2(is_not_shift, ~ALUop[2]);
	 assign Rtar = is_sw ? 1 : 0;
	 
	 // ALUinB == 1 only when I-type <=> ALUinB == 1 if opcode != 00000
	 assign ALUinB = is_alu ? 0 : 1;
	 
	 // DMwe == 1 only when sw <=> DMwe == 1 if opcode == 00111
	 assign DMwe = is_sw ? 1 : 0;
	 
	 // Rwd == 1 only when lw <=> Rwd == 1 if opcode == 01000
	 and and3(is_lw, ~opcode[4], opcode[3], ~opcode[2], ~opcode[1], ~opcode[0]);
	 assign Rwd = is_lw ? 1 : 0;

endmodule
