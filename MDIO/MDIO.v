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
    MDIO,
    MDIO_IN,
    T_DATA //[31:0]
 );

  //------------Inputs--------------
    input clk, RESET, MDIO_START, MDIO, MDIO_IN;
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
    reg modo;



always @(posedge clk) begin //flipflops de la maquina de estado 
  if (RESET) begin
     state  <= nxt_state;  // Estado de IDLE
  end else begin
    state  <= 6'b000001;   
  end
end 


  always @(posedge clk or posedge MDIO_START ) begin // procedimiento de las salidas y entradas del moculo 
          
      if(RESET) begin
      
        MDC <= ~MDC;

        if(modo)begin 
            //MDIO_START
            if(i==0) begin
                MDIO_OUT <= MDIO_OUT;
                MDIO_OE <= 0; 
            end else begin
                MDIO_OE <= 1;
                MDIO_OUT <= T_DATA[i]; 
                i = i-1;
            end

        end else if (modo==1'b0)begin
            
               if(j==15)begin
                  MDIO_OE <= 0;
                  MDIO_OUT<=MDIO_OUT;
                  RD_DATA [a] <= MDIO_IN; 
                  a = a+1;
               end else begin
                   MDIO_OE <= 1; 
                   MDIO_OUT <= T_DATA[j]; 
                  j = j-1;
               end

        end
    
      end
      else begin  
         MDC <= 0;
         i<=31; 
         j<=31;
         a<=0;
         DATA_RDY = 0;
         modo = 1'dx;

      end

    
  
  end


  always @(*) begin
    
    nxt_state = state;
    
    case(state) 

      6'b000001: if (T_DATA[31:30]==2'b01) nxt_state = 6'b000010;  
    
      else nxt_state = 6'b000001;   
                                        
      6'b000010: begin if (T_DATA[29:28]==(2'b01||2'b10)) begin 
        nxt_state = 6'b000100;  //write/read
          if(T_DATA[29:28]==2'b01)
              modo = 1; //modo write
          else modo = 0;  // modo read
        end
          else nxt_state = 6'b000010;
      end

      6'b000100:  nxt_state = 6'b001000;  //phyadr 

      6'b001000:  nxt_state = 6'b010000;  //regadr

      6'b010000:  nxt_state = 6'b100000; //ta

      6'b100000:  nxt_state = 6'b000010; //data

      default: nxt_state = 6'b000001;

    endcase

    end



endmodule 


