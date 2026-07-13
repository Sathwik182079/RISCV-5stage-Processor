//=====================================================
// Module : MEM/WB Pipeline Register
// Project: 5-Stage Pipelined RISC-V Processor
// Author : T. Sathwik
//=====================================================

`timescale 1ns/1ps

module MEM_WB(

    input clk,
    input reset,
    input en,
    input clear,


    input [31:0] memory_data_in,
    input [31:0] ALU_result_in,
    input [31:0] program_counter_plus4_in,

    input [4:0] rd_in,


    input RegWrite_in,
    input [1:0] ResultSrc_in,


    output reg [31:0] memory_data_out,
    output reg [31:0] ALU_result_out,
    output reg [31:0] program_counter_plus4_out,

    output reg [4:0] rd_out,

    output reg RegWrite_out,
    output reg [1:0] ResultSrc_out

);

always @(posedge clk or posedge reset)
begin

    if(reset)
    begin
        memory_data_out            <= 32'd0;
        ALU_result_out             <= 32'd0;
        program_counter_plus4_out  <= 32'd0;
rd_out                     <= 5'd0;

RegWrite_out               <= 1'b0;
ResultSrc_out              <= 2'b00;
    end

    else if(clear)
    begin
        memory_data_out            <= 32'd0;
ALU_result_out             <= 32'd0;
program_counter_plus4_out  <= 32'd0;

rd_out                     <= 5'd0;

RegWrite_out               <= 1'b0;
ResultSrc_out              <= 2'b00;
    end

    else if(en)
    begin
   memory_data_out            <= memory_data_in;
  ALU_result_out             <= ALU_result_in;
  program_counter_plus4_out  <= program_counter_plus4_in;

   rd_out                     <= rd_in;
  RegWrite_out               <= RegWrite_in;
  ResultSrc_out              <= ResultSrc_in;
    end

end

endmodule