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
 integer i;
initial
begin
//memory[0] = 32'h00A00093;   // addi x1,x0,10
//memory[1] = 32'h00102023;   // sw x1,0(x0)
//memory[2] = 32'h00002103;   // lw x2,0(x0)
//memory[3] = 32'h00000013;   // nop


   // memory[0] = 32'h00A00093;   // addi x1,x0,10
   // memory[1] = 32'h00A00113;   // addi x2,x0,10
   // memory[2] = 32'h00208463;   // beq x1,x2,+8
  //  memory[3] = 32'h00500193;   // addi x3,x0,5   (should be skipped)
    //memory[4] = 32'h01400213;   // addi x4,x0,20


    //memory[0] = 32'h008002EF;   // jal x5,+8
    //memory[1] = 32'h00A00093;   // addi x1,x0,10 (should be skipped)
   // memory[2] = 32'h01400113;   // addi x2,x0,20

    memory[0] = 32'h00C00093;   // addi x1,x0,12
    memory[1] = 32'h000082E7;   // jalr x5,0(x1)
    memory[2] = 32'h01400113;   // addi x2,x0,20 (should skip)
    memory[3] = 32'h01E00193;   // addi x3,x0,30

          for(i = 4 ; i < 256; i = i + 1)
        memory[i] = 32'h00000013;   // addi x0,x0,0 (NOP)


end


always @(*)
   begin 
      instruction = memory[program_counter[9:2]];
   end

endmodule
