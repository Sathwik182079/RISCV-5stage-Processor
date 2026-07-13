//=====================================================
// Testbench : Pipeline Top
// Project    : 5-Stage Pipelined RISC-V Processor
// Author     : T. Sathwik
//=====================================================

`timescale 1ns/1ps

module pipeline_top_tb;

reg clk;
reg reset;

//=====================================================
// DUT
//=====================================================

pipeline_top DUT(

    .clk(clk),
    .reset(reset)

);

//=====================================================
// Clock Generation
//=====================================================

initial
begin
    clk = 1'b0;
end

always #5 clk = ~clk;

//=====================================================
// Reset Generation
//=====================================================

initial
begin

    reset = 1'b1;

    #20;

    reset = 1'b0;

end

//=====================================================
// Simulation Time
//=====================================================

initial
begin

    #500;

    $finish;

end

endmodule