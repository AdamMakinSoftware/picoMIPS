//---------------------------------------------------------
// File Name   : decodertest.sv
// Function    : testbench for picoMIPS instruction decoder 
// Author: tjk
// ver 1:  // only NOP, ADD, ADDI
// Last revised: 26 Oct 2012
//---------------------------------------------------------

`include "alucodes.sv"

//---------------------------------------------------------
module cpu #( parameter n = 8, Isize = 24, Psize = 6) // data bus width
(input logic clk, 
   input logic [n+1:0] SW, 
  output logic [n-1:0] LED); // need an output port, tentatively this will be the ALU output); // Instantiate ALU, REGS AND DECODER 

logic [3:0] flags;
logic [5:0] opcode; // top 6 bits of instruction
logic [2:0] ALUfunc; 
logic PCincr,PCabsbranch,PCrelbranch,imm,w;
logic [n-1:0] Rdata1, Rdata2, Alub, Wdata;
logic [4:0] Raddr1, Raddr2;
logic [Isize-1:0] I;
logic [Psize-1:0] Memaddress;
//    ALU control



 

alu alu(.clk(clk),.a(Rdata1),.b(Alub),.func(ALUfunc),.flags(flags),.result(Wdata));

registers r(.clk(clk),.w(w),.reset(reset),.Wdata(Wdata),.switches(SW),.Raddr1(Raddr1),.Raddr2(Raddr2),.Rdata1(Rdata1),.Rdata2(Rdata2));

decoder d(.opcode(opcode),.flags(flags),.PCincr(PCincr),.PCabsbranch(PCabsbranch),.PCrelbranch(PCrelbranch),.imm(imm),.w(w),.ALUfunc(ALUfunc));

mem m(.address(Memaddress),.I(I));

pc p(.clk(clk),.reset(reset),.PCincr(PCincr),.PCrelbranch(PCrelbranch),.Branchaddr(I[Psize-1:0]),.PCout(Memaddress));


//------------- code starts here ---------
// instruction decoder

always_comb
	begin 
	opcode = I[Isize-1:Isize-6];
	Raddr1 = I[n+10:n+5];
	Raddr2 = I[n+4:n];
end

assign Alub = (imm ? I[n-1:0] : Rdata2);
assign LED = Wdata;
assign reset = SW[9];
  




endmodule //module decoder --------------------------------
