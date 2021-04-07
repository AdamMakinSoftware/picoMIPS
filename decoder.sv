//---------------------------------------------------------
// File Name   : decoder.sv
// Function    : picoMIPS instruction decoder 
// Author: tjk
// ver 2:  // NOP, ADD, ADDI, and branches
// Last revised: 26 Oct 2012
//---------------------------------------------------------

`include "alucodes.sv"

//---------------------------------------------------------
module decoder
( input logic [5:0] opcode, // top 6 bits of instruction
input [3:0] flags, // ALU flags
// output signals
//    PC control
output logic PCincr,PCabsbranch,PCrelbranch,
//    ALU control
output logic [2:0] ALUfunc, 
// imm mux control
output logic imm,
//   register file control
output logic w
  );
   
//------------- code starts here ---------
// instruction decoder
logic takeBranch; // temp variable to control conditional branching
always_comb 
begin
  // set default output signal values for NOP instruction
   PCincr = 1'b1; // PC increments by default
   PCabsbranch = 1'b0; PCrelbranch = 1'b0;
   ALUfunc = opcode[2:0]; 
   imm=1'b0; w=1'b0; 
   takeBranch =  1'b0; 
   case(opcode[5:3])        //Top 3 bits of opcode determine whether r,i,branch or nop instruction.
    
      3'b000 : begin // register-register
	        w = 1'b1; // write result to dest register
	      end
      3'b001 : begin // register-immediate
	        w = 1'b1; // write result to dest register
		  imm = 1'b1; // set ctrl signal for imm operand MUX
	      end
      3'b010:; //nop instructions	 	  
    
      3'b011: begin // BEQ instruction. ALU just sees this as a subtraction instruction.
		takeBranch = flags[1];
		
	      end
      3'b100: begin  //BNE instruction 
		takeBranch = ~flags[1];
	      end

	
	default:
	    $error("unimplemented opcode %h",opcode);
 
  endcase // opcode
  
   if(takeBranch) // branch condition is true;
   begin
      PCincr = 1'b0;
	  PCrelbranch = 1'b1; 
   end


end // always_comb


endmodule //module decoder --------------------------------