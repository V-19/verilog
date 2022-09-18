`include "cont1.v"
`include "cont2.v"

module contador16bits(  


input clk,
input enb,
input [15:0] D, // de este modo implemento un bus de 4 bits para cada modulo
input [1:0] modo,
output [15:0] Q, // de este modo implemento un bus de 4 bits para cada modulo
output [3:0] RCO
//output  reg [3:0] a
//input wire [3:0] modo1    
 );
  /*wire [15:0] q;
  wire [3:0] rco1;*/
  wire a1;
  wire a2;
  wire a3;
  wire modo1;

 //implementacion de una salida a para los demas contadores en paralelo para poder inicializarlos como modo 1 
      //ya que a puede ser RCO o clk dependiendo del modo de los contadores
//assign q = Q;
assign  modo1=(modo==2'b11);
assign  a1  = modo1 ? clk : RCO[0]; 
assign  a2  = modo1 ? clk : RCO[1]; 
assign  a3  = modo1 ? clk : RCO[2]; 




cont1 U0 (
  .clk (clk),
 .enb (enb),
  .D (D[3:0]), //(D[0])
  .modo (modo),
 .Q (Q[3:0]),//(Q[0])
  .RCO ((RCO[0]))//(RCO[0])
  
  //.modo1(modo1)
  );

 cont2 U1 (
  .clk (a1),
 .enb (enb),
  .D (D[7:4]),
  .modo (modo),
 .Q (Q[7:4]),
  .RCO (RCO[1])

  //.modo1(modo1)
  );

  cont2 U2 (
  .clk (a2),
 .enb (enb),
  .D (D[11:8]),
  .modo (modo),
 .Q (Q[11:8]),
  .RCO (RCO[2])
 
  //.modo1(modo1)
  );

  cont2 U3 (
  .clk (a3),
 .enb (enb),
  .D (D[15:12]),
  .modo (modo),
 .Q (Q[15:12]),
  .RCO (RCO[3])
  
  //.modo1(modo1)
  ); 
/*
assign RCO[0] = rco1 [0];
assign RCO[1] = rco1 [1];
assign RCO[2] = rco1 [2];
assign RCO[3] = rco1 [3];

assign Q[3:0] = q [3:0];
assign Q[7:4] = q [7:4];
assign Q[11:8] = q [11:8];
assign Q[15:12] = q [15:12];
*/

endmodule 