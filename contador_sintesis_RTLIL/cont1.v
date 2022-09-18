module cont1  (  
    
    Q ,//output del estado del contador
    RCO,// Ripple-Carry Out
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
   // output reg a;
    
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
        
     
      
      /*if(modo == 2'b11)
        begin
          a <= clk;
        end
      else begin 
          a <= RCO;
      end*/

  //  modo1
   // assign modo1=(modo==2'b11);
   // assign a = modo1 ? clk :RCO;

    
      if(Q == 4'b1111 && modo == 2'b00 ) begin //cuenta ascendente +1

          RCO = 1'b1; // RCO = 1 si se rebasa la cuenta ascendente

      end else begin

          if(Q == 4'b0000 && modo == 2'b01 ) begin //cuenta descendente -1

            RCO = 1'b1;// RCO = 1 si se rebasa la cuenta descendente

          end else begin
          
            //se presenta 3 casos cuando se da el RCO = 1, como se tiene un retardo a la hora de tomar RCO como 1, se usan condiciones antes de la condicion real
            // ejemplo caso cuando Q=0000, para este caso se haria if(Q == 4'b0011) ya que por el retardo cuando Q =0000 no lo toma como RCO = 1 

            if((Q == 4'b0000 || Q == 4'b0001 || Q == 4'b0010) && modo == 2'b10) begin //cuenta descendente -3

              RCO = 1'b1;// RCO = 1 si se rebasa la cuenta descendente -3 (casos 0,1,2)

            end else begin 
              RCO = 1'b0;
            end
          
          end 


      end
  
  end


end


endmodule 