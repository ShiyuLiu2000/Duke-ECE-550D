# Checkpoint 3 - Register File

Shiyu Liu            sl846

## General Design

Basically, I use the design schema presented in the cp3 instruction pdf file. I change the four 8-bit registers to thirty two 32-bit registers to meet the requirements.

## Design Details

### 1. 5-to-32 decoder

First, I build the 2-to-4 decoder with simple `and` and `not` gates. Then I use two 2-to-4 decoder to build the 3-to-8 decoder. Finally, I use one 2-to-4 decoder and four 3-to-8 decoder to build the 5-to-32 decoder.

### 2. 32-bit D Flip-Flop with Enable (DFFE)

I change the 1-bit DFFE provided by professor to a 32-bit DFFE so that it becomes convenient for my design.

### 3. Substitution for tristate buffer

When it comes to building read ports A and B, I substitute the function of tristate buffer by using ternary operators while generating the registers at the same time.