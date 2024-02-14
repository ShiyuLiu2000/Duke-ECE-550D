module frequency_divider_by4(clk, rst, out_clk);
	
	// declare input and output
	input clk, rst;
	output reg out_clk;
	
	// use a counter, flip the clock everytime counter == 1 so that the clock is slowed down 4x
	reg counter;
	
	always @(posedge clk or posedge rst)
	begin
		if (rst)
		begin
			counter <= 1'b0;
			out_clk <= 1'b0;
		end
		else
		begin
			if (counter == 1'b1)
			begin
				out_clk <= ~out_clk;
				counter <= 1'b0;
			end
			else
				counter <= counter + 1'b1;
		end
	end

	
endmodule
