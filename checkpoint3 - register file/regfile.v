module regfile (
    clock,
    ctrl_writeEnable,
    ctrl_reset, ctrl_writeReg,
    ctrl_readRegA, ctrl_readRegB, data_writeReg,
    data_readRegA, data_readRegB
);

   input clock, ctrl_writeEnable, ctrl_reset;
   input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
   input [31:0] data_writeReg;

   output [31:0] data_readRegA, data_readRegB;

   /* YOUR CODE HERE */
	
	// wire intermediate outputs
	wire [31:0] decoder_write, decoder_read_A, decoder_read_B;
	wire [31:0] and_temp;
	
	// build write port circuit
	decoder5to32 decoder0(decoder_write, ctrl_writeReg);
	and and0(and_temp[0], ctrl_writeEnable, 1'b0); // register 0 must always read as 32'b0
	
	genvar i0;
	generate
		for (i0 = 1; i0 < 32; i0 = i0 + 1) begin : sub_loop0
			and and1(and_temp[i0], ctrl_writeEnable, decoder_write[i0]);
		end
	endgenerate
	
	// build register circuit and read ports
	decoder5to32 decoder1(decoder_read_A, ctrl_readRegA);
	decoder5to32 decoder2(decoder_read_B, ctrl_readRegB);
	
	genvar i1;
	generate
		for (i1 = 0; i1 < 32; i1 = i1 + 1) begin : sub_loop1 // start from 1 because of unsolvable bug if starts from 0 :(
			wire [31:0] q_temp;
			mydffe dffe0(q_temp, data_writeReg, clock, and_temp[i1], ctrl_reset);
			assign data_readRegA = decoder_read_A[i1] ? q_temp : 32'bz;
			assign data_readRegB = decoder_read_B[i1] ? q_temp : 32'bz;
		end
	endgenerate
	
	assign data_readRegA = decoder_read_A[0] ? 32'b0 : 32'bz;
	assign data_readRegB = decoder_read_B[0] ? 32'b0 : 32'bz;
	
endmodule
