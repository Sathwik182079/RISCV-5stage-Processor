`timescale 1ns/1ps

module instruction_register(

    input clk,
    input reset,
    input IRWrite,
    input [31:0] instruction_in,
    output reg [31:0] instruction_out

);

always @(posedge clk or posedge reset)
begin
    if(reset)
        instruction_out <= 32'd0;
    else if(IRWrite)
        instruction_out <= instruction_in;
end

endmodule
