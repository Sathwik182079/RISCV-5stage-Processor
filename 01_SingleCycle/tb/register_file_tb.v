//=====================================================
// Module : Register File Testbench
// Project: 5-Stage Pipelined RISC-V Processor
// Author : T. Sathwik
// Date   :
//=====================================================

//-----------------------------------------------------
// Description:
// Testbench for Register File
//
// Verifies:
// • Register Write
// • Register Read
// • x0 Hardwired to Zero
//-----------------------------------------------------

`timescale 1ns/1ps

module register_file_tb;
  
  
reg clk;
reg write_enable;
reg [4:0] rs1;
reg [4:0] rs2;
reg [4:0] rd;
reg [31:0] write_data;

wire [31:0] read_data1;
wire [31:0] read_data2;


register_file dut(
    .clk(clk),
    .write_enable(write_enable),
    .rs1(rs1),              
    .rs2(rs2),
    .rd(rd),
    .write_data(write_data),
    .read_data1(read_data1),
    .read_data2(read_data2)
);

initial 
       begin
           clk=1'b0;
           forever #5 clk=~clk;

        end

initial
begin

    $monitor(
        "Time=%0t WE=%b rd=%0d WD=%0d rs1=%0d RD1=%0d rs2=%0d RD2=%0d",
        $time,
        write_enable,
        rd,
        write_data,
        rs1,
        read_data1,
        rs2,
        read_data2
    );
end


initial

   
   begin

    write_enable = 0;

    rs1 = 0;
    rs2 = 0;
    rd  = 0;

    write_data = 0;

    #10;
    // Write x1 = 20

    write_enable = 1;
    rd = 5'd1;
    write_data = 32'd20;

    #10;
   // read x1
     
      write_enable =0;
      rs1 = 5'd1;

    #10;
    // write  x2
       write_enable =1;
       rd = 5'd2;
       write_data = 32'd10;

    #10 ;    
    // read x2
       write_enable =0;
       rs2 = 5'd2;

    #10;
// Write x5 = 100
write_enable = 1;
rd = 5'd5;
write_data = 32'd100;

#10;

// Read x5
write_enable = 0;
rs1 = 5'd5;

#10;
// Try Writing x0 = 999
write_enable = 1;
rd = 5'd0;
write_data = 32'd999;

#10;
// Read x0
write_enable = 0;
rs1 = 5'd0;

#10;
// Finish Simulation

#10;

$finish;

end
    







endmodule