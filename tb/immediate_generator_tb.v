//=====================================================
// Module : Immediate Generator Testbench
// Project: 5-Stage Pipelined RISC-V Processor
// Author : T. Sathwik
// Date   :
//=====================================================

//-----------------------------------------------------
// Description:
// Testbench for Immediate Generator
//
// Verifies:
// • I-Type Immediate Generation
// • Load Immediate Generation
// • Store Immediate Generation
// • Branch Immediate Generation
// • Default Case
//-----------------------------------------------------

`timescale 1ns/1ps

module immediate_generator_tb;

reg  [31:0] instruction;
wire [31:0] immediate;

immediate_generator dut(

    .instruction(instruction),
    .immediate(immediate)

);

initial
begin

    $monitor(
    "Time=%0t Instruction=%h Immediate=%0d (0x%h)",
    $time,
    instruction,
    $signed(immediate),
    immediate
    );

end

initial
begin

    // I-Type (addi x1,x0,10)
    instruction = 32'h00A00093;
    #10;

    // Load (lw x2,8(x1))
    instruction = 32'h0080A103;
    #10;

    // Store (sw x2,12(x1))
    instruction = 32'h0020A623;
    #10;

    // Branch (beq x1,x2,16)
    instruction = 32'h00208863;
    #10;

    // Invalid Opcode
    instruction = 32'hFFFFFFFF;
    #10;

    $finish;

end

endmodule