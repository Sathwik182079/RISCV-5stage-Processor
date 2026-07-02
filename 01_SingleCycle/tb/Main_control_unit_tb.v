//=====================================================
// Module : Main Control Unit Testbench
// Project: 5-Stage Pipelined RISC-V Processor
// Author : T. Sathwik
// Date   :
//=====================================================

//-----------------------------------------------------
// Description:
// Testbench for Main Control Unit
//
// Verifies:
// • R-Type Control Signals
// • I-Type Control Signals
// • Load Control Signals
// • Store Control Signals
// • Branch Control Signals
// • Default Case
//-----------------------------------------------------

`timescale 1ns/1ps

module control_unit_tb;
reg [6:0] opcode;

wire RegWrite;
wire ALUSrc;
wire MemRead;
wire MemWrite;
wire Branch;
wire MemtoReg;
wire [1:0] ALUOp;

control_unit dut(

    .opcode(opcode),

    .RegWrite(RegWrite),
    .ALUSrc(ALUSrc),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .Branch(Branch),
    .MemtoReg(MemtoReg),
    .ALUOp(ALUOp)

);


initial
begin

    $monitor(
    "Time=%0t Opcode=%b RegWrite=%b ALUSrc=%b MemRead=%b MemWrite=%b Branch=%b MemtoReg=%b ALUOp=%b",
    $time,
    opcode,
    RegWrite,
    ALUSrc,
    MemRead,
    MemWrite,
    Branch,
    MemtoReg,
    ALUOp
    );

end

initial
begin

    // R-Type
    opcode = 7'b0110011;
    #10;

    // I-Type
    opcode = 7'b0010011;
    #10;

    // Load
    opcode = 7'b0000011;
    #10;

    // Store
    opcode = 7'b0100011;
    #10;

    // Branch
    opcode = 7'b1100011;
    #10;

    // Invalid Opcode
    opcode = 7'b1111111;
    #10;

    $finish;

end



endmodule 
