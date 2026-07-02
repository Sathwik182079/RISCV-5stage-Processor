module singlecycle_top(

    input clk,
    input reset

);

// Control Signals

wire RegWrite; 
wire MemRead;
wire MemWrite;
wire ALUSrc;
wire [1:0] writebacksel;
wire Branch; 
wire Jump;
wire jumpreg;
wire [1:0] ALUOp;

// ALU Control

wire [3:0] ALUControl;

// Datapath Outputs

wire [31:0] instruction;
wire alu_zero;

// Instruction Fields

wire [6:0] opcode;
wire [2:0] funct3;
wire [6:0] funct7;

assign opcode = instruction[6:0];
assign funct3 = instruction[14:12];
assign funct7 = instruction[31:25];

control_unit cu(

    .opcode(opcode),

    .RegWrite(RegWrite),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .ALUSrc(ALUSrc),
    .writebacksel(writebacksel),
    .Branch(Branch),
    .Jump(Jump),
    .ALUOp(ALUOp),
    .jumpreg(jumpreg)

);

alu_control ac(

    .ALUop(ALUOp),
    .funct3(funct3),
    .funct7(funct7),

    .ALUControl(ALUControl)

);

single_cycle_datapath dp(

    .clk(clk),
    .reset(reset),

    .RegWrite(RegWrite),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .ALUSrc(ALUSrc),
    .writebacksel(writebacksel),
    .Branch(Branch),
    .Jump(Jump),    
    .ALUControl(ALUControl),

    .instruction(instruction),
    .alu_zero(alu_zero),
    .jumpreg(jumpreg)

);


endmodule
