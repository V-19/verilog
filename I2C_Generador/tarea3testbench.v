//se incluyen los otros modulos

`include "I2C.v"
`include "probador.v"

module tarea3testbench;

wire clk;
wire SDA_IN;
wire RESET;
wire RNW;
wire [6:0] I2C_ADDR;
wire START_STB;
wire [15:0] WR_DATA;
wire [15:0] RD_DATA;
wire SDA_OUT;
wire SDA_OE;
wire SCL;


//se genera el archivo gtkwave
initial begin

  $dumpfile("resultados.vcd");
  $dumpvars;
  

end


//Modulo I2C

I2C IO(
.clk(clk),
.RESET(RESET),
.SDA_IN(SDA_IN),
.RNW(RNW),
.START_STB(START_STB),
.I2C_ADDR(I2C_ADDR),
.WR_DATA(WR_DATA),
.RD_DATA(RD_DATA),
.SDA_OUT(SDA_OUT),
.SDA_OE(SDA_OE),
.SCL(SCL)
);

//modulo tester

probador senales(
.clk(clk),
.RESET(RESET),
.SDA_IN(SDA_IN),
.RNW(RNW),
.START_STB(START_STB),
.I2C_ADDR(I2C_ADDR),
.WR_DATA(WR_DATA),
.RD_DATA(RD_DATA),
.SDA_OUT(SDA_OUT),
.SDA_OE(SDA_OE),
.SCL(SCL)
);

endmodule







