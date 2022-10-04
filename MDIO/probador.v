 //Probador
 `timescale 1ns/1ns
 module probador (
 output reg clk, 
 output reg RESET,
 output reg MDIO_START,
 output reg MDIO,
 output reg MDIO_IN,
 output reg [31:0] T_DATA,
 input [15:0] RD_DATA, //bus de 16 bits para la salida Q 
 input MDIO_OUT,
 input MDIO_OE,
 input DATA_RDY,
 input MDC);

   
 

 initial begin
 //$monitor ("Q=%b,RCO=%b,D=%b,modo=%b", Q,RCO,D,modo);
 clk = 0;
 T_DATA = 32'b10000100010000001000010001000000;
 RESET = 0;
 #2 RESET = 1;
 #20 $finish;
 end
 
 always begin
  #1  clk =  ! clk;
 end



 endmodule