//=====================================================
// Module : ALU Control Unit
// Project: 5-Stage Pipelined RISC-V Processor
// Author : T. Sathwik
// Date   :
//=====================================================

//-----------------------------------------------------
// Description:
// Generates the ALU control signal based on
// ALUOp, funct3 and funct7.
//
// Supports:
// • R-Type Instructions
// • I-Type Instructions
// • Load Instructions
// • Store Instructions
// • Branch Instructions
//-----------------------------------------------------

`timescale 1ns/1ps

module alu_control(
    input [1:0]ALUop,
    input [2:0]funct3,
    input [6:0]funct7,
    output reg [3:0] ALUControl
);
  
    parameter ADD = 4'b0000;
    parameter SUB = 4'b0001;
    parameter AND = 4'b0010;
    parameter OR  = 4'b0011;
    parameter XOR = 4'b0100;
    parameter SLL = 4'b0101;
    parameter SRL = 4'b0110;
    parameter SRA = 4'b0111;
    parameter SLT = 4'b1000;


   always @(*)

    begin
        ALUControl = ADD;

      case(ALUop)


            2'b00:
                 begin
                    ALUControl = ADD;
                 end

            2'b01:
                 begin
                ALUControl = SUB;
                 end 

            2'b10:
                begin 
                     case(funct3)
                          
                          3'b000:
                                 begin 
                                     if(funct7 == 7'b0100000)
                                            ALUControl = SUB;
                                     else
                                            ALUControl = ADD;
                                 end

                         3'b111:
                                 begin 
                                     ALUControl = AND;  
                                 end

                         3'b110:
                                begin 
                                    ALUControl = OR;
                                end 

                         3'b100:
                                begin 
                                     ALUControl =XOR;
                                end

                         3'b010:
                                begin 
                                     ALUControl = SLT;
                                end 
                         
                         3'b001:
                               begin 
                                    ALUControl = SLL;
                               end 

                         3'b101:
                               begin 
                                    if(funct7 == 7'b0100000)
                                    ALUControl =SRA;
                                    else
                                    ALUControl = SRL;
                               end
                                           
                        default: 
                               begin 
                                  ALUControl = ADD;
                               end             
                    
                     endcase
                end
                
                     default:
                             begin 
                                 ALUControl =ADD;
                             end

                            

        
      endcase
      


end







endmodule