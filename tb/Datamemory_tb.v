//=====================================================
// Module : Data Memory Testbench
// Project: 5-Stage Pipelined RISC-V Processor
// Author : T. Sathwik
// Date   :
//=====================================================

//-----------------------------------------------------
// Description:
// Testbench for Data Memory
//
// Verifies:
// • Write Operation (Store)
// • Read Operation (Load)
// • Read Disable
// • Write Disable
//-----------------------------------------------------

`timescale 1ns/1ps

module Data_memory_tb;

reg clk;
reg MemRead;
reg MemWrite;
reg [31:0] Address;
reg [31:0] WriteData;

wire [31:0] ReadData;

//-----------------------------------------
// DUT
//-----------------------------------------

Data_memory dut(

    .clk(clk),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .Address(Address),
    .WriteData(WriteData),
    .ReadData(ReadData)

);

//-----------------------------------------
// Clock Generation
//-----------------------------------------

initial
begin
    clk = 1'b0;

    forever #5 clk = ~clk;
end

//-----------------------------------------
// Monitor
//-----------------------------------------

initial
begin

    $monitor(
    "Time=%0t MemRead=%b MemWrite=%b Address=%d WriteData=%d ReadData=%d",
    $time,
    MemRead,
    MemWrite,
    Address,
    WriteData,
    ReadData
    );

end

//-----------------------------------------
// Test Sequence
//-----------------------------------------

initial
begin

    //---------------------------------
    // Initialize
    //---------------------------------

    MemRead  = 0;
    MemWrite = 0;
    Address  = 0;
    WriteData = 0;

    #10;

    //---------------------------------
    // Store 25 at Address 8
    //---------------------------------

    Address   = 32'd8;
    WriteData = 32'd25;
    MemWrite  = 1;

    #10;

    MemWrite = 0;

    //---------------------------------
    // Read Address 8
    //---------------------------------

    MemRead = 1;

    #10;

    MemRead = 0;

    //---------------------------------
    // Store 100 at Address 12
    //---------------------------------

    Address   = 32'd12;
    WriteData = 32'd100;
    MemWrite  = 1;

    #10;

    MemWrite = 0;

    //---------------------------------
    // Read Address 12
    //---------------------------------

    MemRead = 1;

    #10;

    MemRead = 0;

    //---------------------------------
    // Read Disabled
    //---------------------------------

    Address = 32'd8;

    #10;

    //---------------------------------
    // Finish
    //---------------------------------

    $finish;

end

endmodule