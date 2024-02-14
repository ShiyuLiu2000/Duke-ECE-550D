# Checkpoint 5 - Full Processor

Shiyu Liu sl846

### Global design

Basically, we followed the design of 07-datapath PowerPoint. We note that we modified the data ports for Register File (i.e. for ctrl_readDataA, ctrl_readDataB, and ctrl_writeData) to accomodate the new way of instruction translation of pc4&5.

Moreover, to accomodate the j-type instructions that requires updating the PC register, we calculate PC+1, PC+1+N at the same time, and use tristate logic to decide if PC should be updated accordingly to PC+1 or PC+1+N or T (with 5'b0 extention).

### Explanation of modules

#### 1. decodeInstruction

This module is to divide the 32-bit instruction into corresponding parts of I-type, R-type and J-type: opcode, rt, rd, shamt, immediate, target...

####  2. jTypeControl

This module is to tell if an instruction requires j-type operations by translating opcode. The output is a series of boolean values like is_j, is_bne, is_jal...

#### 3. controlCircuit

This module is to generate signals like Rwe and ALUinB by translating the 5-bit opcode. This module was for project 4. We have not new control signals for project 5; instead we use a bunch of tristate expressions in processor.v to implement the j-type operations.

#### 4. signExtension

This module is to do a 32-bit signed extention on a 16-bit input.

#### 5. frequency_divider_by_4

This module is to slow the clock 4x.