# Multi-Cycle RISC-V RV32I Processor

## Overview

This project implements a **32-bit Multi-Cycle RISC-V (RV32I) Processor** using **Verilog HDL**.

Unlike a single-cycle processor, each instruction is executed over multiple clock cycles using a **Finite State Machine (FSM)** controller. Hardware resources such as the ALU and memory are reused across different execution stages, reducing hardware complexity while improving resource utilization.

This implementation serves as the second stage of a complete processor development roadmap.

Upcoming implementation:
- 5-Stage Pipelined RISC-V Processor

---

## Features

- 32-bit RV32I Architecture
- Multi-Cycle Datapath
- FSM-Based Controller
- Unified Instruction/Data Memory
- Modular Verilog Design
- Program Counter with Write Enable
- ALU Control Unit
- Immediate Generator
- Temporary Datapath Registers

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
- ANDI
- ORI
- XORI
- SLLI
- SRLI
- SRAI
- SLTI

### Memory Instructions
- LW
- SW

### Branch & Jump Instructions
- BEQ
- JAL

---

## Processor Modules

### Fetch Stage
- Program Counter
- Instruction Register
- Unified Memory

### Decode Stage
- Register File
- Immediate Generator
- Controller FSM

### Execute Stage
- ALU
- ALU Control Unit

### Memory Stage
- Unified Memory
- Data Register

### Write Back Stage
- Result Multiplexer

### Temporary Registers
- Old Program Counter Register
- A Register
- WriteData Register
- ALUOut Register
- Data Register
- Instruction Register

### Top-Level Integration
- Multi-Cycle Datapath
- Multi-Cycle Top Module

---

## Controller States

- FETCH
- DECODE
- MEMADR
- MEMREAD
- MEMWB
- MEMWRITE
- EXECUTER
- EXECUTEI
- ALUWB
- BRANCH
- JAL

---

## Project Structure

```
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
| Testbench | ✅ Complete |
| Functional Simulation | ⏳ Pending |
| Waveform Verification | ⏳ Pending |
| RTL Schematic | ⏳ Pending |

---

## Future Improvements

- Functional Verification
- RTL Schematic Generation
- Waveform Analysis
- Complete RV32I Instruction Support
- Documentation Improvements
- 5-Stage Pipelined Processor

---

## Author

**T. Sathwik**

Department of Electronics and Communication Engineering

Indian Institute of Technology Bhubaneswar

---

## Project Roadmap

```
✅ Single Cycle Processor
✅ Multi-Cycle Processor
⬜ 5-Stage Pipelined Processor
```

---

## License

This project is intended for learning, research, and educational purposes.