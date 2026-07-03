`timescale 1ns/1ps

module singlecycle_top_tb;

reg clk;
reg reset;

//-----------------------------------------------------
// DUT
//-----------------------------------------------------

singlecycle_top dut(
    .clk(clk),
    .reset(reset)
);

//-----------------------------------------------------
// Clock Generation
//-----------------------------------------------------

initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
end

//-----------------------------------------------------
// Reset Generation
//-----------------------------------------------------

initial begin
    reset = 1'b1;
    #20;
    reset = 1'b0;
end

//-----------------------------------------------------
// Monitor
//-----------------------------------------------------

always @(posedge clk)
begin
    $display("Time=%0t PC=%h Instr=%h ALU=%h RD=%0d WD=%h WE=%b X1=%h X2=%h X3=%h X4=%h",
             $time,
             dut.dp.program_counter,
             dut.dp.instruction,
             dut.dp.alu_result,
             dut.dp.rd,
             dut.dp.write_back_data,
             dut.RegWrite,
             dut.dp.rf.registers[1],
             dut.dp.rf.registers[2],
             dut.dp.rf.registers[3],
             dut.dp.rf.registers[4]);
end

//-----------------------------------------------------
// Simulation End
//-----------------------------------------------------

initial begin
    #300;
    $finish;
end

endmodule