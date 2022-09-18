module tarea12    (  
    
    Q ,//output del estado del contador
    RCO,// Ripple-Carry Out
    a,//variable auxiliar
    clk, //clock del modulo
    enb,  // enable del contador
    modo,  // input modo
    D //input de datos
 );

  //------------Inputs--------------
    input enb, clk;
    input [3:0] D;
    input [1:0] modo;
  //----------Outputs--------------
    output reg [3:0] Q ; 
    output reg RCO;
    output reg a;
    
  //usar case/switch para los 4 casos para modo
  

  
always @(posedge clk)begin
  if (enb) begin
    //usar case casos del contador
        
        case (modo)
          2'b00: Q <= Q+1; //counter positivo +1
          2'b01: Q <= Q-1; //counter negativo -1
          2'b10: Q <= Q-3; //counter negativo de 3 en 3
          2'b11: Q <= D; //counter paralelo de su entrada D 
          default: Q <= Q;
        endcase
        
      //implementacion de una salida a para los demas contadores en paralelo para poder inicializarlos como modo 1 
      //ya que a puede ser RCO o clk dependiendo del modo de los contadores
      
      if(modo == 2'b11)
        begin
          a <= clk;
        end
      else begin 
          a <= RCO;
      end

  //  modo1
 

    
      if(Q == 4'b1110 && modo == 2'b00 ) begin //cuenta ascendente +1

          RCO = 1'b1; // RCO = 1 si se rebasa la cuenta ascendente

      end else begin

          if(Q == 4'b0001 && modo == 2'b01 ) begin //cuenta descendente -1

            RCO = 1'b1;// RCO = 1 si se rebasa la cuenta descendente

          end else begin
          
            //se presenta 3 casos cuando se da el RCO = 1, como se tiene un retardo a la hora de tomar RCO como 1, se usan condiciones antes de la condicion real
            // ejemplo caso cuando Q=0000, para este caso se haria if(Q == 4'b0011) ya que por el retardo cuando Q =0000 no lo toma como RCO = 1 

            if((Q == 4'b0011 || Q == 4'b0101 || Q == 4'b0100) && modo == 2'b10) begin //cuenta descendente -3

              RCO = 1'b1;// RCO = 1 si se rebasa la cuenta descendente -3 (casos 0,1,2)

              

            end else begin 
              RCO = 1'b0;
            end
          
          end 


      end
  
  end


end


endmodule 