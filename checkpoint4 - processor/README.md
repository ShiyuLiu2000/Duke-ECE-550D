# CP4 : Simple Processor

Shiyu Liu, sl846

## General description

In checkpoint 4, we used the provided alu and regfile, designed a datapath for R-type and I-type MIPS instructions, and implemented them in process.v and skeleton.v.

### Module description

We declare that all modules except for process.v, skeleton.v, imem.v, dmem.v, and the following 4 new modules, are modules from checkpoint 2 and 3. We used them to properly implement alu.v and regfile.v.

#### 1. frequency_divider_by4

This module slows 4x down a clock by setting a counter, and flip the clock when counter is 1.

#### 2. controlCircuit

This module takes in 5-bit opcode and ALU op, and generates control signals such as Rwe for our datapath design.

#### 3. decodeInstruction

This module takes in 32-bit instruction fetched from InsnMem, and decode it into corresponding R-type or I-type parts, such as rd, rt, and immediate.

#### 4. signExtension

This module takes in a 16-bit signed immediate and return a 32-bit signed extension of it.