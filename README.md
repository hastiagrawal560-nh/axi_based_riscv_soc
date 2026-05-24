
# AXI-Based RISC-V SoC

A modular AXI4-Lite based SoC design implemented in Verilog HDL using Xilinx Vivado.

This project focuses on building and integrating AXI-based peripherals, processor interfaces, and verification environments as part of a scalable RISC-V inspired SoC architecture.

---

## Current Progress

The project currently includes:

- AXI4-Lite GPIO Slave
- GPIO Register Module
- CPU Interface Module
- Top-Level SoC Integration
- Behavioral Simulation Testbench
- AXI Read and Write Transaction Support

---

## Project Architecture

```text
CPU Interface
      ↓
AXI GPIO Slave
      ↓
GPIO Register
```

---

## Features Implemented

- AXI write address channel
- AXI write data channel
- AXI write response channel
- AXI read address channel
- AXI read data channel
- GPIO output register integration
- Read-back verification through simulation

---

## Folder Structure

```text
rtl/            → RTL design files
verification/   → Testbench and verification files
images/         → Simulation waveforms and architecture diagrams
docs/           → Documentation and notes
```

---

## Tools & Technologies

- Verilog HDL
- Xilinx Vivado
- Behavioral Simulation
- AXI4-Lite Protocol

---

## Simulation Status

AXI write transaction verified  
AXI read transaction verified  
GPIO output successfully updated  
Functional simulation completed  

---

## Future Work

- Address decoding
- UART peripheral integration
- AXI interconnect
- Timer module
- Cache integration
- Full pipelined RISC-V CPU integration

---

## Author

Hasti Agrawal  
B.Tech Electronics & VLSI Design
