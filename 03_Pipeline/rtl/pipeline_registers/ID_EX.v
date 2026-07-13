//=====================================================
// Module : ID/EX Pipeline Register
// Project: 5-Stage Pipelined RISC-V Processor
// Author : T. Sathwik
// Date   :
//=====================================================

`timescale 1ns/1ps

module ID_EX(

    input clk,
    input reset,
    input en,
    input clear,
    input [31:0] program_counter_in,
    input [31:0] program_counter_plus4_in,
    input [31:0] read_data1_in,
    input [31:0] read_data2_in,
    input [31:0] immediate_in,
    input [4:0] rs1_in,
    input [4:0] rs2_in,
    input [4:0] rd_in,
    input [2:0] funct3_in,
    input  [6:0] funct7_in,
    output reg [31:0] immediate_out,
    output reg [4:0] rs2_out,
    output reg [4:0] rd_out,
    output reg [2:0] funct3_out, 
    output reg [6:0] funct7_out,
    output reg [4:0] rs1_out,
    output reg [31:0] read_data1_out,
    output reg [31:0] read_data2_out,
    output reg [31:0] program_counter_plus4_out,
    output reg [31:0] program_counter_out,


     input RegWrite_in,
     output reg RegWrite_out,

     input MemRead_in,
     output reg MemRead_out,

     input MemWrite_in,
     output reg MemWrite_out,

     input ALUSrc_in,
     output reg ALUSrc_out,

     input Branch_in,
     output reg Branch_out,

     input Jump_in,
     output reg Jump_out,

     input jumpreg_in,
     output reg jumpreg_out,

     input [1:0] ResultSrc_in,
     output reg [1:0] ResultSrc_out,

     input [1:0] ALUOp_in,
     output reg [1:0] ALUOp_out
   


);

always @(posedge clk or posedge reset)
begin
    if(reset)
    begin
program_counter_out       <= 32'd0;
program_counter_plus4_out <= 32'd0;

read_data1_out            <= 32'd0;
read_data2_out            <= 32'd0;

immediate_out             <= 32'd0;

rs1_out                   <= 5'd0;
rs2_out                   <= 5'd0;
rd_out                    <= 5'd0;

funct3_out                <= 3'd0;
funct7_out                <= 7'b0;    

RegWrite_out  <= 1'b0;
MemRead_out   <= 1'b0;
MemWrite_out  <= 1'b0;

ALUSrc_out    <= 1'b0;

Branch_out    <= 1'b0;
Jump_out      <= 1'b0;
jumpreg_out   <= 1'b0;

ResultSrc_out <= 2'b00;
ALUOp_out     <= 2'b00;
    end

else if(clear)
begin
    program_counter_out       <= 32'd0;
    program_counter_plus4_out <= 32'd0;

    read_data1_out            <= 32'd0;
    read_data2_out            <= 32'd0;

    immediate_out             <= 32'd0;

    rs1_out                   <= 5'd0;
    rs2_out                   <= 5'd0;
    rd_out                    <= 5'd0;

    funct3_out                <= 3'd0;
    funct7_out                <= 7'b0;

    RegWrite_out  <= 1'b0;
    MemRead_out   <= 1'b0;
    MemWrite_out  <= 1'b0;

    ALUSrc_out    <= 1'b0;
    Branch_out    <= 1'b0;
    Jump_out      <= 1'b0;
    jumpreg_out   <= 1'b0;

    ResultSrc_out <= 2'b00;
    ALUOp_out     <= 2'b00;
end

else if(en)
begin
    program_counter_out       <= program_counter_in;
    program_counter_plus4_out <= program_counter_plus4_in;

    read_data1_out            <= read_data1_in;
    read_data2_out            <= read_data2_in;

    immediate_out             <= immediate_in;

    rs1_out                   <= rs1_in;
    rs2_out                   <= rs2_in;
    rd_out                    <= rd_in;

    funct3_out                <= funct3_in;
    funct7_out                <= funct7_in;

    RegWrite_out              <= RegWrite_in;
    MemRead_out               <= MemRead_in;
    MemWrite_out              <= MemWrite_in;

    ALUSrc_out                <= ALUSrc_in;

    Branch_out                <= Branch_in;
    Jump_out                  <= Jump_in;
    jumpreg_out               <= jumpreg_in;

    ResultSrc_out             <= ResultSrc_in;
    ALUOp_out                 <= ALUOp_in;
end
end

endmodule