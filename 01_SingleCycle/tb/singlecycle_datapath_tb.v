//=====================================================
// Module : Single Cycle Datapath Testbench
// Project: 5-Stage RISC-V Processor
// Author : T. Sathwik
//=====================================================

`timescale 1ns/1ps

module single_cycle_datapath_tb;

reg clk;
reg reset;

reg RegWrite;
reg MemRead;
reg MemWrite;
reg ALUSrc;
reg MemtoReg;
reg Branch;

reg [3:0] ALUControl;

//----------------------------------------
// DUT
//----------------------------------------

single_cycle_datapath dut(

    .clk(clk),
    .reset(reset),

    .RegWrite(RegWrite),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .ALUSrc(ALUSrc),
    .MemtoReg(MemtoReg),
    .Branch(Branch),

    .ALUControl(ALUControl)

);

//----------------------------------------
// Clock
//----------------------------------------

initial
begin
    clk = 0;
    forever #5 clk = ~clk;
end

//----------------------------------------
// Monitor
//----------------------------------------

initial
begin

$monitor(
"Time=%0t PC=%d Instruction=%h ALUResult=%d MemoryData=%d",
$time,
dut.program_counter,
dut.instruction,
dut.alu_result,
dut.memory_data
);

end

//----------------------------------------
// Test Sequence
//----------------------------------------

initial
begin

//------------------------------------------------
// Reset
//------------------------------------------------

reset = 1;

RegWrite = 0;
MemRead  = 0;
MemWrite = 0;
ALUSrc   = 0;
MemtoReg = 0;
Branch   = 0;
ALUControl = 4'b0000;

#20;

reset = 0;

//------------------------------------------------
// Execute ADD
//------------------------------------------------

RegWrite = 1;
ALUSrc   = 0;
MemRead  = 0;
MemWrite = 0;
MemtoReg = 0;
ALUControl = 4'b0000;

#40;

//------------------------------------------------
// Execute LOAD
//------------------------------------------------

RegWrite = 1;
ALUSrc   = 1;
MemRead  = 1;
MemWrite = 0;
MemtoReg = 1;
ALUControl = 4'b0000;

#40;

//------------------------------------------------
// Execute STORE
//------------------------------------------------

RegWrite = 0;
ALUSrc   = 1;
MemRead  = 0;
MemWrite = 1;
MemtoReg = 0;
ALUControl = 4'b0000;

#40;

//------------------------------------------------
// Finish
//------------------------------------------------

$finish;

end

endmodule