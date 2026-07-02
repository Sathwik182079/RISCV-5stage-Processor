//=====================================================
// Module : Program Counter Testbench
// Project: 5-Stage Pipelined RISC-V Processor
// Author : T. Sathwik
// Date   :
//=====================================================

//-----------------------------------------------------
// Description:
// Testbench for Program Counter
//
// Verifies:
// • Reset Operation
// • PC Update
// • Sequential Operation
//-----------------------------------------------------

`timescale 1ns/1ps

module program_counter_tb;
   reg clk;
   reg reset;     
   reg [31:0] program_counter_next;
   wire [31:0] program_counter;

   program_counter dut (
      .clk(clk),
      .reset(reset),
      .program_counter_next(program_counter_next),
      .program_counter(program_counter)
   );

    
    initial 
      begin 
         clk = 1'b0;
         forever #5 clk  = ~clk;
      end 


      initial
begin

    $monitor(
        "Time=%0t Reset=%b Next_PC=%0d PC=%0d",
        $time,
        reset,
        program_counter_next,
        program_counter     
    );

end


initial
begin


    reset = 1'b1;
    program_counter_next = 32'd0;

    #10;


    reset = 1'b0;
    program_counter_next = 32'd4;

    #10;


    program_counter_next = 32'd8;

    #10;


    program_counter_next = 32'd12;

    #10;

    program_counter_next = 32'd16;

    #10;

    $finish;

end


endmodule