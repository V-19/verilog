 //Probador
 `timescale 1ns/1ns
 module probador (
 output reg clk, 
 output reg RESET,
 output reg MDIO_START,
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
 #2 T_DATA = 32'b01010100010000001000010001000000; //cadena para write
 #1 MDIO_START = 1; //flanco positivo que legitima la entrada en T_DATA
 #1 MDIO_START = 0;
 #2 RESET = 1;
 #100 
 #1 RESET = 0; // Se resetea el modulo 
 #2 T_DATA = 32'b01100101110010001000010001000000;//cadena para read 
 #1 MDIO_START = 1;//flanco positivo que legitima la entrada en T_DATA
 #1 MDIO_START = 0;
 #10 RESET = 1; 
 #20 MDIO_IN =1;//entrada serial en 1 los primeros 3 ciclos 
 #20 MDIO_IN =0; //entrada serial los demas ciclos 
 #100 $finish;

 end
 
 always begin //clock del modulo 
  #1  clk =  ! clk;
 end



 endmodule