`timescale 1ns/1ps

module top(
    input clk,
    input reset
);

// --- Control Wires ---
wire Program_Counter_Write;
wire RegWrite;
wire MemWrite;
wire IRWrite;
wire AWrite;
wire WriteDataWrite;
wire ALUOutWrite;
wire DataWrite;
wire AdrSrc;         

wire [1:0] ResultSrc;
wire [1:0] ALUSrcA;
wire [1:0] ALUSrcB;
wire [1:0] PCSrc;
wire [1:0] ALUOp;

// --- Datapath Status Wires ---
wire zero;
wire [6:0] opcode;
wire [31:0] instruction;

// --- Module Instantiations ---

controller controller1(
    .clk(clk),
    .reset(reset),

    .opcode(opcode),
    .zero(zero),
    // NOTE: funct3, funct7, and MemRead are permanently deleted from here

    .Program_Counter_Write(Program_Counter_Write),
    .IRWrite(IRWrite),
    .RegWrite(RegWrite),
    .MemWrite(MemWrite),

    .ResultSrc(ResultSrc),
    .ALUSrcA(ALUSrcA),
    .ALUSrcB(ALUSrcB),
    .PCSrc(PCSrc),

    .AWrite(AWrite),
    .WriteDataWrite(WriteDataWrite),
    .ALUOutWrite(ALUOutWrite),
    .DataWrite(DataWrite),

    .ALUOp(ALUOp),
    .AdrSrc(AdrSrc)      // ADDED: Controller now drives this
);

multi_cycle_datapath datapath1(
    .clk(clk),
    .reset(reset),

    .Program_Counter_Write(Program_Counter_Write),
    .RegWrite(RegWrite),
    .MemWrite(MemWrite),
    // NOTE: MemRead is permanently deleted from here

    .IRWrite(IRWrite),
    .AWrite(AWrite),
    .WriteDataWrite(WriteDataWrite),
    .ALUOutWrite(ALUOutWrite),
    .DataWrite(DataWrite),
    .AdrSrc(AdrSrc),     // ADDED: Datapath receives this for the memory mux

    .ResultSrc(ResultSrc),
    .ALUSrcA(ALUSrcA),
    .ALUSrcB(ALUSrcB),
    .PCSrc(PCSrc),
    .ALUOp(ALUOp),

    .zero(zero),
    .instruction(instruction),
    .opcode(opcode)
    // NOTE: funct3 and funct7 are completely handled internally now!
);

endmodule