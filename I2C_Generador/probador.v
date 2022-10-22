//probador
`timescale 1ns/1ns

module probador(
output reg clk,
output reg RESET,
output reg RNW,
output reg SDA_IN,
output reg START_STB,
output reg [15:0] WR_DATA,
output reg [6:0] I2C_ADDR,
input [15:0] RD_DATA,
input SDA_OUT,
input SDA_OE,
input SCL
);

initial begin
clk=0;
//escritura
RNW=0;
RESET=1;
WR_DATA = 16'b0000000011111111;
#18
#1 START_STB=1;
#1 START_STB=0;
#2 I2C_ADDR = 7'b0000010;
#63 SDA_IN=1;
#2 SDA_IN=0;
#26 
#10 
#43 SDA_IN=1;
#2 SDA_IN=0;
#70 SDA_IN=1;
#2 SDA_IN=0;
//lectura
#20 RNW=1;
#21 
#2 START_STB=1;
#1 START_STB=0;
#2 I2C_ADDR = 7'b0000010;
#63 SDA_IN=1;
#2 SDA_IN=0;
#26 SDA_IN=1;
#10 SDA_IN=0;
#43 SDA_IN=1;
#2 SDA_IN=0;
#100 SDA_IN=1;
#2 SDA_IN=0;
//reset
#20
#1 START_STB=1;
#1 START_STB=0;
#2 I2C_ADDR = 7'b0000010;
#63 SDA_IN=1;
#2 SDA_IN=0;
#26 SDA_IN=1;
#10 SDA_IN=0;
#43 SDA_IN=1;
#2 SDA_IN=0;
#30 RESET=0;
#10 RESET=1;
#30
$finish;
end 


always begin
#1 clk = !clk;
end

endmodule

