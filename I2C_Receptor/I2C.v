module I2C(
SDA_OUT,
SDA_OE,
SCL,
RD_DATA,//15bits
clk,
RESET,
SDA_IN,
I2C_ADDR,
WR_DATA//15bits

);

//-----------Inputs------------
input clk, RESET, SDA_OUT, SDA_OE, SCL;
input [15:0] RD_DATA;
input [6:0] I2C_ADDR;
//-----------outputs-----------
output reg [15:0] WR_DATA;
output reg SDA_IN;
//------------Variables auxiliares--------


reg [7:0] i2c; //variable de I2C_ADD con RNW
//integer i=7;//contador escritura
integer j=15;//contador escritura
integer k=7;//contador lectura
integer cont1=7;
integer cont2=0;
integer cont3=0;
reg [5:0] state;
reg [5:0] nxt_state;
reg cadena1;//habilita el guardar los bits de SDA_OUT en i2c 
reg cadena2;//habilita la lectura o escritura primeros 8 bits
reg cadena3;//habilita la lectura o escritura segundos 8 bits
reg c;//variable para detectar un flanco negativo
integer SDA_old=0;//contador 


always@(posedge clk)begin//flipflops maquina de estado y detector de flancos
	if(RESET)begin 
		
		state<= nxt_state;//cambiar de estado
			
		//SDA_old <= SDA_OUT;//valor viejo de SDA_OUT
		
		if(SDA_old==0) begin
		if(SDA_OUT==0) begin
			c<=1'b1;//flanco negativo
			SDA_old=SDA_old+1;//contador 
		end else c<=1'b0;//estado normal
		end else c<=1'b0;

	end else begin //reset de todas las salidas y variables auxiliares del modulo
		//restableces los valores para realizar una nueva transsacion
		j=15;
		k=7;
		cont1=7;
		cont2=0;
		cont3=0;
		cadena1=1'dx;//encargada de 
		cadena2=1'dx;//wr_data1
		cadena3=1'dx;//wr_data2
		SDA_IN=0;
		i2c=8'dx;
		state=6'b000001;
		nxt_state=6'b000001;
		WR_DATA=16'dx;
		SDA_old=0;
	end
end


always@(posedge SCL)begin//procedimiento de las salidas y entradas  del modulo
	
	if(RESET==1)begin
		if(cont1>-1)begin//si cont1 es menor a 8 
			if(cadena1)begin // si cadena1 esta habilitado haga lo de poner en i2c lo de SDA_OUT 
			  		 
						i2c[cont1]<=SDA_OUT;//se poner SDA_OUT en i2c	   	
				   		cont1=cont1-1;//cont1 toma de 7 a 0 hasta llegar a los 8 bits
				
					end else begin
					cont1=cont1;
					i2c=i2c;
				end
		end else if(i2c[0]==0) begin//escritura 
					
				SDA_IN=0;
				//escritura
				if(cont2<=7)begin//si cont2 es menor a 7 
					if(cadena2)begin // si cadena2 esta habilitado haga lo de poner en WR_DATA los primeros 8 bits seriales de SDA_OUT
						if(cont2==7)begin//implementacion para terminar la cuenta
							SDA_IN=1;//ACK
							WR_DATA[cont2]<= SDA_OUT;//se pone bit a bit de SDA_OUT en WR_DATA
							cont2=cont2+1;	//cont2 suma 1 para llegar a los 7 bits 
						end else begin
							WR_DATA[cont2]<= SDA_OUT;//se pone bit a bit de SDA_OUT en WR_DATA
							cont2=cont2+1;	//cont2 suma 1 para llegar a los 7 bits 
						end
					
					end else begin 
						cont2=cont2;
					end


				end else begin 
					SDA_IN=0;//se baja el ACK 
					if(cont2<=16)begin//si cont2 es menor a 16 
						if(cadena3)begin// si cadena3 esta habilitado haga lo de poner en WR_DATA los otros 8 bits seriales de SDA_OUT
							if(cont2==16)begin//implementacion para terminar la cuenta
								cont2=cont2+1;//cont2 suma 1 para llegar a los 16 bits
								SDA_IN=1;//ACK
							end else begin 	
								WR_DATA[cont2]<=SDA_OUT;//se pone bit a bit de SDA_OUT en WR_DATA
								cont2=cont2+1;	//cont2 suma 1 para llegar a los 16 bits						
							end
							
						end else begin
							cont2=cont2;
						end
					end else cont2<=cont2;
				
				end
					

									
			end else begin
				SDA_IN=0;
				if(i2c[0]==1)begin //lectura

					if(cont2!=9)begin //si cont2 no es 9 
						if(cadena2)begin// si cadena2 esta habilitado haga lo de poner en SDA_IN los primeros 8 bits de RD_DATA
							if(j==7)begin//implementacion para ir del numero mas significativo al menos 
								//SDA_IN=1;
								cont2=cont2+1;//cont2 suma 1 para llegar a los 8 bits 
							end else begin 
								SDA_IN=RD_DATA[j];//se pone los primeros 8 bits de RD_DATA en SDA_IN
								j=j-1;
								cont2=cont2+1;//cont2 suma 1 para llegar a los 8 bits 
							end
					end else begin 
						cont2=cont2+1;
					end

				end else begin 
					if(cont3<=8)begin//si cont3 no es 9 
						if(cadena3)begin// si cadena3 esta habilitado haga lo de poner en SDA_IN los otros 8 bits de RD_DATA
							if(k==-1)begin//implementacion para ir del numero mas significativo al menos 
								cont3=cont3+1;//cont2 suma 1 para llegar a los 8 bits 
							end else begin
								SDA_IN= RD_DATA[k];//se pone los otros 8 bits de RD_DATA en SDA_IN
								k=k-1;
								cont3=cont3+1;	//cont2 suma 1 para llegar a los 8 bits 					
							end
						
						end else begin
							cont3=cont3+1;
						end

					end 
				
				
				end
	
			end 
			


		end


		end 

end 
		
			




always @(*)begin

	nxt_state = state;//inicializacion
	
	case(state)//un case para pasar de estado en estado
		
		6'b000001: begin//1
			if(SCL==1 && c==1) nxt_state=6'b000010;//Condicion de inicio cuando se da un flanco negativo de SDA_OUT y SCL esta en 1
			else nxt_state=6'b000001;
		end
		
		6'b000010: begin cadena1=1;//se habilita el poner SDA_OUT en i2c
		nxt_state=6'b000100;//siguiente estado
		end

		6'b000100: if(cont1==-1) nxt_state=6'b001000;//si termina de poner todos los bits de i2c pase al siguiente estado 
			   else nxt_state=6'b000100;

		6'b001000: if(i2c[7:1]==I2C_ADDR) begin//si se cumple que la direccion dada de I2C es igual a la que tiene el receptor pase al siguiente estado 
				SDA_IN=1;//ACK
				cadena2=1;//habilitacion de la proxima etapa de lectura o escritura
				nxt_state= 6'b010000;//siguiente estado
		end else begin//si la dirrecion no es la misma se recetea el estado y las variables auxiliares para que se ponga otro dispositivo  
				//i=6;
				j=15;
				cont1=0;
				cadena1=1'dx;
			    cadena2=1'dx;
			    nxt_state=6'b001000;
		end

		6'b010000: begin if(i2c[0]==0)begin//si es escritura   
					if(cont2==8)begin//se leyeron todos los datos ?
						cadena3=1; //si se leyeron todos pase a la sigueinte etapa
						nxt_state=6'b100000;
					end else nxt_state=6'b010000;
				end else if(SDA_OUT==1 && cont2==9)begin// es lectura, se recibio un ack y ya se termino de escribir los datos ?
					cadena3=1;//si se escribieron todos pase a la sigueinte etapa
					nxt_state=6'b100000;
				end else nxt_state=6'b010000;


		end


		6'b100000: begin //20
			if(cont2==17 || (cont3==9))begin //se termino de leer o de escribir todos los datos 
				if(SCL==1&&SDA_OUT==1)begin//condicion de parada
					//i=6;//restableces los valores para realizar una nueva transsacion
					j=15;
					k=7;
					cont1=7;
					cont2=0;
					cont3=0;
					cadena1=1'dx;//habilitacion de i2c
					cadena2=1'dx;//habilitacion de lectura o escritura primeros 8 bits
					cadena3=1'dx;//habilitacion de lectura o escritura segundos 8 bits 
					SDA_IN=0;
					i2c=8'dx;//reset de i2c
					state=6'b000001;
					nxt_state=6'b000001;
					WR_DATA=16'dx;//reset de WR_DATA
					SDA_old=0;
				end

			end else  nxt_state=6'b100000;		

		end

		default: nxt_state=6'b000001;//si no pasa nada se pasa al primer estado
	endcase
	
end

endmodule







