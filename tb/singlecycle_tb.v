//=====================================================
// Testbench : Single Cycle RISC-V Processor
// Project   : 5-Stage Pipelined RISC-V Processor
// Author    : T. Sathwik
//=====================================================

`timescale 1ns/1ps

module singlecycle_top_tb;

reg clk;
reg reset;

//-----------------------------------------------------
// DUT
//-----------------------------------------------------

singlecycle_top dut(

    .clk(clk),
    .reset(reset)

);

//-----------------------------------------------------
// Clock Generation (100 MHz)
//-----------------------------------------------------

initial
begin
    clk = 1'b0;

    forever #5 clk = ~clk;
end

//-----------------------------------------------------
// Reset Generation
//-----------------------------------------------------

initial
begin

    reset = 1'b1;

    #20;

    reset = 1'b0;

end

//-----------------------------------------------------
// Simulation Control
//-----------------------------------------------------

initial
begin

    #300;

    $finish;

end

//-----------------------------------------------------
// Monitor Signals
//-----------------------------------------------------

initial
begin

    $monitor(
        "Time=%0t  PC=%h  Instr=%h  ALU=%h",
        $time,
        dut.dp.program_counter,
        dut.dp.instruction,
        dut.dp.alu_result
    );

end

endmodule