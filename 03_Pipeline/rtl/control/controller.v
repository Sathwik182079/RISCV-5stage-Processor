//=====================================================
// Module : Main Control Unit
// Project: 5-Stage Pipelined RISC-V Processor
// Author : T. Sathwik
// Date   :
//=====================================================


`timescale 1ns/1ps



module control_unit(
        input [6:0] opcode,
        output reg RegWrite,
        output reg MemRead,
        output reg MemWrite,
        output reg ALUSrc,
        output reg [1:0] result_src,
        output reg Branch,
        output reg Jump,
        output reg jumpreg,
        output reg [1:0] ALUOp
     


);      

parameter R_TYPE = 7'b0110011;
parameter I_TYPE = 7'b0010011;
parameter LOAD = 7'b0000011;
parameter STORE = 7'b0100011;
parameter BRANCH = 7'b1100011;  
parameter JAL = 7'b1101111;
parameter JALR   = 7'b1100111;

always @(*)
 begin



    RegWrite = 1'b0;
    ALUSrc   = 1'b0;
    MemRead  = 1'b0;
    MemWrite = 1'b0;
    Branch   = 1'b0;
    result_src= 2'b00;
    ALUOp    = 2'b00;
    Jump     = 1'b0;
    jumpreg = 1'b0;


    case(opcode)

      
   R_TYPE:
begin
    RegWrite = 1'b1;
    ALUSrc   = 1'b0;
    MemRead  = 1'b0;
    MemWrite = 1'b0;
    Branch   = 1'b0;
    result_src = 2'b00;
    ALUOp    = 2'b10;
    Jump     = 1'b0;
    jumpreg = 1'b0;
end


LOAD:
begin
    RegWrite = 1'b1;
    ALUSrc   = 1'b1;
    MemRead  = 1'b1;
    MemWrite = 1'b0;
    Branch   = 1'b0;
    result_src = 2'b01;
    ALUOp    = 2'b00;
    Jump     = 1'b0;
    jumpreg  = 1'b0;
end

STORE:
begin
    RegWrite = 1'b0;
    ALUSrc   = 1'b1;
    MemRead  = 1'b0;
    MemWrite = 1'b1;
    Branch   = 1'b0;
    result_src  = 2'b00;
    ALUOp    = 2'b00;
    Jump     = 1'b0;
    jumpreg  = 1'b0;
end

BRANCH:
begin
    RegWrite = 1'b0;
    ALUSrc   = 1'b0;
    MemRead  = 1'b0;
    MemWrite = 1'b0;
    Branch   = 1'b1;
    result_src  = 2'b00;
    ALUOp    = 2'b01;
    Jump     = 1'b0;
    jumpreg  = 1'b0;
end

I_TYPE:
begin
    RegWrite = 1'b1;
    ALUSrc   = 1'b1;
    MemRead  = 1'b0;
    MemWrite = 1'b0;
    Branch   = 1'b0;
    result_src  = 2'b00;
    ALUOp    = 2'b10;
    Jump     = 1'b0;
    jumpreg  = 1'b0;
end 

JAL:
begin
    RegWrite = 1'b1;
    ALUSrc   = 1'b0;   
    MemRead  = 1'b0;
    MemWrite = 1'b0;
    Branch   = 1'b0;
    Jump     = 1'b1;
    result_src  = 2'b10;
    ALUOp    = 2'b00;
    jumpreg  = 1'b0;

end

JALR:
begin
    RegWrite    = 1'b1;
    ALUSrc      = 1'b1;
    MemRead     = 1'b0;
    MemWrite    = 1'b0;
    Branch      = 1'b0;
    Jump        = 1'b0;
    jumpreg     = 1'b1;
    result_src  = 2'b10;
    ALUOp = 2'b00;
end

default:

begin
    // Keep default values
end

 endcase 

end

endmodule