//=====================================================
// Module : Immediate Generator
// Project: 5-Stage Pipelined RISC-V Processor
// Author : T. Sathwik
//=====================================================

`timescale 1ns/1ps

module immediate_generator(

    input [31:0] instruction,
    output reg [31:0] immediate

);

parameter I_type= 7'b0010011;
parameter Load   = 7'b0000011;
parameter Store  = 7'b0100011;
parameter Branch= 7'b1100011;
parameter J_TYPE = 7'b1101111;
parameter JALR = 7'b1100111;

always @(*)
 begin 
     

    
 immediate = 32'd0;

 case(instruction[6:0])
    
    I_type,Load,JALR:
           
            begin 
                 immediate ={{20{instruction[31]}},instruction[31:20]};
            end
    
    Store :

            begin 
                   immediate = {{20{instruction[31]}},instruction[31:25],instruction[11:7]};
            end    
            
    Branch :

            begin 
                   immediate = {{19{instruction[31]}},instruction[31],instruction[7],instruction[30:25],instruction[11:8],1'b0};
            end 
   J_TYPE:
            begin 
                   immediate = { {11{instruction[31]}},instruction[31], instruction[19:12], instruction[20],   instruction[30:21], 1'b0    }; 
            end
    
    default :
          
               begin 
                   immediate = 32'b0;
               end 
             

 endcase



 end

endmodule