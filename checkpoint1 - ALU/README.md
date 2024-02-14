# Project Checkpoint1 - Simple ALU

Shiyu Liu, sl846

## Description

First, I built a 32-bit Carry Select Adder with three 16-bit Ripple Carry Adders and a 16-bit 2:1 mux. 

Then, I implemented addition and subtraction separately using the 32-bit Carry Select Adder. Specifically, for the subtraction, I turned $A - B$ into $A + B' + 1$.

Finally, for the ALU design, I made the circuit calculate the results (*overflow* and *data_result*) for both addition and subtraction at the same time, then use mux to select from the results according to *ctrl_ALUopcode*. 

