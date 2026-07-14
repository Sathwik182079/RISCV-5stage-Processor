`timescale 1ns / 1ps

module tb_pipeline_advanced();

    reg clk;
    reg reset;

    // Instantiate Top Level
    pipeline_top uut (
        .clk(clk),
        .reset(reset)
    );

    // Generate 100MHz Clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Main Simulation Block
    initial begin
        // 1. Setup Waveform Dumping
        $dumpfile("pipeline_waveform.vcd");
        $dumpvars(0, tb_pipeline_advanced);

        // 2. Setup Console Log Header
        $display("===========================================================");
        $display("   STARTING RISC-V PIPELINE SIMULATION");
        $display("===========================================================");
        $display("  TIME | FETCH PC | INSTRUCTION | DEST REG | WRITTEN VALUE");
        $display("-----------------------------------------------------------");

        // 3. Reset the Processor
        reset = 1;
        #15; 
        reset = 0;

        // 4. Let it run for 200 nanoseconds
        #200; 
        
        // 5. Print Final Register Status
        $display("===========================================================");
        $display("   SIMULATION COMPLETE - FINAL REGISTER STATES");
        $display("===========================================================");
        $display(" x1 = %0d", uut.DATAPATH.RF.registers[1]);
        $display(" x2 = %0d", uut.DATAPATH.RF.registers[2]);
        $display(" x3 = %0d", uut.DATAPATH.RF.registers[3]);
        $display(" x4 = %0d", uut.DATAPATH.RF.registers[4]);
        $display(" x5 = %0d", uut.DATAPATH.RF.registers[5]);
        $display("===========================================================");
        
        $finish;
    end

    // -----------------------------------------------------------
    // The "Spy" Block: Watch for successful Register Writes!
    // -----------------------------------------------------------
    always @(posedge clk) begin
        // If Writeback stage is enabled, and we aren't writing to x0...
        if (!reset && uut.DATAPATH.RegWrite_WB && uut.DATAPATH.rd_WB != 5'd0) begin
            $display("%6t | %8h |   %8h  |    x%0d    | %0d",
                     $time, 
                     uut.DATAPATH.program_counter, // What is currently being fetched
                     uut.DATAPATH.instruction,     // What is currently being fetched
                     uut.DATAPATH.rd_WB,           // The register being written
                     uut.DATAPATH.write_data       // The math/memory data being written
            );
        end
    end

endmodule