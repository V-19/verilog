 //Probador
 `timescale 1ns/1ns
 module probador (output reg clk, output reg enb,
 output reg [3:0] D, //output reg [7:0] D,
 output reg [1:0] modo,
 input [3:0] Q, //input [7:0] Q,
 input  RCO //input [1:0] RCO,
 //input [1:0] a
 );

 // se inicializan los valores y luego se les pone valores segun la cantidad de flancos crecientes. 
 initial begin
 //$monitor ("Q=%b,RCO=%b,D=%b,modo=%b", Q,RCO,D,modo);
 clk = 0;
 enb = 0;
 modo = 2'b0;
 D = 4'b0;
 #5 enb = 2'b1;
 #5 D = 4'b0000;
 #5 modo = 2'b11;
 #5 modo = 2'b00;
 #150 $finish;
 end
 //el clk se invierte cada 5 unidades de tiempo 
 always begin
  #5  clk =  ! clk;
 end



 endmodule