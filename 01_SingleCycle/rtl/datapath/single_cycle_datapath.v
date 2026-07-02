module single_cycle_datapath(

    input clk,
    input reset,
    input RegWrite,
    input MemRead,
    input MemWrite,
    input ALUSrc,
    input [1:0] writebacksel,
    input Branch,

    input [3:0] ALUControl,
    input Jump,
    input jumpreg,
    output alu_zero,
    output [31:0] instruction

);


wire [31:0] program_counter ;
wire [31:0] program_counter_plus_4 ;
wire [31:0] program_counter_next;
wire [31:0] immediate;
wire [31:0] read_data_1 ;
wire [31:0] read_data_2 ;

wire [31:0] alu_input_2 ;
wire [31:0] alu_result ;

wire [31:0] memory_data ;
reg [31:0] write_back_data ;
wire [31:0] branch_address ;
wire [31:0] jalr_address;

wire [4:0] rs1;
wire [4:0] rs2;
wire [4:0] rd;
wire [2:0] funct3;
wire [6:0] funct7;
//wire [6:0] opcode;

//assign opcode = instruction[6:0];
assign rd     = instruction[11:7];
assign funct3 = instruction[14:12];
assign rs1    = instruction[19:15];
assign rs2    = instruction[24:20];
assign funct7 = instruction[31:25];


wire [31:0] jump_address;
wire branch_taken;

program_counter program_counter1 (
    .clk(clk),
    .reset(reset),
    .program_counter_next(program_counter_next),
    .program_counter(program_counter)
);

assign jump_address = program_counter + immediate;
assign jalr_address = (read_data_1 + immediate) & 32'hFFFFFFFE;
assign program_counter_plus_4 = program_counter + 32'd4;

assign branch_taken = Branch & alu_zero;
assign branch_address = program_counter + immediate;
assign program_counter_next =
        (jumpreg)      ? jalr_address :
        (Jump)         ? jump_address :
        (branch_taken) ? branch_address :
                         program_counter_plus_4;

instruction_memory im(
    .program_counter(program_counter),
    .instruction(instruction)
);


register_file rf(
  

    .clk(clk),

    .write_enable(RegWrite),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .write_data(write_back_data),
    .read_data1(read_data_1),
    .read_data2(read_data_2)

);

immediate_generator ig(

    .instruction(instruction),
    .immediate(immediate)

);

assign alu_input_2 = (ALUSrc) ? immediate : read_data_2;
    
alu alu1(

    .operand_a(read_data_1),
    .operand_b(alu_input_2),

    .ALU_control(ALUControl),

    .zero(alu_zero),
    .ALU_result(alu_result)

);

Data_memory dm(
    .clk(clk),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .Address(alu_result),
    .WriteData(read_data_2),
    .ReadData(memory_data)
);

always @(*) begin

    case (writebacksel)

        2'b00:
            write_back_data = alu_result;

        2'b01:
            write_back_data = memory_data;

        2'b10:
            write_back_data = program_counter_plus_4;

        default:
            write_back_data = alu_result;

    endcase

end

endmodule 








