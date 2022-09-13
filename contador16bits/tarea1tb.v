 // Testbench Code Goes here
 
 `include "tarea1.v"
 `include "probador.v"
module tarea1tb ();
wire clk; 
wire enb;
wire [3:0] D; //wire [1:0][3:0] D;
wire [1:0] modo;
wire [3:0] Q; //wire [1:0][3:0] Q;
wire RCO; //wire [1:0] RCO;
//wire [1:0] a;

initial begin

  $dumpfile("resultados.vcd");
  $dumpvars;
  

end



  tarea1 U0 (
  .clk (clk),
 .enb (enb),
  .D (D), //(D[0])
  .modo (modo),
 .Q (Q),//(Q[0])
  .RCO (RCO),//(RCO[0])
  .a(a)//(a[0])
  );

/*  tarea1 U1 (
  .clk (a[0]),
 .enb (enb),
  .D (D[1]),
  .modo (modo),
 .Q (Q[1]),
  .RCO (RCO[1]),
  .a(a[1])
  );*/

probador senales (
  .clk (clk),
 .enb (enb),
  .D (D), //D[1:0]
  .modo (modo),
 .Q (Q),//Q[1:0]
  .RCO (RCO)
  //.a(a[1:0]) //a[1:0]
  );
  
 endmodule