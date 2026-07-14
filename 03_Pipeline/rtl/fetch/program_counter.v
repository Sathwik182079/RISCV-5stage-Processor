//=====================================================
// Module : Program Counter
// Project: 5-Stage Pipelined RISC-V Processor
// Author : T. Sathwik
// Date   :
//=====================================================

//-----------------------------------------------------
// Description:
// Implements the 32-bit Program Counter (PC)
// for the RISC-V RV32I Processor.
//
// Features:
// • Stores the address of the current instruction
// • Updates on every rising clock edge
// • Resets to address 0
//-----------------------------------------------------

`timescale 1ns/1ps

module program_counter(
     input clk,
     input reset,
     input en,
     input [31:0] program_counter_next ,
     output reg [31:0] program_counter
);


always @(posedge clk or posedge reset)
 begin
     if (reset )
      begin
         program_counter <= 32'd0;
      end
      else if(en)
begin
    program_counter <= program_counter_next;
end
     else 
       begin
        program_counter <= program_counter_next;
       end 
 end

 
endmodule
