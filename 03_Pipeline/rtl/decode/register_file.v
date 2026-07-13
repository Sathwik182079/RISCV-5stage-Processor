//=====================================================
// Module : Register File
// Project: 5-Stage Pipelined RISC-V Processor
// Author : T. Sathwik
// Date   :
//=====================================================

//-----------------------------------------------------
// Description:
// Implements the 32 × 32-bit Register File for the
// RISC-V RV32I processor.
//
// Features:
// • 32 General Purpose Registers (x0–x31)
// • Two Combinational Read Ports
// • One Synchronous Write Port
// • Register x0 is Hardwired to Zero
//-----------------------------------------------------
 `timescale 1ns/1ps

module register_file (
    input clk,
    input write_enable,
    input  [4:0] rs1,
    input  [4:0] rs2,       
    input  [4:0] rd,
    input  [31:0] write_data,
    output reg [31:0] read_data1,
    output reg [31:0] read_data2
);

   reg [31:0] registers [0:31]; 
   integer i;

 initial
      begin
            for(i = 0; i < 32; i = i + 1)
           begin
               registers[i] = 32'd0;
           end
        end

   always @(*)

        begin
            read_data1 = registers[rs1]; 
            read_data2 = registers[rs2]; 
        end
 

 always @(posedge clk)
        begin 
            if (write_enable )

                begin 
                    if(rd!=5'd0)
                    begin
                    registers[rd] <= write_data;
                    end 
                end 

                registers[0] <= 32'd0; 
        end
















endmodule 