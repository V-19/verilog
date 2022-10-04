 // Se incluyen lo otros modulos 
 
 
 `include "MDIO.v"
 `include "probador.v"

module tarea3testbench;

wire clk;
wire RESET;
wire MDIO_START;
wire MDIO;
wire MDIO_IN;
wire [31:0] T_DATA;
wire [15:0] RD_DATA; //bus de 16 bits para la salida Q 
wire MDIO_OUT;
wire MDIO_OE;
wire DATA_RDY;
wire MDC;

//se genera el archivo gtkwave
initial begin

  $dumpfile("resultados.vcd");
  $dumpvars;
  

end

// modulo

  MDIO M0 (
  .clk (clk),
  .RESET (RESET),
  .MDIO_START (MDIO_START), 
  .MDIO (MDIO),
  .MDIO_IN (MDIO_IN),
  .T_DATA (T_DATA),
  .RD_DATA (RD_DATA),
  .MDIO_OUT (MDIO_OUT),
  .MDIO_OE (MDIO_OE),
  .DATA_RDY (DATA_RDY),
  .MDC (MDC)
  );

 probador senales (
  .clk (clk),
  .RESET (RESET),
  .MDIO_START (MDIO_START), 
  .MDIO (MDIO),
  .MDIO_IN (MDIO_IN),
  .T_DATA (T_DATA),
  .RD_DATA (RD_DATA),
  .MDIO_OUT (MDIO_OUT),
  .MDIO_OE (MDIO_OE),
  .DATA_RDY (DATA_RDY),
  .MDC (MDC)
  );
  
 endmodule
