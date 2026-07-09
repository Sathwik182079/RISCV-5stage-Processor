`timescale 1ns/1ps

module A_register(

    input clk,
    input reset,
    input AWrite,
    input [31:0] A_in,
    output reg [31:0] A_out

);

always @(posedge clk or posedge reset)
begin
    if(reset)
        A_out <= 32'd0;
    else if(AWrite)
        A_out <= A_in;
end

endmodule
