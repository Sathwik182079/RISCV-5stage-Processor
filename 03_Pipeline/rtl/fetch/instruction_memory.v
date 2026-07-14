//=====================================================\
// Module : Instruction Memory (Verification Suite)
// Project: 5-Stage Pipelined RISC-V Processor
//=====================================================\

`timescale 1ns/1ps

module instruction_memory(
    input [31:0] program_counter,
    output reg [31:0] instruction
);

    reg [31:0] memory [0:255]; 
    integer i;

    initial begin
        // 1. Fill all memory with NOPs (addi x0, x0, 0) by default to prevent undefined behavior
        for(i = 0 ; i < 256; i = i + 1) begin
            memory[i] = 32'h00000013; 
        end

        // =========================================================================
        // THE HARRIS & HARRIS PIPELINE STRESS TEST
        // =========================================================================
        
        // --- TEST 1: Forwarding & Basic ALU Data Hazards ---
        memory[0]  = 32'h00A00093;  // addi x1, x0, 10      (x1 = 10)
        memory[1]  = 32'h01400113;  // addi x2, x0, 20      (x2 = 20)
        memory[2]  = 32'h002081B3;  // add  x3, x1, x2      (x3 = 30) -> EX HAZARD FORWARDING (x1, x2)
        memory[3]  = 32'h40118233;  // sub  x4, x3, x1      (x4 = 20) -> EX HAZARD (x3), MEM HAZARD (x1)

        // --- TEST 2: Branch & Control Hazard (Flush) Test ---
        memory[4]  = 32'h00220463;  // beq  x4, x2, +8      (20 == 20? TAKEN! Jumps to memory[6])
        memory[5]  = 32'h06300293;  // addi x5, x0, 99      (SHOULD BE FLUSHED - If x5=99, Flush Failed!)
        memory[6]  = 32'h03200293;  // addi x5, x0, 50      (x5 = 50) 

        // --- TEST 3: Memory & Load-Use Stall Test ---
        memory[7]  = 32'h06502223;  // sw   x5, 100(x0)     (Mem[100] = 50)
        memory[8]  = 32'h06402303;  // lw   x6, 100(x0)     (x6 = 50)
        memory[9]  = 32'h005303B3;  // add  x7, x6, x5      (x7 = 100) -> LOAD-USE STALL + FORWARDING REQUIRED!

        // --- TEST 4: Jump (JAL) & Flush Test ---
        memory[10] = 32'h0080046F;  // jal  x8, +8          (Jumps to memory[12], x8 saves PC+4)
        memory[11] = 32'h06300493;  // addi x9, x0, 99      (SHOULD BE FLUSHED - If x9=99, Jump Flush Failed!)
        memory[12] = 32'h06400493;  // addi x9, x0, 100     (x9 = 100)

        // --- TEST 5: Final Pass/Fail Verification ---
        memory[13] = 32'h00938463;  // beq  x7, x9, +8      (100 == 100? TAKEN! Jumps to memory[15])
        memory[14] = 32'hFFF00513;  // addi x10, x0, -1     (FAIL STATE: x10 = -1)
        memory[15] = 32'h00100513;  // addi x10, x0, 1      (SUCCESS STATE: x10 = 1)
    end

    // Combinational Read (Word-Aligned Addressing)
    always @(*) begin 
        instruction = memory[program_counter[9:2]];
    end

endmodule