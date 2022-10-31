//probador
`timescale 1ns/1ns

module probador(
output reg clk,
output reg SCL,
output reg RESET,
output reg SDA_OUT,
output reg SDA_OE,
output reg [6:0] I2C_ADDR,
output reg [15:0] RD_DATA,
input [15:0] WR_DATA,
input SDA_IN
);


initial begin
clk=0;
SCL=0;
RESET=1;
SDA_OUT=1;
I2C_ADDR = 7'b0000010;
RD_DATA= 16'b0011010011111111;
//escritura
#5 SDA_OUT=0;
#1 SDA_OE=1;
#45
#1 SDA_OUT=1;
#2 SDA_OUT=0;
#14 SDA_OE=0;//68
#8 SDA_OE=1;//76
#24 SDA_OUT=1;
#2 SDA_OUT=0;
#30 SDA_OE=0;//132
#8 SDA_OE=1;//140
#56 SDA_OE=0;//196
#18 SDA_OUT=1;//214
#2 //SDA_OUT=0;
#10//226
//lectura
#2 SDA_OUT=0;
#1 SDA_OE=1;
#46//49
#1 SDA_OUT=1;
#2 SDA_OUT=0; //52
#14 SDA_OUT=1;//66
#1 SDA_OUT=0;//67
#7 SDA_OE=0;
#64 SDA_OUT =1;//138
#8 SDA_OUT=0;
#56
#8 
#56 
#18 SDA_OUT=1;
#2 
//RESET
#10
#2 SDA_OUT=0;
#1 SDA_OE=1;
#46
#1 SDA_OUT=1;
#2 SDA_OUT=0;
#14 SDA_OUT=1;//66
#1 SDA_OUT=0;//67
#7 SDA_OE=0;
#64 SDA_OUT =1;//138
#8 SDA_OUT=0;
#8 RESET=0;
#56 
#56 
#18 SDA_OUT=1;
#2 RESET=1;

#100 $finish;
end 


always begin
#4 SCL = !SCL;
end

always begin
#1 clk = !clk;
end

endmodule

