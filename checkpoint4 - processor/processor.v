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
	 
	 // fetch instruction
	 wire [31:0] nextPC32bit, PC32bit, nextPC32bit1;
	 // updatePC updater0(nextPC, PC, clock, reset);
	 assign nextPC32bit = nextPC32bit1;
	 mydffe dffe0(PC32bit, nextPC32bit, clock, 1'b1, reset);
	 wire isNotEqual1, isLessThan1, overflow1;
	 alu alu0(PC32bit, 32'b1, 5'b0, 5'b0, nextPC32bit1, isNotEqual1, isLessThan1, overflow1);
	 assign address_imem = PC32bit[11:0]; // now instruction is q_imem
	 
	 // decode instruction
	 wire [4:0] opcode, rd, rs, rt, shamt, ALUop;
	 wire [16:0] immediate;
	 decodeInstruction decoder0(opcode, rd, rs, rt, shamt, ALUop, immediate, q_imem);
	 // generate control circuit with opcode
	 wire Rwe, Rtar, ALUinB, DMwe, Rwd;
	 controlCircuit control0(Rwe, Rtar, ALUinB, DMwe, Rwd, opcode, ALUop);
	 assign ctrl_writeEnable = Rwe;
	 assign wren = DMwe;
	 
	 // ALU
	 wire [31:0] extended_immediate;
	 signExtension extender0(immediate, extended_immediate);
	 wire [31:0] data_operandA, data_operandB;
	 assign data_operandA = data_readRegA;
	 mux_32bits mux0(data_readRegB, extended_immediate, ALUinB, data_operandB);
	 wire [31:0] data_result;
	 wire isNotEqual, isLessThan, overflow;
	 alu alu1(data_operandA, data_operandB, ALUop, shamt, data_result, isNotEqual, isLessThan, overflow);
	 
	 // data memory
	 assign address_dmem = data_result[11:0];
	 assign data = data_readRegB;
	 
	 // Register file (deal with overflow)
	 wire is_addsub, is_trouble;
	 wire is_add, is_addi, is_sub;
	 wire [31:0] dataForRwd;
	 and and0(is_add,  ~ALUop[0], ~ALUop[1], ~ALUop[2], ~ALUop[3], ~ALUop[4]);     // ALU 00000
	 and and1(is_addi, opcode[0], ~opcode[1], opcode[2], ~opcode[3], ~opcode[4]); // OP  00101
	 and and2(is_sub,   ALUop[0], ~ALUop[1], ~ALUop[2], ~ALUop[3], ~ALUop[4]);      // ALU 00001
	 or or0(is_addsub, is_add, is_addi, is_sub);
	 and and3(is_trouble, overflow, is_addsub);
	 assign ctrl_writeReg = is_trouble ? 5'b11110 : rd; // write to $r30 if ovreflow
	 mux_32bits mux1(data_result, q_dmem, Rwd, dataForRwd);
	 assign data_writeReg = overflow ? (is_addi ? 32'h0002 : (is_add ? 32'h0001 : (is_sub ? 32'h0003 : dataForRwd))) : dataForRwd;
	 assign ctrl_readRegA = rs;
	 mux_5bits mux2(rt, rd, Rtar, ctrl_readRegB);

endmodule

