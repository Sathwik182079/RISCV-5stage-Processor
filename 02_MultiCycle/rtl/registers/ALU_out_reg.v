`timescale 1ns/1ps

module ALU_out_reg(

    input clk,
    input reset,
    input ALUOutWrite,
    input [31:0] ALUOut_in,
    output reg [31:0] ALUOut_out

);

always @(posedge clk or posedge reset)
begin
    if(reset)
        ALUOut_out <= 32'd0;
    else if(ALUOutWrite)
        ALUOut_out <= ALUOut_in;
end

endmodule
