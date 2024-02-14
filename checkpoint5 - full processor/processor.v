/**
 * READ THIS DESCRIPTION!
 *
 * The processor takes in several inputs from a skeleton file.
 *
 * Inputs
 * clock: this is the clock for your processor at 50 MHz
 * reset: we should be able to assert a reset to start your pc from 0 (sync or
 * async is fine)
 *
 * Imem: input data from imem
 * Dmem: input data from dmem
 * Regfile: input data from regfile
 *
 * Outputs
 * Imem: output control signals to interface with imem
 * Dmem: output control signals and data to interface with dmem
 * Regfile: output control signals and data to interface with regfile
 *
 * Notes
 *
 * Ultimately, your processor will be tested by subsituting a master skeleton, imem, dmem, so the
 * testbench can see which controls signal you active when. Therefore, there needs to be a way to
 * "inject" imem, dmem, and regfile interfaces from some external controller module. The skeleton
 * file acts as a small wrapper around your processor for this purpose.
 *
 * You will need to figure out how to instantiate two memory elements, called
 * "syncram," in Quartus: one for imem and one for dmem. Each should take in a
 * 12-bit address and allow for storing a 32-bit value at each address. Each
 * should have a single clock.
 *
 * Each memory element should have a corresponding .mif file that initializes
 * the memory element to certain value on start up. These should be named
 * imem.mif and dmem.mif respectively.
 *
 * Importantly, these .mif files should be placed at the top level, i.e. there
 * should be an imem.mif and a dmem.mif at the same level as process.v. You
 * should figure out how to point your generated imem.v and dmem.v files at
 * these MIF files.
 *
 * imem
 * Inputs:  12-bit address, 1-bit clock enable, and a clock
 * Outputs: 32-bit instruction
 *
 * dmem
 * Inputs:  12-bit address, 1-bit clock, 32-bit data, 1-bit write enable
 * Outputs: 32-bit data at the given address
 *
 */
module processor(
    // Control signals
    clock,                          // I: The master clock
    reset,                          // I: A reset signal

    // Imem
    address_imem,                   // O: The address of the data to get from imem
    q_imem,                         // I: The data from imem

    // Dmem
    address_dmem,                   // O: The address of the data to get or put from/to dmem
    data,                           // O: The data to write to dmem
    wren,                           // O: Write enable for dmem
    q_dmem,                         // I: The data from dmem

    // Regfile
    ctrl_writeEnable,               // O: Write enable for regfile
    ctrl_writeReg,                  // O: Register to write to in regfile
    ctrl_readRegA,                  // O: Register to read from port A of regfile
    ctrl_readRegB,                  // O: Register to read from port B of regfile
    data_writeReg,                  // O: Data to write to for regfile
    data_readRegA,                  // I: Data from port A of regfile
    data_readRegB                   // I: Data from port B of regfile
);
    // Control signals
    input clock, reset; // used

    // Imem
    output [11:0] address_imem; // done
    input [31:0] q_imem; // used

    // Dmem
    output [11:0] address_dmem; // done
    output [31:0] data; // done
    output wren; // done
    input [31:0] q_dmem; // used

    // Regfile
    output ctrl_writeEnable; // done
    output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB; // done
    output [31:0] data_writeReg; // done
    input [31:0] data_readRegA, data_readRegB; // used

    /* YOUR CODE STARTS HERE */
	 wire [31:0] PC, PC_plus_1;
	 wire isNotEqual1, isLessThan1, overflow1; // not for use
	 wire [31:0] PC_plus_1_N;
	 wire isNotEqual2, isLessThan2, overflow2; // not for use
	 wire [31:0] PC_to_T;
	 wire is_PC_to_T, is_PC_plus_1_N;
	 wire bex_effective, bne_effective, blt_effective;
	 wire [31:0] next_PC;
	 wire [4:0] opcode, rd, rs, rt, shamt, ALUop;
	 wire [16:0] immediate;
	 wire [26:0] target;
	 wire [21:0] zeroes;
	 wire Rwe0, Rtar, ALUinB, DMwe, Rwd;
	 wire is_j, is_bne, is_jal, is_jr, is_blt, is_bex, is_setx;
	 wire Rwe;
	 wire [31:0] extended_immediate;
	 wire [31:0] data_operandA, data_operandB;
	 wire [31:0] data_result;
	 wire isNotEqual, isLessThan, overflow;
	 wire is_addsub, is_trouble;
	 wire is_add, is_addi, is_sub;
	 wire [31:0] dataForRwd;
	 wire [31:0] final_data_writeReg;
	 wire [4:0] temp_ctrl_readRegB; // this is result for project 4
	 
	 /* fetch instruction */
	 // For project 5: add update options for PC
	 // compute PC + 1
	 alu alu0(PC, 32'b1, 5'b0, 5'b0, PC_plus_1, isNotEqual1, isLessThan1, overflow1);
	 // compute PC + 1 + N
	 alu alu1(PC_plus_1, extended_immediate, 5'b0, 5'b0, PC_plus_1_N, isNotEqual2, isLessThan2, overflow2);
	 // third possibility for PC: T
	 assign PC_to_T[31:27] = 5'b0;
	 assign PC_to_T[26:0] = target;
	 
	 // PC = T <=> (instruction is j or jal) or (instruction is bex and $rstatus != 0)
	 and and4(bex_effective, isNotEqual, is_bex);
	 or or2(is_PC_to_T, is_j, is_jal, bex_effective);
	 // PC = 1 + N <=> (instruction is bne and $rd != $rs) or (instruction is blt and $rd < $rs)
	 and and5(bne_effective, is_bne, isNotEqual);
	 and and6(blt_effective, is_blt, isLessThan);
	 or or3(is_PC_plus_1_N, bne_effective, blt_effective);
	 // determine next PC
	 assign next_PC = is_jr ? data_readRegA : (is_PC_to_T ? PC_to_T : (is_PC_plus_1_N ? PC_plus_1_N : PC_plus_1));
	 mydffe dffe0(PC, next_PC, clock, 1'b1, reset);
	 assign address_imem = PC[11:0]; // now instruction is q_imem
	 
	 /* decode instruction */
	 decodeInstruction decoder0(opcode, rd, rs, rt, shamt, ALUop, immediate, target, zeroes, q_imem);
	 
	 /* generate control circuit with opcode */
	 controlCircuit control0(Rwe0, Rtar, ALUinB, DMwe, Rwd, opcode, ALUop);
	 assign wren = DMwe;
	 // For project 5: add j-type instructions, accomodate
	 jTypeControl j0(is_j, is_bne, is_jal, is_jr, is_blt, is_bex, is_setx, opcode);
	 or or0(Rwe, Rwe0, is_jal, is_setx);
	 assign ctrl_writeEnable = Rwe;
	 
	 /* ALU */
	 signExtension extender0(immediate, extended_immediate);
	 assign data_operandA = data_readRegA;
	 mux_32bits mux0(data_readRegB, extended_immediate, ALUinB, data_operandB);
	 alu alu10(data_operandA, data_operandB, ALUop, shamt, data_result, isNotEqual, isLessThan, overflow);
	 
	 /* data memory */
	 assign address_dmem = data_result[11:0];
	 assign data = data_readRegB;
	 
	 /* Register */
	 // deal with overflow
	 and and0(is_add,  ~ALUop[0], ~ALUop[1], ~ALUop[2], ~ALUop[3], ~ALUop[4]);     // ALU 00000
	 and and1(is_addi, opcode[0], ~opcode[1], opcode[2], ~opcode[3], ~opcode[4]); // OP  00101
	 and and2(is_sub,   ALUop[0], ~ALUop[1], ~ALUop[2], ~ALUop[3], ~ALUop[4]);      // ALU 00001
	 or or1(is_addsub, is_add, is_addi, is_sub);
	 and and3(is_trouble, overflow, is_addsub);
	 
	 // write to $r30 if ovreflow or is_setx; write to $r31 if is_jal
	 assign ctrl_writeReg = is_trouble ? 5'b11110 : (is_setx ? 5'b11110 : (is_jal ? 5'b11111 : rd));
	 // assign ports of register file
	 mux_32bits mux1(data_result, q_dmem, Rwd, dataForRwd);
	 // For project 5: add new options for data_writeReg
	 assign final_data_writeReg = is_setx ? PC_to_T : (is_jal ? PC_plus_1 : dataForRwd);
	 assign data_writeReg = overflow ? (is_addi ? 32'h0002 : (is_add ? 32'h0001 : (is_sub ? 32'h0003 : final_data_writeReg))) : final_data_writeReg;
	 assign ctrl_readRegA = is_bne ? rd : (is_blt ? rd : (is_bex ? 5'b11110 : (is_jr ? rd : rs)));
	 mux_5bits mux2(rt, rd, Rtar, temp_ctrl_readRegB);
	 assign ctrl_readRegB = is_bne ? rs : (is_blt ? rs : (is_bex ? 5'b0 : temp_ctrl_readRegB));

endmodule

