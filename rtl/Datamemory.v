//=====================================================
// Module : Data Memory
// Project: 5-Stage Pipelined RISC-V Processor
// Author : T. Sathwik
// Date   :
//=====================================================

//-----------------------------------------------------
// Description:
// Implements the Data Memory for the
// RISC-V RV32I Processor.
//
// Features:
// • 256 Memory Locations
// • 32-bit Data Width
// • Combinational Read
// • Sequential Write
//-----------------------------------------------------

`timescale 1ns/1ps


module Data_memory(
      input clk,
      input MemRead,
      input MemWrite,
      input [31:0] Address,
      input [31:0] WriteData,
      output reg [31:0] ReadData

);
    
     reg [31:0] memory [0:255];

     always @(*)
      begin 
         if(MemRead)
          begin 
               ReadData = memory[Address[9:2]];
          end
          else
              begin 
                 ReadData = 32'b0;
              end 
      end 



    always@(posedge clk)
       begin 
            if(MemWrite)
                begin 
                     memory [Address[9:2]] <= WriteData;
                end
           
       end

    
     
 


 

endmodule