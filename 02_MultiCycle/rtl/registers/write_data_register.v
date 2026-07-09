`timescale 1ns/1ps

module write_data_register(

    input clk,
    input reset,
    input WriteDataWrite,
    input [31:0] WriteData_in,
    output reg [31:0] WriteData_out

);

always @(posedge clk or posedge reset)
begin
    if(reset)
        WriteData_out <= 32'd0;
    else if(WriteDataWrite)
        WriteData_out <= WriteData_in;
end

endmodule
