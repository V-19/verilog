 // Se incluyen lo otros modulos 
 
 `include "tarea12.v"
 `include "probador2.v"
module tarea1tb2 ();
wire clk; 
wire enb;
wire [3:0][3:0] D; // de este modo implemento un bus de 4 bits para cada modulo
wire [1:0] modo;
wire [3:0][3:0] Q; // de este modo implemento un bus de 4 bits para cada modulo
wire [3:0] RCO;
wire [3:0] a; // de este modo implemento un bus de 1 bits para cada modulo


initial begin

  $dumpfile("resultados.vcd");
  $dumpvars;
  

end

// modulos necesarios para conter de 16 bits

  tarea12 U0 (
  .clk (clk),
 .enb (enb),
  .D (D[0]), //(D[0])
  .modo (modo),
 .Q (Q[0]),//(Q[0])
  .RCO ((RCO[0])),//(RCO[0])
  .a((a[0]))//(a[0])
  );

 tarea12 U1 (
  .clk (a[0]),
 .enb (enb),
  .D (D[1]),
  .modo (modo),
 .Q (Q[1]),
  .RCO (RCO[1]),
  .a(a[1])
  );

  tarea12 U2 (
  .clk (a[1]),
 .enb (enb),
  .D (D[2]),
  .modo (modo),
 .Q (Q[2]),
  .RCO (RCO[2]),
  .a(a[2])
  );

  tarea12 U3 (
  .clk (a[2]),
 .enb (enb),
  .D (D[3]),
  .modo (modo),
 .Q (Q[3]),
  .RCO (RCO[3]),
  .a(a[3])
  ); 

probador2 senales (
  .clk (clk),
 .enb (enb),
  .D (D[3:0]), //D[1:0]
  .modo (modo),
 .Q (Q[3:0]),//Q[1:0]
  .RCO (RCO),
  .a(a[3:0]) //a[1:0]
  );
  
 endmodule