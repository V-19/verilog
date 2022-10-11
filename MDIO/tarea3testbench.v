 // Se incluyen lo otros modulos 
 
 
 `include "MDIO.v"
 `include "probador.v"

module tarea3testbench;

wire clk;
wire RESET;
wire MDIO_START;
wire MDIO_IN;
wire [31:0] T_DATA;
wire [15:0] RD_DATA; 
wire MDIO_OUT;
wire MDIO_OE;
wire DATA_RDY;
wire MDC;

//se genera el archivo gtkwave
initial begin

  $dumpfile("resultados.vcd");
  $dumpvars;
  

end

// modulo MDIO

  MDIO M0 (
  .clk (clk),
  .RESET (RESET),
  .MDIO_START (MDIO_START), 
  .MDIO_IN (MDIO_IN),
  .T_DATA (T_DATA),
  .RD_DATA (RD_DATA),
  .MDIO_OUT (MDIO_OUT),
  .MDIO_OE (MDIO_OE),
  .DATA_RDY (DATA_RDY),
  .MDC (MDC)
  );
//Modulo tester 
 probador senales (
  .clk (clk),
  .RESET (RESET),
  .MDIO_START (MDIO_START), 
  .MDIO_IN (MDIO_IN),
  .T_DATA (T_DATA),
  .RD_DATA (RD_DATA),
  .MDIO_OUT (MDIO_OUT),
  .MDIO_OE (MDIO_OE),
  .DATA_RDY (DATA_RDY),
  .MDC (MDC)
  );
  
 endmodule
