module picoMIPStestbench;
logic clk;  // 50MHz Altera DE0 clock
logic [9:0] SW; // Switches SW0..SW9 One of these is used for the reset signal 
logic [7:0] LED;// 

picoMIPStest p(.fastclk(clk),.SW(SW),.LED(LED));

initial
begin
  clk =  0;
  #5ns  forever #5ns clk = ~clk;
end

initial
begin
   SW = 10'b1000000000;

   #20 SW = 10'b0100000001;
   #30 SW = 10'b0000000010;
   #30 SW = 10'b0100000010;
   #120 SW = 10'b0000001111;
  
end

endmodule



