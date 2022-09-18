 // Se incluyen lo otros modulos 
 
 
 `include "contador16bits_synthCMOS.v"
 `include "probador.v"
 //`include "contador16bits.v"
 `include "cmos_cells.v"

module tarea2testbench2;

wire clk;
wire enb;
wire [15:0] D; // de este modo implemento un bus de 4 bits para cada modulo
wire [1:0] modo;
wire [15:0] Q; // de este modo implemento un bus de 4 bits para cada modulo
wire [3:0] RCO;// de este modo implemento un bus de 1 bits para cada modulo

/*

assign clk1 = clk;
assign enable = enb;
assign d = D;
assign modo2 = modo;

*/
//se genera el archivo gtkwave
initial begin

  $dumpfile("resultados.vcd");
  $dumpvars;
  

end

// modulos necesarios para conter de 16 bits

  contador16bits B0 (
  .clk (clk),
 .enb (enb),
  .D (D), //(D[0])
  .modo (modo),
 .Q (Q),//(Q[0])
  .RCO (RCO)//(RCO[0])

  //.modo1(modo1[3:0])
  );

 probador senales (
  .clk (clk),
 .enb (enb),
  .D (D), //D[1:0]
  .modo (modo),
 .Q (Q),//Q[1:0]
  .RCO (RCO)
  
  //.modo1(modo1[3:0])
  );
  
 endmodule