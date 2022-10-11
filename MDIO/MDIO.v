module MDIO  (  
    MDIO_OUT,
    MDIO_OE,
    DATA_RDY ,
    MDC,
    RD_DATA,//[15:0]
    clk, 
    MDC,  
    RESET,
    MDIO_START,
    MDIO_IN,
    T_DATA //[31:0]
 );

  //------------Inputs--------------
    input clk, RESET, MDIO_START, MDIO_IN;
    input [31:0] T_DATA;
  //----------Outputs--------------
    output reg [15:0] RD_DATA ; 
    output reg MDIO_OUT, MDIO_OE, DATA_RDY;
    output reg MDC;
    //------------variables auxiliares--------
    integer i=31; 
    integer j=31;
    integer a=0;
    reg [5:0] state;
    reg [5:0] nxt_state;
    reg modo;//variable que determina si es escritura o lectura



always @(posedge clk) begin //flipflops de la maquina de estado 
  if (RESET) begin
     state  <= nxt_state;  
  end else begin
    state  <= 6'b000001;   
  end
end 


  always @(posedge clk or posedge MDIO_START ) begin // procedimiento de las salidas y entradas del moculo 
          
      if(RESET) begin
      
        MDC <= ~MDC; // MDC con la mitad de la frecuencia del clk 

        if(modo)begin  //si modo es 1 se da una operacion de escritura
          
            if(i<0) begin // termina la operacion de escritura
                MDIO_OUT <= MDIO_OUT;
                MDIO_OE <= 0; 
            end else begin
                MDIO_OE <= 1; //se mantiene en alto durante la escritura
                MDIO_OUT <= T_DATA[i]; //va asignando cada dato de la entrada paralela a la salida serial 
                i = i-1;
            end

        end else if (modo==1'b0)begin // si modo es 0 se entra en la operacion de lectura
            
               if(j==15)begin //comienza a leer lo que este en la entrada MDIO_IN
                  MDIO_OE <= 0;
                  MDIO_OUT<=MDIO_OUT;
                  RD_DATA [a] = MDIO_IN; 
                  a = a+1;
                  if(a==16) // cuando se haya recorrido todo los ultimos 16 bits se pone en alto DATA_RDY
                  begin
                  DATA_RDY = 1;
                  end
      
               end else begin // Pone los primeros 16 bits de T_DATA en MDIO_OUT
                   MDIO_OE <= 1; //Se pone en alto durante esta operacion
                   MDIO_OUT <= T_DATA[j]; 
                  j = j-1;
               end

        end
    
      end
      else begin  //reset de todas las salidas y variables auxiliares del modulo 
         MDC <= 0;
         i<=31; 
         j<=31;
         a<=0;
         DATA_RDY = 0;
         modo = 1'dx;//tiene que ser un valor X ya que si es 0 o 1 impide el funcionamiento correcto del modulo 
         MDIO_OUT = 0;
         MDIO_OE =0;

      end

    
  
  end


  always @(*) begin
    
    nxt_state = state; //inicializacion 
    
    case(state) //un case para pasar de estado en estado 

      6'b000001: if (T_DATA[31:30]==2'b01) nxt_state = 6'b000010;  //estado ST, solo cuando los primeros 2 bits son 01  se pasa al siguiente estado
    
      else nxt_state = 6'b000001;   //se queda en este estado si no se cumple con lo anterior
                                        
      
      6'b000010: if (T_DATA[29:28]==(2'b10)) begin // estado OP, determina si es una operacion de write o read.  
          //nxt_state = 6'b000100; 
              if (T_DATA[29:28]==2'b10) begin //operacion de read 
                modo = 0; // modo read
                //nxt_state = 6'b000100;  // 
               end
               nxt_state = 6'b000100;//pasa al siguiente estado 
      end else if(T_DATA[29:28]==2'b01) begin//operacion write
                modo = 1;//modo write
                nxt_state = 6'b000100;//pasa al siguiente estado
      end else nxt_state = 6'b000001;//sino se cumple lo anterior se devuelve al primer estado
          
      6'b000100:  nxt_state = 6'b001000;  //estado phyadr 

      6'b001000:  nxt_state = 6'b010000;  //estado regadr

      6'b010000:  nxt_state = 6'b100000; //estado ta

      6'b100000:  nxt_state = 6'b000001; //estado data, se pasa al primer estado para la proxima operacion 

      default: nxt_state = 6'b000001;// si no pasa nada se pasa la primer estado 


    endcase

    end



endmodule 


