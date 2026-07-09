`timescale 1ns / 1ps

module multicycle_tb();

    // 1. Declare Testbench Signals
    reg clk;
    reg reset;

    // 2. Instantiate the Top Module (Device Under Test)
    top dut (
        .clk(clk),
        .reset(reset)
    );

    // 3. Generate the Clock (10ns period -> 100 MHz)
    always begin
        #5 clk = ~clk;
    end

    // 4. Test Sequence
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1; // Hold processor in reset
        
        // Display a message in the console
        $display("Starting Multi-Cycle RISC-V Simulation...");

        // Wait a few clock cycles, then release reset
        #20;
        reset = 0; 
        $display("Reset released. Processor is running.");

        // Let the processor run for enough time to execute your program.
        // Adjust this number based on how many instructions you have in memory.
        #1000; 

        // End the simulation
        $display("Simulation complete.");
        $finish;
    end

    // Optional: Monitor the Program Counter to watch the processor step through code
    initial begin
        // We use $monitor to print to the console every time the PC changes.
        // Note: You might need to adjust the hierarchical path depending on your module names.
        $monitor("Time: %0t | PC: %h | Instruction: %h", 
                 $time, 
                 dut.datapath1.program_counter, 
                 dut.datapath1.instruction);
    end

endmodule
