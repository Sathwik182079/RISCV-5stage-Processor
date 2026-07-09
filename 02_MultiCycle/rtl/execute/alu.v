//=====================================================
// Module : ALU
// Project: 5-Stage Pipelined RISC-V Processor
// Author : T. Sathwik
// Date   :
//=====================================================

// Purpose:
// Performs arithmetic and logical operations
// for the Execute stage of the processor.

`timescale 1ns/1ps

module alu (

     input [31:0] operand_a, 
     input [31:0] operand_b , 
     input [3:0] ALU_control,

     output reg zero,
     output reg [31:0] ALU_result
     
      );

always @(*)
    begin 
           ALU_result = 32'b0; // Default value
              zero = 1'b0; // Default value

          case (ALU_control)
            4'b0000:
                    begin
                         ALU_result = operand_a + operand_b; // ADD       
                    end 
            4'b0001:
                    begin
                         ALU_result = operand_a - operand_b; // SUB                       
                    end                  
            4'b0010:
                    begin
                         ALU_result = operand_a & operand_b; // AND      
                    end
            4'b0011:
                    begin
                         ALU_result = operand_a | operand_b; // OR             
                    end
            4'b0100:
                    begin
                         ALU_result = operand_a ^ operand_b; // XOR 
                    end
            4'b0101:
                    begin
                         ALU_result = operand_a << operand_b[4:0]; // SLL                        
                    end
            4'b0110:
                    begin
                         ALU_result = operand_a >> operand_b[4:0]; // SRL                       
                    end
            4'b0111:
                    begin
                         ALU_result = $signed(operand_a) >>> operand_b[4:0]; // SRA                      
                    end
            4'b1000:
                    begin 
                         ALU_result = ($signed(operand_a) < $signed(operand_b)) ? 32'd1 : 32'd0; // SLT
                    end
            default:
                    begin  
                         ALU_result = 32'b0; // Default case
                    end
          endcase
                          zero = (ALU_result == 32'b0) ; // Set zero flag

    end














endmodule 
