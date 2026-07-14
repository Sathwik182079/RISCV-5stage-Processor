//=====================================================
// Module : Pipeline Datapath
// Project: 5-Stage Pipelined RISC-V Processor
// Author : T. Sathwik
//=====================================================

`timescale 1ns/1ps

module pipeline_datapath(
    input clk,
    input reset,

    // ==========================================
    // Inputs from Control Unit
    // ==========================================
    input RegWrite,
    input MemRead,
    input MemWrite,
    input ALUSrc,
    input Branch,
    input Jump,
    input jumpreg,
    input [1:0] ResultSrc,
    input [1:0] ALUOp,

    // ==========================================
    // Inputs from Hazard Unit
    // ==========================================
    input [1:0] ForwardA,
    input [1:0] ForwardB,
    input program_counter_Write,
    input IF_ID_Write,
    input Flush_IF_ID,
    input Flush_ID_EX,

    // ==========================================
    // Outputs to Control Unit
    // ==========================================
    output [6:0] opcode,

    // ==========================================
    // Outputs to Hazard Unit
    // ==========================================
    output [4:0] rs1_D,
    output [4:0] rs2_D,
    output [4:0] rs1_E,
    output [4:0] rs2_E,
    output [4:0] rd_E,
    output MemRead_E,
    output program_counter_src_E,
    output Jump_E,
    output JumpReg_E,
    output [4:0] rd_M,
    output RegWrite_M,
    output [4:0] rd_W,
    output RegWrite_W
);

// IF Stage Wires
wire [31:0] program_counter;
wire [31:0] next_program_counter;
wire [31:0] program_counter_plus4;
wire [31:0] instruction;

// IF/ID Pipeline Register Wires
wire [31:0] IF_ID_program_counter;
wire [31:0] IF_ID_program_counter_plus4;
wire [31:0] IF_ID_instruction;

program_counter program_counter1(
    .clk(clk),
    .reset(reset),
    .en(program_counter_Write),
    .program_counter_next(next_program_counter),
    .program_counter(program_counter)
);

wire program_counter_src;
assign program_counter_src = Branch_EX & zero;

wire JumpTaken;
wire JALRTaken;
assign JumpTaken = Jump_EX;
assign JALRTaken = jumpreg_EX;

wire [31:0] JALR_target;
assign JALR_target = ALU_result & 32'hFFFFFFFE;
assign program_counter_plus4 = program_counter + 32'd4;
assign next_program_counter =
        (JALRTaken) ? JALR_target :
        (JumpTaken) ? branch_target :
        (program_counter_src) ? branch_target :
                                program_counter_plus4;

instruction_memory im(
    .program_counter(program_counter),
    .instruction(instruction)
);

// IF/ID Pipeline Register
IF_ID IF_ID_(
    .clk(clk),
    .reset(reset),
    .en(IF_ID_Write),
    .clear(Flush_IF_ID),
    .program_counter_in(program_counter),
    .instruction_in(instruction),
    .program_counter_plus4_in(program_counter_plus4),
    .program_counter_out(IF_ID_program_counter),
    .instruction_out(IF_ID_instruction),
    .program_counter_plus4_out(IF_ID_program_counter_plus4)
);

// Decode Stage Wires
wire [4:0] rs1;
wire [4:0] rs2;
wire [4:0] rd;
wire [2:0] funct3;
wire [6:0] funct7;
wire [31:0] read_data1;
wire [31:0] read_data2;
wire [31:0] immediate;

assign rs1 = IF_ID_instruction[19:15];
assign rs2 = IF_ID_instruction[24:20];
assign rd  = IF_ID_instruction[11:7];
assign funct3 = IF_ID_instruction[14:12];
assign funct7 = IF_ID_instruction[31:25];

wire [31:0] write_data;
wire        RegWrite_WB;
wire [4:0]  rd_WB;

register_file RF(
    .clk(clk),
    .write_enable(RegWrite_WB),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd_WB),
    .write_data(write_data),
    .read_data1(read_data1),
    .read_data2(read_data2)
);

immediate_generator IMM_GEN(
    .instruction(IF_ID_instruction),
    .immediate(immediate)
);

// ID/EX Pipeline Register Wires
wire [31:0] ID_EX_program_counter;
wire [31:0] ID_EX_program_counter_plus4;
wire [31:0] ID_EX_read_data1;
wire [31:0] ID_EX_read_data2;
wire [31:0] ID_EX_immediate;
wire [4:0] ID_EX_rs1;
wire [4:0] ID_EX_rs2;
wire [4:0] ID_EX_rd;
wire [2:0] ID_EX_funct3;
wire [6:0] ID_EX_funct7;
wire RegWrite_EX;
wire MemRead_EX;
wire MemWrite_EX;
wire ALUSrc_EX;
wire Branch_EX;
wire Jump_EX;
wire jumpreg_EX;
wire [1:0] ResultSrc_EX;
wire [1:0] ALUOp_EX;

ID_EX ID_EX_REG(
    .clk(clk),
    .reset(reset),
    .en(1'b1),
    .clear(Flush_ID_EX),
    .program_counter_in(IF_ID_program_counter),
    .program_counter_plus4_in(IF_ID_program_counter_plus4),
    .read_data1_in(read_data1),
    .read_data2_in(read_data2),
    .immediate_in(immediate),
    .rs1_in(rs1),
    .rs2_in(rs2),
    .rd_in(rd),
    .funct3_in(funct3),
    .funct7_in(funct7),
    .RegWrite_in(RegWrite),
    .MemRead_in(MemRead),
    .MemWrite_in(MemWrite),
    .ALUSrc_in(ALUSrc),
    .Branch_in(Branch),
    .Jump_in(Jump),
    .jumpreg_in(jumpreg),
    .ResultSrc_in(ResultSrc),
    .ALUOp_in(ALUOp),
    .program_counter_out(ID_EX_program_counter),
    .program_counter_plus4_out(ID_EX_program_counter_plus4),
    .read_data1_out(ID_EX_read_data1),
    .read_data2_out(ID_EX_read_data2),
    .immediate_out(ID_EX_immediate),
    .rs1_out(ID_EX_rs1),
    .rs2_out(ID_EX_rs2),
    .rd_out(ID_EX_rd),
    .funct3_out(ID_EX_funct3),
    .funct7_out(ID_EX_funct7),
    .RegWrite_out(RegWrite_EX),
    .MemRead_out(MemRead_EX),
    .MemWrite_out(MemWrite_EX),
    .ALUSrc_out(ALUSrc_EX),
    .Branch_out(Branch_EX),
    .Jump_out(Jump_EX),
    .jumpreg_out(jumpreg_EX),
    .ResultSrc_out(ResultSrc_EX),
    .ALUOp_out(ALUOp_EX)
);

// Execute Stage Wires
wire [3:0] ALUControl;
wire [31:0] ForwardA_Data;
wire [31:0] ForwardB_Data;
wire [31:0] ALU_operand1;
wire [31:0] ALU_operand2_before_mux;
wire [31:0] ALU_operand2;
wire [31:0] ALU_result;
wire zero;
wire [31:0] branch_target;

alu_control ALU_CONTROL(
    .ALUop(ALUOp_EX),
    .funct3(ID_EX_funct3),
    .funct7(ID_EX_funct7),
    .op5(1'b1),
    .ALUControl(ALUControl)
);

assign ForwardA_Data =
        (ForwardA == 2'b00) ? ID_EX_read_data1 :
        (ForwardA == 2'b10) ? EX_MEM_ALU_result :
                              write_data;

assign ForwardB_Data =
        (ForwardB == 2'b00) ? ID_EX_read_data2 :
        (ForwardB == 2'b10) ? EX_MEM_ALU_result :
                              write_data;

assign ALU_operand1 = ForwardA_Data;
assign ALU_operand2_before_mux = ForwardB_Data;

assign ALU_operand2 =
        (ALUSrc_EX) ? ID_EX_immediate :
                      ALU_operand2_before_mux;

assign branch_target = ID_EX_program_counter + ID_EX_immediate;

alu ALU(
    .operand_a(ALU_operand1),
    .operand_b(ALU_operand2),
    .ALU_control(ALUControl),
    .zero(zero),
    .ALU_result(ALU_result)
);

// EX/MEM Pipeline Register Wires
wire [31:0] EX_MEM_ALU_result;
wire [31:0] EX_MEM_write_data;
wire [31:0] EX_MEM_branch_target;
wire [31:0] EX_MEM_program_counter_plus4;
wire        EX_MEM_zero;
wire [4:0]  EX_MEM_rd;
wire        EX_MEM_RegWrite;
wire        EX_MEM_MemRead;
wire        EX_MEM_MemWrite;
wire [1:0]  EX_MEM_ResultSrc;

EX_MEM EX_MEM_REG(
    .clk(clk),
    .reset(reset),
    .en(1'b1),
    .clear(1'b0),
    .ALU_result_in(ALU_result),
    .write_data_in(ForwardB_Data),
    .branch_target_in(branch_target),
    .program_counter_plus4_in(ID_EX_program_counter_plus4),
    .zero_in(zero),
    .rd_in(ID_EX_rd),
    .RegWrite_in(RegWrite_EX),
    .MemRead_in(MemRead_EX),
    .MemWrite_in(MemWrite_EX),
    .ResultSrc_in(ResultSrc_EX),
    .ALU_result_out(EX_MEM_ALU_result),
    .write_data_out(EX_MEM_write_data),
    .branch_target_out(EX_MEM_branch_target),
    .program_counter_plus4_out(EX_MEM_program_counter_plus4),
    .zero_out(EX_MEM_zero),
    .rd_out(EX_MEM_rd),
    .RegWrite_out(EX_MEM_RegWrite),
    .MemRead_out(EX_MEM_MemRead),
    .MemWrite_out(EX_MEM_MemWrite),
    .ResultSrc_out(EX_MEM_ResultSrc)
);

wire [31:0] memory_read_data;

Data_memory DM(
    .clk(clk),
    .MemRead(EX_MEM_MemRead),
    .MemWrite(EX_MEM_MemWrite),
    .Address(EX_MEM_ALU_result),
    .WriteData(EX_MEM_write_data),
    .ReadData(memory_read_data)
);

wire [31:0] MEM_WB_memory_data;
wire [31:0] MEM_WB_ALU_result;
wire [31:0] MEM_WB_program_counter_plus4;
wire [4:0] MEM_WB_rd;
wire MEM_WB_RegWrite;
wire [1:0] MEM_WB_ResultSrc;

MEM_WB MEM_WB_REG(
    .clk(clk),
    .reset(reset),
    .en(1'b1),
    .clear(1'b0),
    .memory_data_in(memory_read_data),
    .ALU_result_in(EX_MEM_ALU_result),
    .program_counter_plus4_in(EX_MEM_program_counter_plus4),
    .rd_in(EX_MEM_rd),
    .RegWrite_in(EX_MEM_RegWrite),
    .ResultSrc_in(EX_MEM_ResultSrc),
    .memory_data_out(MEM_WB_memory_data),
    .ALU_result_out(MEM_WB_ALU_result),
    .program_counter_plus4_out(MEM_WB_program_counter_plus4),
    .rd_out(MEM_WB_rd),
    .RegWrite_out(MEM_WB_RegWrite),
    .ResultSrc_out(MEM_WB_ResultSrc)
);

// Write Back Logic
assign write_data =
        (MEM_WB_ResultSrc == 2'b00) ? MEM_WB_ALU_result :
        (MEM_WB_ResultSrc == 2'b01) ? MEM_WB_memory_data :
                                     MEM_WB_program_counter_plus4;

assign RegWrite_WB = MEM_WB_RegWrite;
assign rd_WB = MEM_WB_rd;

// Output Assignments (Routing internal wires out to the Top module)
assign opcode = IF_ID_instruction[6:0];
assign rs1_D  = rs1;
assign rs2_D  = rs2;

assign rs1_E                 = ID_EX_rs1;
assign rs2_E                 = ID_EX_rs2;
assign rd_E                  = ID_EX_rd;
assign MemRead_E             = MemRead_EX;
assign program_counter_src_E = program_counter_src;
assign Jump_E                = Jump_EX;
assign JumpReg_E             = jumpreg_EX;

assign rd_M       = EX_MEM_rd;
assign RegWrite_M = EX_MEM_RegWrite;

assign rd_W       = MEM_WB_rd;
assign RegWrite_W = MEM_WB_RegWrite;

endmodule