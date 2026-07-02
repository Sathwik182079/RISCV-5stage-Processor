# Single Cycle RISC-V RV32I Processor

## Overview

This project implements a **32-bit Single Cycle RISC-V (RV32I) Processor** using **Verilog HDL**.

The processor executes every instruction in a single clock cycle and is designed as the first stage of a complete processor development roadmap.

This implementation serves as the foundation for the upcoming:
- Multi-Cycle RISC-V Processor
- 5-Stage Pipelined RISC-V Processor

---

## Features

- 32-bit RV32I Architecture
- Single Cycle Datapath
- Harvard Architecture
- Modular Verilog Design
- Separate Instruction and Data Memories
- Word-Aligned Memory Access
- Combinational Read Memories
- Synchronous Register File and Data Memory Writes

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

### Fetch Stage
- Program Counter
- Instruction Memory

### Decode Stage
- Register File
- Immediate Generator
- Main Control Unit

### Execute Stage
- ALU
- ALU Control Unit

### Memory Stage
- Data Memory

### Write Back Stage
- Write Back Multiplexer

### Top-Level Integration
- Single Cycle Datapath
- Single Cycle Top Module

---

## Project Structure

```
01_SingleCycle/
│
├── rtl/
│   ├── control/
│   ├── datapath/
│   ├── execute/
│   ├── fetch/
│   ├── memory/
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
- Documentation
- Multi-Cycle Processor
- 5-Stage Pipeline Processor
- Forwarding Unit
- Hazard Detection Unit

---

## Author

**T. Sathwik**

Department of Electronics and Communication Engineering

Indian Institute of Technology Bhubaneswar

---

## Project Roadmap

```
✅ Single Cycle Processor
⬜ Multi-Cycle Processor
⬜ 5-Stage Pipelined Processor
```

---

## License

This project is intended for learning, research, and educational purposes.
