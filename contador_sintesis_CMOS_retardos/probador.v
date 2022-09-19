 //Probador
 `timescale 1ns/1ns
 module probador (output reg clk, output reg enb,
 output reg [15:0] D, //bus de 16 bits para la entrada D 
 output reg [1:0] modo,
 input [15:0] Q, //bus de 16 bits para la salida Q 
 input [3:0] RCO//input [1:0] RCO,

 );

 

 initial begin
 //$monitor ("Q=%b,RCO=%b,D=%b,modo=%b", Q,RCO,D,modo);
 clk = 0;
 enb = 0;
 D = 16'b0;
 #1 enb = 2'b1;
 #1 D = 16'b0;
 #20 modo = 2'b11;
 //#5 D = 16'b0;
 #40 modo = 2'b00;
 #500000 
 $finish;
 end
 
 always begin
  #17 clk =  ! clk;
 end



 endmodule