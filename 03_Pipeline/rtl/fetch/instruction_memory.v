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
        memory[0] = 32'h00A00093;   // addi x1,x0,10
memory[1] = 32'h01400113;   // addi x2,x0,20

memory[2] = 32'h002081B3;   // add  x3,x1,x2

memory[3] = 32'h40110233;   // sub  x4,x2,x1

memory[4] = 32'h0020F2B3;   // and  x5,x1,x2

memory[5] = 32'h0020E333;   // or   x6,x1,x2

memory[6] = 32'h0020C3B3;   // xor  x7,x1,x2

memory[7] = 32'h0020A433;   // slt  x8,x1,x2

memory[8] = 32'h002094B3;   // sll  x9,x1,x2

memory[9] = 32'h0020D533;   // srl  x10,x1,x2

for(i=10;i<256;i=i+1)
    memory[i]=32'h00000013;
    end

    // Combinational Read (Word-Aligned Addressing)
    always @(*) begin 
        instruction = memory[program_counter[9:2]];
    end

endmodule
