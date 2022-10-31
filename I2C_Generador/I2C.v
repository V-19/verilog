module I2C(
SDA_OUT,
SDA_OE,
SCL,
RD_DATA,//15bits
clk,
RNW,
RESET,
SDA_IN,
I2C_ADDR,
START_STB,
WR_DATA//15bits

);

//-----------Inputs------------
input clk, RESET, RNW, SDA_IN, START_STB;
input [15:0] WR_DATA;
input [6:0] I2C_ADDR;
//-----------outputs-----------
output reg [15:0] RD_DATA;
output reg SDA_OUT, SDA_OE;
output SCL;
//------------Variables auxiliares--------
wire[7:0] rnw; //variable de I2C_ADD con RNW
integer i=6;//contador escritura
integer j=15;//contador escritura
integer k=7;//contador lectura
integer cont1=0;
integer cont2=0;
integer cont3=0;
reg [5:0] state;
reg [5:0] nxt_state;
reg cadena1;//I2C_ADDR
reg cadena2;//wr_data1
reg cadena3;//wr_data2
reg [1:0] m;//variable para SCL 25 % de la frecuencia de clk
reg c;//variable para detectar un flanco negativo
reg SDA_old;//variable para detectar un flanco negativo

assign rnw[7:1] = I2C_ADDR; // se asignan los primeros 7 bit de I2C_ADDR 
assign rnw[0]=RNW;//se asigna el bit de RNW
initial m=0;
initial SDA_OUT=1;//para la condicion de inicio

always@(posedge clk)begin//flipflops maquina de estado y detector de flancos
	if(RESET)begin 
		
		state<= nxt_state;//cambiar de estado
		m<=m+1;//para hacer la frecuencia mas pequena
		
		if(START_STB==1)begin//condicion de inicio cuando START_STB es 1
			SDA_OUT=0;
		end
	
		SDA_old<= SDA_OUT;//valor viejo de SDA_OUT
		begin//determinar cuando se da un flanco negativo en SDA_OUT
		if(~SDA_OUT && SDA_old)
			c<=1'b0;//flanco negativo
		else c<=1'b1;//estado normal

		end
	end else begin //reset de todas las salidas y variables auxiliares del modulo
		i=6;
		j=15;
		k=7;
		cont1=0;
		cont2=0;
		cont3=0;
		nxt_state<=6'b000001;
		cadena1=1'dx;//I2C_ADDR
		cadena2=1'dx;//wr_data1
		cadena3=1'dx;//wr_data2
		RD_DATA<=16'dx;
		SDA_OE <=0;
		SDA_OUT<=1;
	end
end

assign SCL = m[1];//implementacion de SCL con 25% de la frecuencia 

always@(posedge SCL)begin//procedimiento de las salidas y entradas  del modulo
	
	if(RESET==1)begin
		if(cont1<=8)begin//si cont1 es menor a 8 
			if(cadena1)begin // si cadena1 esta habilitado haga lo de poner en SDA_OUT lo de I2C_ADDR
				   if(i==-1)begin//implementacion para ir del numero mas significativo al menos 
						SDA_OE=0;
				   		SDA_OUT=0;
				   		cont1=cont1+1;//cont1 suma 1 para llegar a los 8 bits 
				   end else begin
			 	   		SDA_OE=1;
				   		SDA_OUT=rnw[i];//se poner I2C_ADDR en SDA_OUT	
				   		i=i-1;
				   		cont1=cont1+1;//cont1 suma 1 para llegar a los 8 bits
				   end
			end else begin
					SDA_OE=SDA_OE;
					SDA_OUT=SDA_OUT;
				end
		end else begin
			if(RNW==0)begin //escritura

				if(cont2!=9)begin //si cont2 no es 9 
					if(cadena2)begin// si cadena2 esta habilitado haga lo de poner en SDA_OUT los primeros 8 bits de WR_DATA
						if(j==7)begin//implementacion para ir del numero mas significativo al menos 
							SDA_OE=0;
							cont2=cont2+1;//cont2 suma 1 para llegar a los 8 bits 
						end else begin 
							SDA_OUT=WR_DATA[j];//se pone los primeros 8 bits de WR_DATA en SDA_OUT
				   			SDA_OE<=1;
							j=j-1;
							cont2=cont2+1;//cont2 suma 1 para llegar a los 8 bits 
						end
					end else begin 
						SDA_OE=SDA_OE;
				   		SDA_OUT=SDA_OUT;
					end

				end else begin 
					if(cont3!=9)begin//si cont3 no es 9 
						if(cadena3)begin// si cadena3 esta habilitado haga lo de poner en SDA_OUT los otros 8 bits de WR_DATA
							if(k==-1)begin//implementacion para ir del numero mas significativo al menos 
								SDA_OE=0;
								SDA_OUT=0;	
								cont3=cont3+1;//cont2 suma 1 para llegar a los 8 bits 
							end else begin
								SDA_OUT= WR_DATA[k];//se pone los otros 8 bits de WR_DATA en SDA_OUT
								SDA_OE =1;
								k=k-1;
								cont3=cont3+1;	//cont2 suma 1 para llegar a los 8 bits 					
							end
						
						end else begin
							SDA_OE=SDA_OE;
							SDA_OUT=SDA_OUT;
						end

					end else SDA_OE=0;
				
				
				end
	
			end else begin //lectura
				if(cont2<=7)begin//si cont2 es menor a 8 
					if(cadena2)begin // si cadena2 esta habilitado haga lo de poner en RD_DATA los primeros 8 bits seriales de SDA_IN
						if(cont2==7)begin//implementacion para terminar la cuenta
							SDA_OE<=0;
							SDA_OUT<=1;
							RD_DATA[cont2]<= SDA_IN;//se pone bit a bit de SDA_IN en RD_DATA
							cont2=cont2+1;	//cont2 suma 1 para llegar a los 8 bits 
						end else begin
							RD_DATA[cont2]<= SDA_IN;//se pone bit a bit de SDA_IN en RD_DATA
							SDA_OE<=0;
							cont2=cont2+1;	//cont2 suma 1 para llegar a los 8 bits 
						end
					
					end else begin 
						SDA_OUT<=SDA_OUT;
						SDA_OE<=SDA_OUT;
					end


				end else begin 
					SDA_OUT=0;//se baja el ACK 
					if(cont2<=16)begin//si cont2 es menor a 16 
						if(cadena3)begin// si cadena3 esta habilitado haga lo de poner en RD_DATA los otros 8 bits seriales de SDA_IN
							if(cont2==16)begin//implementacion para terminar la cuenta
								SDA_OE<=0;
								cont2=cont2+1;//cont2 suma 1 para llegar a los 16 bits
							end else begin 	
								RD_DATA[cont2]<=SDA_IN;//se pone bit a bit de SDA_IN en RD_DATA
								SDA_OE<=0;
								cont2=cont2+1;	//cont2 suma 1 para llegar a los 16 bits						
							end
							
						end else begin
							SDA_OE<=0;
							SDA_OUT <= SDA_OUT;
						end
					end else SDA_OE<=0;
				
				end
			


		end


	end
		
	end

end


always @(*)begin

	nxt_state = state;//inicializacion
	
	case(state)//un case para pasar de estado en estado
		
		6'b000001: begin//1
			if(SCL==1 && c==0) begin nxt_state=6'b000010;//Condicion de inicio cuando se da un flanco negativo de SDA_OUT y SCL esta en 1
					SDA_OE=1;
			end
			else nxt_state=6'b000001;
		end
		
		6'b000010: begin cadena1=1;//se habilita el poner I2C_ADDR en SDA_OUT
		nxt_state=6'b000100;//siguiente estado
		end

		6'b000100: if(cont1==8) nxt_state=6'b001000;//si termina de poner todos los bits de I2C_ADDR pase al siguiente estado 
			   else nxt_state=6'b000100;

		6'b001000: if(SDA_IN==1)begin//si se recibe un ACK habilite la siguiente etapa de escritura o lectura 
				cadena2=1;
				nxt_state= 6'b010000;
			   end else nxt_state=6'b001000;

		6'b010000: begin if(RNW==1)begin//si es lectura depende del ACK para continuar si no solo de terminar de leer los datos 
					if(cont2==8)begin//se leyeron todos los datos ?
						cadena3=1; //si se leyeron todos pase a la sigueinte etapa
						nxt_state=6'b100000;
					end else nxt_state=6'b010000;
				end else if(SDA_IN==1 && cont2==9)begin//se recibio un ack y ya se termino de escribir los datos ?
					cadena3=1;//si se escribieron todos pase a la sigueinte etapa
					nxt_state=6'b100000;
				end else nxt_state=6'b010000;


		end


		6'b100000: begin //20
			if(cont2==17 || (cont3==9 && SDA_IN==1))begin //se termino de leer o de escribir todos los datos 
				SDA_OUT=1;//se vuelve a 1 para condicion de parada
				if(SDA_OUT==1 && SCL==1)begin
					i=6;//restableces los valores para realizar una nueva transsacion
					j=15;
					k=7;
					cont1=0;
					cont2=0;
					cont3=0;
					state=6'b000001;
					nxt_state=6'b000001;
					cadena1=1'dx;//I2C_ADDR
					cadena2=1'dx;//wr_data1
					cadena3=1'dx;//wr_data2
					RD_DATA<=16'dx;
					SDA_OE =0;
					SDA_OUT=1;
				end

			end else nxt_state=6'b100000;		

		end

		default: nxt_state=6'b000001;//si no pasa nada se pasa al primer estado
	endcase
	
end

endmodule







