# Multi-Cycle RISC-V RV32I Processor

## Overview

This project implements a **32-bit Multi-Cycle RISC-V (RV32I) Processor** using **Verilog HDL**, based on the **Harris & Harris Computer Organization and Design** multi-cycle architecture.

Unlike the Single Cycle processor, instructions are executed over multiple clock cycles by reusing the same hardware resources, significantly reducing hardware complexity while maintaining full processor functionality.

This implementation serves as the second stage of the processor development roadmap before implementing the 5-Stage Pipelined Processor.

---

## Features

- 32-bit RV32I Architecture
- Multi-Cycle Datapath
- Finite State Machine (FSM) Controller
- Unified Instruction/Data Memory
- Shared ALU Architecture
- Temporary Datapath Registers
- Modular Verilog Design
- Reduced Hardware Through Resource Sharing

---

## Supported Instructions

### R-Type
- ADD
- SUB
- AND
- OR
- XOR
- SLL
- SRL
- SRA
- SLT

### I-Type
- ADDI

### Memory Instructions
- LW
- SW

### Branch & Jump Instructions
- BEQ
- JAL
- JALR

---

## Processor Modules

### Fetch
- Program Counter
- Unified Memory
- Instruction Register
- Old Program Counter Register

### Decode
- Register File
- Immediate Generator
- A Register
- WriteData Register

### Execute
- ALU
- ALU Control Unit
- ALUOut Register

### Memory
- Unified Memory
- Data Register

### Control
- Finite State Machine Controller

### Top-Level Integration
- Multi-Cycle Datapath
- Multi-Cycle Top Module

---

## Temporary Registers

The processor implements the temporary registers described in the Harris & Harris Multi-Cycle architecture.

- Instruction Register (IR)
- Old Program Counter (OldPC)
- A Register
- WriteData Register
- ALUOut Register
- Data Register

---

## Project Structure

```text
02_MultiCycle/
│
├── rtl/
│   ├── control/
│   ├── datapath/
│   ├── execute/
│   ├── fetch/
│   ├── memory/
│   ├── register_file/
│   ├── registers/
│   └── top/
│
├── tb/
├── vivado/
├── diagrams/
├── docs/
├── images/
├── reports/
├── waveforms/
└── README.md
```

---

## Tools Used

- Verilog HDL
- Xilinx Vivado
- Git
- GitHub

---

## Verification Status

| Component | Status |
|-----------|:------:|
| RTL Design | ✅ Complete |
| Module Integration | ✅ Complete |
| FSM Controller | ✅ Complete |
| Datapath | ✅ Complete |
| Testbench | ✅ Complete |
| Functional Simulation | ✅ Complete |
| Waveform Verification | ✅ Complete |
| RTL Schematic | ⏳ Pending |
| Timing Simulation | ⏳ Pending |

---

## Verified Functionality

The processor has been functionally verified through simulation for:

- ADD
- SUB
- ADDI
- LW
- SW
- BEQ
- JAL
- JALR
- AND

Simulation confirms:

- Correct FSM state transitions
- Correct Program Counter updates
- Correct register write-back
- Correct memory read/write operations
- Correct branch execution
- Correct jump execution
- Correct ALU operation selection

---

## Design Highlights

- Harris & Harris Multi-Cycle Datapath
- Hardware resource sharing using a single ALU
- Finite State Machine based control
- Temporary register architecture
- Unified instruction and data memory
- Modular and reusable RTL implementation

---

## Future Improvements

- RTL Schematic Generation
- Timing Simulation
- Documentation Enhancement
- Performance Analysis
- FPGA Implementation
- 5-Stage Pipelined Processor

---

## Author

**T. Sathwik**

Department of Electronics and Communication Engineering

Indian Institute of Technology Bhubaneswar

---

## Project Roadmap

```text
✅ Single Cycle Processor
✅ Multi-Cycle Processor
⬜ 5-Stage Pipelined Processor
```

---

## License

This project is intended for learning, research, and educational purposes.