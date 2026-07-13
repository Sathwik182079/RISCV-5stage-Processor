//=====================================================
// Module : EX/MEM Pipeline Register
// Project: 5-Stage Pipelined RISC-V Processor
// Author : T. Sathwik
// Date   :
//=====================================================

`timescale 1ns/1ps

module EX_MEM(

    input clk,
    input reset,
    input en,
    input clear,

    //=================================================
    // Data Inputs
    //=================================================

    input  [31:0] ALU_result_in,
    input  [31:0] write_data_in,
    input  [31:0] branch_target_in,
    input  [31:0] program_counter_plus4_in,

    input         zero_in,
    input  [4:0]  rd_in,

 

    input         RegWrite_in,
    input         MemRead_in,
    input         MemWrite_in,
    input  [1:0]  ResultSrc_in,

   
    output reg [31:0] ALU_result_out,
    output reg [31:0] write_data_out,
    output reg [31:0] branch_target_out,
    output reg [31:0] program_counter_plus4_out,

    output reg        zero_out,
    output reg [4:0]  rd_out,

    output reg        RegWrite_out,
    output reg        MemRead_out,
    output reg        MemWrite_out,
    output reg [1:0]  ResultSrc_out

);

always @(posedge clk or posedge reset)
begin
    
    if(reset)
begin

    ALU_result_out     <= 32'd0;
    write_data_out     <= 32'd0;
    branch_target_out  <= 32'd0;
    program_counter_plus4_out <= 32'd0;

    rd_out             <= 5'd0;

    zero_out           <= 1'b0;

    RegWrite_out       <= 1'b0;
    MemRead_out        <= 1'b0;
    MemWrite_out       <= 1'b0;

    ResultSrc_out      <= 2'b00;

end

else if(clear)
begin

    ALU_result_out     <= 32'd0;
    write_data_out     <= 32'd0;
    branch_target_out  <= 32'd0;
    program_counter_plus4_out <= 32'd0;

    rd_out             <= 5'd0;

    zero_out           <= 1'b0;

    RegWrite_out       <= 1'b0;
    MemRead_out        <= 1'b0;
    MemWrite_out       <= 1'b0;

    ResultSrc_out      <= 2'b00;

end

else if(en)
begin

    ALU_result_out            <= ALU_result_in;
    write_data_out            <= write_data_in;
    branch_target_out         <= branch_target_in;
    program_counter_plus4_out <= program_counter_plus4_in;

    zero_out                  <= zero_in;
    rd_out                    <= rd_in;

    RegWrite_out              <= RegWrite_in;
    MemRead_out               <= MemRead_in;
    MemWrite_out              <= MemWrite_in;

    ResultSrc_out             <= ResultSrc_in;

end

end 

endmodule