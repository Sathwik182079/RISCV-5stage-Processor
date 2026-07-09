`timescale 1ns/1ps

module old_programcounter(

    input clk,
    input reset,
    input OldPCWrite,
    input [31:0] OldPC_in,
    output reg [31:0] OldPC_out

);

always @(posedge clk or posedge reset)
begin
    if(reset)
        OldPC_out <= 32'd0;
    else if(OldPCWrite)
        OldPC_out <= OldPC_in;
end

endmodule
