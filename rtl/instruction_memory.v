//=====================================================
// Module : Instruction Memory
// Project: 5-Stage Pipelined RISC-V Processor
// Author : T. Sathwik
// Date   :
//=====================================================

//-----------------------------------------------------
// Description:
// Implements the Instruction Memory for the
// RISC-V RV32I Processor.
//
// Features:
// • Stores 32-bit instructions
// • 256 Instruction Memory Locations
// • Combinational Read Operation
// • Word-Aligned Addressing (PC[31:2])
//-----------------------------------------------------

`timescale 1ns/1ps

module instruction_memory(
    input [31:0] program_counter ,
    output reg [31:0] instruction

);

    reg [31:0] memory [0:255]; 

initial
begin

    memory[0] = 32'h00A00093;   // addi x1,x0,10
    memory[1] = 32'h01400113;   // addi x2,x0,20
    memory[2] = 32'h002081B3;   // add x3,x1,x2
    memory[3] = 32'h40118233;   // sub x4,x3,x1

end


always @(*)
   begin 
      instruction = memory[program_counter[31:2]];
   end

endmodule
