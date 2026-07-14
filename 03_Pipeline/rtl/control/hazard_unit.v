//=====================================================
// Module : Hazard Unit
// Project: 5-Stage Pipelined RISC-V Processor
// Author : T. Sathwik
//=====================================================

`timescale 1ns/1ps

module hazard_unit(


    input  [4:0] rs1_D,
    input  [4:0] rs2_D,
    input  [4:0] rs1_E,
    input  [4:0] rs2_E,
    input  [4:0] rd_E,
    input  [4:0] rd_M,
    input  [4:0] rd_W,
    input RegWrite_M,
    input RegWrite_W,
    input MemRead_E,
    input program_counter_src_E,
    input Jump_E,
    input JumpReg_E,

    output reg [1:0] ForwardA,
    output reg [1:0] ForwardB,

    output reg program_counter_Write,
    output reg IF_ID_Write,

    output reg Flush_IF_ID,
    output reg Flush_ID_EX

);

always @(*)
begin

    // Default Values

    ForwardA = 2'b00;
    ForwardB = 2'b00;

    program_counter_Write = 1'b1;
    IF_ID_Write           = 1'b1;

    Flush_IF_ID = 1'b0;
    Flush_ID_EX = 1'b0;

    // Forwarding Logic


    if (RegWrite_M &&
        (rd_M != 5'd0) &&
        (rd_M == rs1_E))
    begin
        ForwardA = 2'b10;
    end

    else if (RegWrite_W &&
             (rd_W != 5'd0) &&
             (rd_W == rs1_E))
    begin
        ForwardA = 2'b01;
    end


    if (RegWrite_M &&
        (rd_M != 5'd0) &&
        (rd_M == rs2_E))
    begin
        ForwardB = 2'b10;
    end

    else if (RegWrite_W &&
             (rd_W != 5'd0) &&
             (rd_W == rs2_E))
    begin
        ForwardB = 2'b01;
    end
    // Load-Use Hazard
    if (MemRead_E &&
        (rd_E != 5'd0) &&
        ((rd_E == rs1_D) || (rd_E == rs2_D)))
    begin

        program_counter_Write = 1'b0;
        IF_ID_Write           = 1'b0;
        Flush_ID_EX           = 1'b1;

    end

    // Control Hazard
    if (program_counter_src_E || Jump_E || JumpReg_E)
    begin

        Flush_IF_ID = 1'b1;
        Flush_ID_EX = 1'b1;

    end

end

endmodule