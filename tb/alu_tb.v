`timescale 1ns/1ps
module alu_tb;
      
      //inputs
      reg [31:0] operand_a;
      reg [31:0] operand_b;
      reg [3:0] ALU_control;
      //outputs
      wire zero;        
      wire [31:0] ALU_result;

        // Instantiate the ALU module   

        alu dut (
            .operand_a(operand_a),
            .operand_b(operand_b),
            .ALU_control(ALU_control),
            .zero(zero),
            .ALU_result(ALU_result)
        );
    
    initial 
     begin 
        $monitor("Time=%0t A=%0d B=%0d Ctrl=%b Result=%0d Zero=%b",
                   $time,
                operand_a,
                operand_b,
                ALU_control,
                ALU_result,         
                zero 
);
       //ADD
        operand_a   = 32'd20;
        operand_b   = 32'd10;
        ALU_control = 4'b0000;

       #10;
          //SUB
        operand_a   = 32'd20;
        operand_b   = 32'd20;
        ALU_control = 4'b0001;

        #10;
           //AND
        operand_a   = 32'd15;
        operand_b   = 32'd10;       
        ALU_control = 4'b0010;

        #10;
           //OR
        operand_a   = 32'd15;
        operand_b   = 32'd10;
        ALU_control = 4'b0011;

        #10;
           //XOR
        operand_a   = 32'd15;
        operand_b   = 32'd10;
        ALU_control = 4'b0100;
        
        #10;
           //SLL
        operand_a   = 32'd15;
        operand_b   = 32'd2;
        ALU_control = 4'b0101;

        #10;
           //SRL
        operand_a   = 32'd15;
        operand_b   = 32'd2;
        ALU_control = 4'b0110;

        #10;
           //SRA
        operand_a = -32'd16;
        operand_b = 32'd2;
        ALU_control = 4'b0111;

        #10;
           //SLT
        operand_a   = 32'd10;
        operand_b   = 32'd20;
        ALU_control = 4'b1000;

        #10;
           //SLT
        operand_a   = 32'd20;
        operand_b   = 32'd10;
        ALU_control = 4'b1000;

        #10;
           //Default case
        operand_a   = 32'd20;
        operand_b   = 32'd10;
        ALU_control = 4'b1111;
  
       #10;
     $finish;
     end
     
 
endmodule