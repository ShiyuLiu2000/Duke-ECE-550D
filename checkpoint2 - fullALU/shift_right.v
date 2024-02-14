module shift_right(data, amount, res);

    //declare inputs and outputs
    input [31:0] data;
    input [4:0] amount;
    output [31:0] res;

    //assign the sign bit
    wire leftmost;
    assign leftmost = data[31];

    //wire intermediate results
    wire [31:0] shift1, shift2, shift4, shift8, shift16;

    //stage 1: shift by 0 or 1
    mux mux0(data[31], leftmost, amount[0], shift1[31]);
    genvar i1;
    generate
        for (i1 = 30; i1 >= 0; i1 = i1 - 1) begin : sub_loop0
            mux mux1(data[i1], data[i1+1], amount[0], shift1[i1]);
        end
    endgenerate

    //stage 2: shift by 0 or 2
    mux mux2(shift1[31], leftmost, amount[1], shift2[31]);
    mux mux3(shift1[30], leftmost, amount[1], shift2[30]);
    genvar i2;
    generate
        for (i2 = 29; i2 >= 0; i2 = i2 - 1) begin : sub_loop1
            mux mux4(shift1[i2], shift1[i2+2], amount[1], shift2[i2]);
        end
    endgenerate

    //stage 3: shift by 0 or 4
    genvar i3_0;
    generate
        for (i3_0 = 31; i3_0 >= 28; i3_0 = i3_0 - 1) begin : sub_loop2_0
            mux mux5(shift2[i3_0], leftmost, amount[2], shift4[i3_0]);
        end
    endgenerate
    genvar i3_1;
    generate
        for (i3_1 = 27; i3_1 >= 0; i3_1 = i3_1 - 1) begin : sub_loop2_1
            mux mux6(shift2[i3_1], shift2[i3_1+4], amount[2], shift4[i3_1]);
        end
    endgenerate

    //stage 4: shift by 0 or 8
    genvar i4_0;
    generate
        for (i4_0 = 31; i4_0 >= 24; i4_0 = i4_0 - 1) begin : sub_loop3_0
            mux mux7(shift4[i4_0], leftmost, amount[3], shift8[i4_0]);
        end
    endgenerate
    genvar i4_1;
    generate
        for (i4_1 = 23; i4_1 >= 0; i4_1 = i4_1 - 1) begin : sub_loop3_1
            mux mux8(shift4[i4_1], shift4[i4_1+8], amount[3], shift8[i4_1]);
        end
    endgenerate

    //stage 5: shift by 0 or 16
    genvar i5_0;
    generate
        for (i5_0 = 31; i5_0 >= 16; i5_0 = i5_0 - 1) begin : sub_loop4_0
            mux mux9(shift8[i5_0], leftmost, amount[4], shift16[i5_0]);
        end
    endgenerate
    genvar i5_1;
    generate
        for (i5_1 = 15; i5_1 >= 0; i5_1 = i5_1 - 1) begin : sub_loop4_1
            mux mux10(shift8[i5_1], shift8[i5_1+16], amount[4], shift16[i5_1]);
        end
    endgenerate

    assign res = shift16;

endmodule
