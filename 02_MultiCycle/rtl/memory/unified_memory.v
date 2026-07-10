`timescale 1ns/1ps

module memory(
    input clk,
    input MemWrite,
    input [31:0] Address,
    input [31:0] WriteData,
    output reg [31:0] ReadData
);
    reg [31:0] ram [0:255]; 

    integer i;
    initial
     begin
        for ( i = 0; i < 256; i = i + 1) begin
            ram[i] = 32'd0;
        end

        // --- I-Type & R-Type Arithmetic ---
        ram[0]  = 32'h00A00093; // PC = 00: addi x1, x0, 10    (x1 = 10)
        ram[1]  = 32'h01400113; // PC = 04: addi x2, x0, 20    (x2 = 20)
        ram[2]  = 32'h002081B3; // PC = 08: add  x3, x1, x2    (x3 = 10 + 20 = 30)
        ram[3]  = 32'h40110233; // PC = 12: sub  x4, x2, x1    (x4 = 20 - 10 = 10)

        // --- Memory Access (Load/Store) ---
        ram[4]  = 32'h06302223; // PC = 16: sw   x3, 100(x0)   (Store 30 at memory address 100)
        ram[5]  = 32'h06402283; // PC = 20: lw   x5, 100(x0)   (Load 30 back into x5)

        // --- Branching (BEQ) ---
        ram[6]  = 32'h00518463; // PC = 24: beq  x3, x5, +8    (30 == 30, so jump to PC = 32)
        ram[7]  = 32'h06300313; // PC = 28: addi x6, x0, 99    (TRAP: If branch fails, x6 becomes 99)

        // --- J-Type (JAL) ---
        ram[8]  = 32'h00C003EF; // PC = 32: jal  x7, +12       (Jump to PC = 44, save Return Addr 36 in x7)
        ram[9]  = 32'h05800313; // PC = 36: addi x6, x0, 88    (TRAP: Should be skipped!)
        ram[10] = 32'h04D00313; // PC = 40: addi x6, x0, 77    (TRAP: Should be skipped!)

        // --- J-Type (JALR) ---
        ram[11] = 32'h03400413; // PC = 44: addi x8, x0, 52    (Set up JALR target: x8 = 52)
        ram[12] = 32'h000404E7; // PC = 48: jalr x9, 0(x8)     (Jump to PC = 52, save Return Addr 52 in x9)

        // --- Final ALU Test & End ---
        ram[13] = 32'h0041F533; // PC = 52: and  x10, x3, x4   (x10 = 30 & 10 = 10)
        ram[14] = 32'h00000063; // PC = 56: beq  x0, x0, 0     (Infinite loop to trap PC and end program)
    end

    // Combinational Read
    always @(*) begin 
        ReadData = ram[Address[9:2]]; 
    end 

    // Synchronous Write
    always @(posedge clk) begin 
        if(MemWrite) begin 
             ram[Address[9:2]] <= WriteData;
        end
    end
endmodule



