module IF_ID(
    input clk,
    input reset,
    input en,
    input clear,

    input [31:0] program_counter_in,
    input [31:0] instruction_in ,
    input [31:0] program_counter_plus4_in,

    output  reg [31:0] program_counter_out,
    output  reg [31:0] instruction_out ,
    output  reg  [31:0] program_counter_plus4_out
);

always @(posedge clk or posedge reset)

      begin
        
    
       if(reset) 
       begin
          program_counter_out <= 32'd0;
          instruction_out <= 32'd0;
          program_counter_plus4_out <= 32'd0;
       end 

       else if (clear)
       begin
          program_counter_out <= 32'd0;
          instruction_out <= 32'h00000013;
          program_counter_plus4_out <= 32'd0;
       end

       else if (en)
       begin
          program_counter_out <= program_counter_in;
          instruction_out <= instruction_in ;
          program_counter_plus4_out <= program_counter_plus4_in;
       end 

      end 

endmodule
