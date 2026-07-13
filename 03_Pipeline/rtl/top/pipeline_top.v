//=====================================================
// Module : Pipeline Top
// Project: 5-Stage Pipelined RISC-V Processor
// Author : T. Sathwik
//=====================================================

`timescale 1ns/1ps

module pipeline_top(

    input clk,
    input reset

);

pipeline_datapath DATAPATH(

    .clk(clk),
    .reset(reset)

);

endmodule