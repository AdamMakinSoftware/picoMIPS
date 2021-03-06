// File Name : pc.sv
// Function : picoMIPS Program Counter
// functions: increment, absolute and relative branches
// Author: tjk
// Last rev. 24 Oct 2012
//-----------------------------------------------------
module pc #(parameter Psize = 6) // up to 64 instructions
(input logic clk, reset, PCincr,PCrelbranch,
 input logic [Psize-1:0] Branchaddr,
 output logic [Psize-1 : 0]PCout
);

//------------- code starts here---------
logic[Psize-1:0] Rbranch; // temp variable for addition operand
always_comb begin
  if (PCincr)
       Rbranch = { {(Psize-1){1'b0}}, 1'b1};
  else Rbranch =  Branchaddr + 1;
end

always_ff @ ( posedge clk or posedge reset) // async reset
  if (reset) // sync reset
     PCout <= {Psize{1'b0}};
  else if (PCincr | PCrelbranch) // increment or relative branch
     PCout <= PCout + Rbranch; // 1 adder does both
 
	 
endmodule // module pc
