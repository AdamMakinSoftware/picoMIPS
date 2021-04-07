//-----------------------------------------------------
// File Name : regs.sv
// Function : picoMIPS 32 x n registers, %0 == 0
// Version 1 :
// Author: tjk
// Last rev. 27 Oct 2012
//-----------------------------------------------------
module registers #(parameter n = 8) // n - data bus width
(input logic clk, w, reset, // clk and write control
 input logic [n-1:0] Wdata, 
 input logic [9:0] switches,
 input logic [4:0] Raddr1, Raddr2,
 output logic [n-1:0] Rdata1, Rdata2);

 // Declare 32 n-bit registers 
	logic [n-1:0] gpr [31:0];
   // write process, dest reg is Raddr1
	always_ff @ (posedge clk)
	begin
	gpr[1] <= switches[7:0];     // Register 1 stores the value input on sw7-sw0
	gpr[2] <= switches [8];        // Register 2 stores sw8
	if(reset) 
			for(int i =3; i<32;i++)
				gpr[i] <= 0;                  // Reset register values
		else if (w)
            gpr[Raddr1] <= Wdata;
		

	end
	// read process, output 0 if %0 is selected
	always_comb
	begin
	   if (Raddr1==5'd0)
	         Rdata1 =  {n{1'b0}};
        else  Rdata1 = gpr[Raddr1];
	 
        if (Raddr2==5'd0)
	        Rdata2 =  {n{1'b0}};
	  else  Rdata2 = gpr[Raddr2];
	end	
	

endmodule // module regs