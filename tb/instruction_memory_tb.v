//=====================================================
// Module : Instruction Memory Testbench
// Project: 5-Stage Pipelined RISC-V Processor
// Author : T. Sathwik
// Date   :
//=====================================================

//-----------------------------------------------------
// Description:
// Testbench for Instruction Memory
//
// Verifies:
// • Instruction Fetch at Address 0
// • Instruction Fetch at Address 4
// • Instruction Fetch at Address 8
// • Instruction Fetch at Address 12
//-----------------------------------------------------

`timescale 1ns/1ps
module instruction_memory_tb;
reg  [31:0] program_counter;
wire [31:0] instruction;
instruction_memory dut(

    .program_counter(program_counter),
    .instruction(instruction)

);

initial
begin

    $monitor(
        "Time=%0t PC=%0d Instruction=%h",
        $time,
        program_counter,
        instruction
    );

end

initial
begin

    program_counter = 32'd0;

    #10;

    program_counter = 32'd4;

    #10;

    program_counter = 32'd8;

    #10;

    program_counter = 32'd12;

    #10;

    $finish;

end

endmodule