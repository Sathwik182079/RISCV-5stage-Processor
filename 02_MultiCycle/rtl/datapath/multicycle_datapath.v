

module multi_cycle_datapath(

input clk,
input reset,


input Program_Counter_Write,

input RegWrite,

input MemWrite,

input IRWrite,
input AWrite,
input WriteDataWrite,
input ALUOutWrite,
input DataWrite,
input AdrSrc,
input [1:0] ResultSrc,
input [1:0] ALUSrcA,
input [1:0] ALUSrcB,
input [1:0] PCSrc,
input [1:0] ALUOp,


output zero,
output [31:0] instruction,

output [6:0] opcode




);


wire [3:0] ALUControl;
wire [31:0] Result;
wire [31:0] IR;
wire [31:0] A;
wire [31:0] WriteData;
wire [31:0] ALUOut;
wire [31:0] Data;
wire [31:0] old_program_counter;
wire [31:0] MemAdr;
wire [31:0] program_counter ;
wire [31:0] program_counter_next;
wire [31:0] immediate;
wire [31:0] read_data_1 ;
wire [31:0] read_data_2 ;
wire [31:0] alu_input_2 ;
wire [31:0] alu_result ;
wire [31:0] memory_data ;

assign opcode = IR[6:0];
assign instruction = IR;



assign program_counter_next =  (PCSrc == 2'b00) ? alu_result :
                                 (PCSrc == 2'b01) ? ALUOut :
                                         alu_result;
assign MemAdr = (AdrSrc == 1'b0) ? program_counter : ALUOut;


wire [31:0] ALU_operand_A;
assign ALU_operand_A =
        (ALUSrcA == 2'b00) ? program_counter :
        (ALUSrcA == 2'b01) ? old_program_counter :
                             A;



assign alu_input_2 =
        (ALUSrcB == 2'b00) ? WriteData :
        (ALUSrcB == 2'b01) ? immediate :
        (ALUSrcB == 2'b10) ? 32'd4 :
                             immediate;
                             
assign Result =
        (ResultSrc == 2'b00) ? ALUOut :
        (ResultSrc == 2'b01) ? Data :
        (ResultSrc == 2'b10) ? alu_result : 
                               ALUOut;



program_counter program_counter1 (

    .clk(clk),
    .reset(reset),

    .Program_Counter_Write(Program_Counter_Write),

    .program_counter_next(program_counter_next),
    .program_counter(program_counter)

);




register_file rf(
  

    .clk(clk),

    .write_enable(RegWrite),
    .rs1(IR[19:15]),
    .rs2(IR[24:20]),
    .rd(IR[11:7]),
    .write_data(Result),
    .read_data1(read_data_1),
    .read_data2(read_data_2)

);

immediate_generator ig(

    .instruction(IR),
    .immediate(immediate)

);

    memory unified_memory(
    .clk(clk),
    .MemWrite(MemWrite),
    .Address(MemAdr),
    .WriteData(WriteData), 
      .ReadData(memory_data) );
  

alu alu1(

   .operand_a(ALU_operand_A),
    .operand_b(alu_input_2),

    .ALU_control(ALUControl),

    .zero(zero),
    .ALU_result(alu_result)

);

alu_control alu_control1(

    .ALUop(ALUOp),
    .funct3(IR[14:12]),
    .op5(IR[5]),
    .funct7(IR[31:25]),
    .ALUControl(ALUControl)

);

instruction_register ir(
    .clk(clk),
    .reset(reset),
    .IRWrite(IRWrite),
    .instruction_in(memory_data),
    .instruction_out(IR)
);
old_programcounter old_program_counter1(
  .clk(clk),
    .reset(reset),

    .OldPCWrite(IRWrite),

    .OldPC_in(program_counter),
    .OldPC_out(old_program_counter)

);

A_register A_reg(

    .clk(clk),
    .reset(reset),

    .AWrite(AWrite),

    .A_in(read_data_1),
    .A_out(A)

);

write_data_register write_data_reg(

    .clk(clk),
    .reset(reset),

    .WriteDataWrite(WriteDataWrite),

    .WriteData_in(read_data_2),
    .WriteData_out(WriteData)

);

ALU_out_reg alu_out_reg1(

    .clk(clk),
    .reset(reset),

    .ALUOutWrite(ALUOutWrite),

    .ALUOut_in(alu_result),
    .ALUOut_out(ALUOut)

);

Data_register data_reg(

    .clk(clk),
    .reset(reset),

    .DataWrite(DataWrite),

    .Data_in(memory_data),
    .Data_out(Data)

);

endmodule 








