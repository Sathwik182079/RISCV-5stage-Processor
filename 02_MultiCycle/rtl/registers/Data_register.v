`timescale 1ns/1ps

module Data_register(

    input clk,
    input reset,
    input DataWrite,
    input [31:0] Data_in,
    output reg [31:0] Data_out

);

always @(posedge clk or posedge reset)
begin
    if(reset)
        Data_out <= 32'd0;
    else if(DataWrite)
        Data_out <= Data_in;
end

endmodule
