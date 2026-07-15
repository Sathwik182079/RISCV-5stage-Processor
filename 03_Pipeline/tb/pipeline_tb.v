//=====================================================
// Module : Pipeline Testbench
// Project: 5-Stage Pipelined RISC-V Processor
// Author : T. Sathwik
//=====================================================

`timescale 1ns/1ps

module pipeline_tb;

reg clk;
reg reset;

//-----------------------------------------------------
// Instantiate DUT
//-----------------------------------------------------

pipeline_top DUT(
    .clk(clk),
    .reset(reset)
);

//-----------------------------------------------------
// Clock Generation
//-----------------------------------------------------

always #5 clk = ~clk;

//-----------------------------------------------------
// Monitor Register Writes
//-----------------------------------------------------

always @(posedge clk)
begin
    if(DUT.DATAPATH.RegWrite_WB)
    begin
        $display("%8t | PC = %08h | INST = %08h | RD = x%0d | DATA = %0d (0x%08h)",
                 $time,
                 DUT.DATAPATH.program_counter,
                 DUT.DATAPATH.instruction,
                 DUT.DATAPATH.rd_WB,
                 DUT.DATAPATH.write_data,
                 DUT.DATAPATH.write_data);
    end
end

//-----------------------------------------------------
// Test Sequence
//-----------------------------------------------------

integer i;

initial
begin

    $display("===========================================================");
    $display("        STARTING RISC-V PIPELINE SIMULATION");
    $display("===========================================================");

    clk   = 1'b0;
    reset = 1'b1;

    // Hold reset
    #20;
    reset = 1'b0;

    // Run simulation long enough
    #500;

    $display("");
    $display("===========================================================");
    $display("          FINAL REGISTER FILE CONTENTS");
    $display("===========================================================");

    for(i = 0; i < 32; i = i + 1)
    begin
        $display("x%-2d = %10d   (0x%08h)",
                 i,
                 DUT.DATAPATH.RF.registers[i],
                 DUT.DATAPATH.RF.registers[i]);
    end

    $display("===========================================================");

    //-------------------------------------------------
    // Harris & Harris PASS/FAIL Check
    //-------------------------------------------------

    if(DUT.DATAPATH.RF.registers[10] == 32'd1)
    begin
        $display("");
        $display("****************************************");
        $display("***        TEST PASSED               ***");
        $display("****************************************");
    end
    else
    begin
        $display("");
        $display("****************************************");
        $display("***        TEST FAILED               ***");
        $display("*** Expected x10 = 1                ***");
        $display("*** Actual   x10 = %0d              ***",
                 DUT.DATAPATH.RF.registers[10]);
        $display("****************************************");
    end

    $display("");
    $display("Simulation Finished.");

    $finish;

end

endmodule