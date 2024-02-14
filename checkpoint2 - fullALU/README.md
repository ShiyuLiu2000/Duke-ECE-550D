# Checkpoint 2 - Full ALU

Shiyu Liu, sl846

## 1. less than

To check whether `data_operandA` is strictly less than `data_operandB`, I do $A - B$ first, then use an AND gate with 1 to check if the most significant bit of the subtraction result is 1. If it is 1, then `isLessThan` is **True**. Else, it's **False**.

## 2. not equal

To check whether `data_operandA` is equal to `data_operandB`, I do $A - B$ first, then connect each bit of the subtraction result to an OR gate with 0, and finally I connect all the 32 bit results of OR gates to another OR gate. If the final bit output of the final OR gate is 0, then `isNotEqual` is **False**. Else, it's **True**.

## 3. bitwise or

I connect each bit of `data_operandA` and `data_operand` correspondingly to an OR gate, and use the result bits to build a new binary number for answer.

## 4. bitwise and

I connect each bit of `data_operandA` and `data_operand` correspondingly to an AND gate, and use the result bits to build a new binary number for answer.

## 5. logical left shift

For the logical left shift, I accumulate the 5 shift stage using a series of multiplexers. I use 0 to fill in the shifted blanks. Specifically,

- For stage 1, I performed the shift by 0 or 1
- For stage 2, I used the output from stage 1, and performed the shift by 0 or 2
- For stage 3, I used the output from stage 2, and performed the shift by 0 or 4
- For stage 4, I used the output from stage 3, and performed the shift by 0 or 8
- For stage 5, I used the output from stage 4, and performed the shift by 0 or 16

## 6. arithmetic right shift

For the arithmetic right shift, similar to the logical left shift, I accumulate the 5 shift stage using a series of multiplexers. I use the leftmost (the most significant) bit to fill in the shifted blanks. The stages are the same as those in logical left shift.