//=====================================================
// Module : Controller
// Project: Multi-Cycle RISC-V Processor
// Author : T. Sathwik
//=====================================================

`timescale 1ns/1ps

module controller(

    input clk,
    input reset,

    input [6:0] opcode,
    input zero,

    output reg Program_Counter_Write,
    output reg IRWrite,
    output reg RegWrite,
    output reg MemWrite,


    output reg [1:0] ResultSrc,
    output reg [1:0] ALUSrcA,
    output reg [1:0] ALUSrcB,
    output reg [1:0] PCSrc,
    output reg AWrite,
    output reg WriteDataWrite, 
    output reg ALUOutWrite,
    output reg DataWrite,  
    output reg [1:0] ALUOp,
    output reg AdrSrc
);




localparam FETCH      = 4'd0;
localparam DECODE     = 4'd1;
localparam MEMADR     = 4'd2;
localparam MEMREAD    = 4'd3;
localparam MEMWB      = 4'd4;
localparam MEMWRITE   = 4'd5;
localparam EXECUTER   = 4'd6;
localparam EXECUTEI   = 4'd7;
localparam ALUWB      = 4'd8;
localparam BRANCH     = 4'd9;
localparam JAL        = 4'd10;
localparam JALR       = 4'd11;
localparam JALR_WB    = 4'd12;

reg [3:0] current_state;
reg [3:0] next_state;

always @(posedge clk or posedge reset)
begin

    if(reset)
        current_state <= FETCH;

    else
        current_state <= next_state;

end


always @(*)
begin

    next_state = current_state;

    case(current_state)

        FETCH:
        begin
            next_state = DECODE;
        end

        DECODE:
        begin

       case(opcode)
        
        7'b0000011:      // Load (lw)
            next_state = MEMADR;

        7'b0100011:      // Store (sw)
            next_state = MEMADR;

        7'b0110011:      // R-Type
            next_state = EXECUTER;

        7'b0010011:      // I-Type
            next_state = EXECUTEI;

        7'b1100011:      // Branch
            next_state = BRANCH;

        7'b1101111:      // JAL
            next_state = JAL;

       7'b1100111:  //jalr
        next_state = JALR;

        default:
            next_state = FETCH;

       endcase

        end


        MEMADR:
        begin
        if(opcode == 7'b0000011)

        next_state = MEMREAD;

         else
        next_state = MEMWRITE;

        end

        MEMREAD:
        begin     
        next_state = MEMWB;
        end

        MEMWB:
        begin
        next_state = FETCH;
        end

        MEMWRITE:
        begin
            next_state = FETCH;
        end

        EXECUTER:
        begin
          next_state = ALUWB;
        end

        EXECUTEI:
        begin
              next_state = ALUWB;
        end

        ALUWB:
        begin
            next_state = FETCH;
        end

        BRANCH:
        begin
            next_state = FETCH;
        end

        JAL:
        begin
              next_state = FETCH;
        end
        JALR:
        begin
            next_state = JALR_WB; 
        end
        
        JALR_WB:
        begin
            next_state = FETCH;
        end
        default :
          begin
          end 
          
    endcase

end



always @(*)

 begin

    // Default values
    Program_Counter_Write    = 1'b0;
    IRWrite    = 1'b0;
    RegWrite   = 1'b0;
    MemWrite   = 1'b0;
  
    ResultSrc  = 2'b00;
    ALUSrcA    = 2'b00;
    ALUSrcB    = 2'b00;
    PCSrc      = 2'b00;
    AdrSrc = 1'b0; 
    ALUOp = 2'b00;
    AWrite         = 1'b0;
    WriteDataWrite = 1'b0;
    ALUOutWrite    = 1'b0;
    DataWrite      = 1'b0;

    case(current_state)

        FETCH:
         begin 
             Program_Counter_Write    = 1'b1;
             IRWrite    = 1'b1;
             ALUSrcA    = 2'b00;
             ALUSrcB    = 2'b10;
             PCSrc      = 2'b00;
             ALUOp = 2'b00;
             AdrSrc = 1'b0;

        end

        DECODE: 
        begin
            AWrite         = 1'b1;
            WriteDataWrite = 1'b1;
            ALUSrcA        = 2'b01;     
            ALUSrcB        = 2'b01;   
            ALUOp = 2'b00;
           ALUOutWrite    = 1'b1;

        end

        MEMADR:
         begin
           ALUSrcA     = 2'b10;      
           ALUSrcB     = 2'b01;      
           ALUOp = 2'b00;
           ALUOutWrite = 1'b1;
        end

        MEMREAD: 
        begin
           AdrSrc = 1'b1; 
           DataWrite = 1'b1;
        end

        MEMWB:
         begin
          RegWrite = 1'b1;
          ResultSrc = 2'b01;
        end

        MEMWRITE:
        begin
          AdrSrc = 1'b1; 
          MemWrite = 1'b1;
        end

        EXECUTER:
        begin
        ALUSrcA = 2'b10;
        ALUSrcB = 2'b00;
        ALUOp = 2'b10;
        ALUOutWrite = 1'b1;
        end

        EXECUTEI:
      begin
      ALUSrcA = 2'b10;
      ALUSrcB = 2'b01;
      ALUOp = 2'b10; 
      ALUOutWrite = 1'b1;
      end

      ALUWB:
       begin
       RegWrite = 1'b1;  
       ResultSrc = 2'b00;
      end

      BRANCH:
       begin
    ALUSrcA = 2'b10;
    ALUSrcB = 2'b00;
    ALUOp = 2'b01; 
    if(zero)
    begin
        Program_Counter_Write = 1'b1;
        PCSrc = 2'b01;
    end
       end

     JAL:
        begin
           
            Program_Counter_Write = 1'b1;
            PCSrc = 2'b01; 
            RegWrite = 1'b1;
            ALUSrcA = 2'b01; 
            ALUSrcB = 2'b10; 
            ALUOp   = 2'b00; 
            ResultSrc = 2'b10; 
        end

        JALR:
        begin
          
            ALUSrcA = 2'b10;  
            ALUSrcB = 2'b01;  
            ALUOp   = 2'b00; 
            ALUOutWrite = 1'b1; 
        end
        
        JALR_WB:
        begin
         
            Program_Counter_Write = 1'b1;
            PCSrc = 2'b01;
            RegWrite = 1'b1;
            ALUSrcA = 2'b01; 
            ALUSrcB = 2'b10; 
            ALUOp   = 2'b00; 
            ResultSrc = 2'b10; 
        end


        default:
        begin 
        end 
    endcase

end



endmodule
