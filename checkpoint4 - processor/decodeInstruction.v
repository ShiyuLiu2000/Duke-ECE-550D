module decodeInstruction(opcode, rd, rs, rt, shamt, ALUop, immediate, instruction);
	
	// declare input and outputs
	input [31:0] instruction;
	output [4:0] opcode, rd, rs, rt, shamt, ALUop;
	output [16:0] immediate;
	
	wire is_typeR;
	and and0(is_typeR, ~opcode[0], ~opcode[1], ~opcode[2], ~opcode[3], ~opcode[4]);
	
	// divide the instruction into corresponding parts
	assign opcode = instruction[31:27];
	assign rd = instruction[26:22];
	assign rs = instruction[21:17];
	assign rt = instruction[16:12];
	assign shamt = instruction[11:7];
	assign ALUop = is_typeR ? instruction[6:2] : 5'b00000;
	assign immediate = instruction[16:0];

endmodule
