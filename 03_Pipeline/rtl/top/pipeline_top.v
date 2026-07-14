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

    // ==========================================
    // Interconnect Wires
    // ==========================================
    
    // Wires: Datapath -> Control Unit
    wire [6:0] opcode;
    
    // Wires: Control Unit -> Datapath
    wire RegWrite, MemRead, MemWrite, ALUSrc, Branch, Jump, jumpreg;
    wire [1:0] ResultSrc, ALUOp;

    // Wires: Datapath -> Hazard Unit
    wire [4:0] rs1_D, rs2_D;
    wire [4:0] rs1_E, rs2_E, rd_E;
    wire MemRead_E, program_counter_src_E, Jump_E, JumpReg_E;
    wire [4:0] rd_M;
    wire RegWrite_M;
    wire [4:0] rd_W;
    wire RegWrite_W;

    // Wires: Hazard Unit -> Datapath
    wire [1:0] ForwardA, ForwardB;
    wire program_counter_Write, IF_ID_Write, Flush_IF_ID, Flush_ID_EX;

    // ==========================================
    // Module Instantiations
    // ==========================================

    // 1. The Execution Engine
    pipeline_datapath DATAPATH(
        .clk(clk),
        .reset(reset),
        
        // Control Inputs
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .Branch(Branch),
        .Jump(Jump),
        .jumpreg(jumpreg),
        .ResultSrc(ResultSrc),
        .ALUOp(ALUOp),

        // Hazard Inputs
        .ForwardA(ForwardA),
        .ForwardB(ForwardB),
        .program_counter_Write(program_counter_Write),
        .IF_ID_Write(IF_ID_Write),
        .Flush_IF_ID(Flush_IF_ID),
        .Flush_ID_EX(Flush_ID_EX),

        // Control Outputs
        .opcode(opcode),

        // Hazard Outputs
        .rs1_D(rs1_D),
        .rs2_D(rs2_D),
        .rs1_E(rs1_E),
        .rs2_E(rs2_E),
        .rd_E(rd_E),
        .MemRead_E(MemRead_E),
        .program_counter_src_E(program_counter_src_E),
        .Jump_E(Jump_E),
        .JumpReg_E(JumpReg_E),
        .rd_M(rd_M),
        .RegWrite_M(RegWrite_M),
        .rd_W(rd_W),
        .RegWrite_W(RegWrite_W)
    );

    // 2. The Brain
    control_unit CU(
        .opcode(opcode),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .result_src(ResultSrc),
        .Branch(Branch),
        .Jump(Jump),
        .jumpreg(jumpreg),
        .ALUOp(ALUOp)
    );

    // 3. The Traffic Cop
    hazard_unit HAZARD(
        .rs1_D(rs1_D),
        .rs2_D(rs2_D),
        .rs1_E(rs1_E),
        .rs2_E(rs2_E),
        .rd_E(rd_E),
        .rd_M(rd_M),
        .rd_W(rd_W),
        .RegWrite_M(RegWrite_M),
        .RegWrite_W(RegWrite_W),
        .MemRead_E(MemRead_E),
        .program_counter_src_E(program_counter_src_E),
        .Jump_E(Jump_E),
        .JumpReg_E(JumpReg_E),
        .ForwardA(ForwardA),
        .ForwardB(ForwardB),
        .program_counter_Write(program_counter_Write),
        .IF_ID_Write(IF_ID_Write),
        .Flush_IF_ID(Flush_IF_ID),
        .Flush_ID_EX(Flush_ID_EX)
    );

endmodule