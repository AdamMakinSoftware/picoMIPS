module multiplier ( input logic clk,
input logic signed  [7:0] a, b, 
output logic signed [7:0] out);

	logic signed [15:0] mult_out;
	
	assign mult_out = a * b;
        assign out = mult_out[7:0]; // Lowest 8 bits of product of A and B
	
endmodule

