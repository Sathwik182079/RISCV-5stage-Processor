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

    initial begin
        for(i = 0; i < 32; i = i + 1) begin
            registers[i] = 32'd0;
        end
    end

    always @(*) begin
        if (write_enable && (rd == rs1) && (rd != 5'd0)) begin
            read_data1 = write_data;
        end else begin
            read_data1 = registers[rs1]; 
        end

        if (write_enable && (rd == rs2) && (rd != 5'd0)) begin
            read_data2 = write_data;
        end else begin
            read_data2 = registers[rs2]; 
        end
    end
 
    // Synchronous Write
    always @(posedge clk) begin 
        if (write_enable && rd != 5'd0) begin 
            registers[rd] <= write_data;
        end 
    end

endmodule