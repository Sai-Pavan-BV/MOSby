# MOSby

## Introduction
MOSby is an implementation of the MOS 6502 microprocessor using Verilog. The MOS 6502 is an 8-bit CISC microprocessor introduced by MOS Technology in 1975. The 6502's design emphasized simplicity, making it a popular choice for systems like the Apple I & II, Commodore 64, and Atari 2600.

## Specification
This processor has an 8-bit data bus and a 16-bit address bus. It is a two-stage pipelined processor. It is an accumulator-based processor with two other registers, X and Y, for data storage and address indexing. The original design uses two clocks, one an inversion of the other. It has a Stack Pointer for stack-related operations and a status register used for arithmetic and branch operations.

## Changes
* The original processor uses a clock source and its inversion for sequential operations. To make most of the logic edge-triggered, I used a frequency divider and two clocks with different phases. For the original logic, level-triggered units can be used.
* I have added a 128-byte direct-mapped cache for faster operations, similar to those used in modern processors.

## Possible Improvements
* Changing the cache to a better one, such as a 2 or 4-way associative mapping.
* To reduce hardware, I wanted to use a single unit for addition and subtraction. Designing a Look-Ahead Adder that can do subtraction with borrow.
* I have only added and tested ADC, LDA, LDX, LDY, and NOP for immediate instructions. While the present design could be used to add most instructions, a new design is needed for other instructions.
* Implementing interrupts.
* Increasing the pipeline to 4 stages for faster clocks and easier microarchitecture.
* My design does not have well-defined pipeline stages in clock cycles. Better timing operation can be made.

## Challenges
* I could not find any data regarding the original logic used in the processor. I tried my best to replicate the instruction set using logic elements I am aware of, but I have no idea how close my design is to the original microprocessor.
* Due to different address sizes and data sizes coupled with my out-of-place timing operations, the microprocessor takes more cycles than required to execute an instruction.
* The design could not be pipelined well.

## Tools Used
Iverilog ,GTKwave and Yosys. 
## References
#### Architecture: www.6502.org
#### Data Sheet: https://www.princeton.edu/~mae412/HANDOUTS/Datasheets/6502.pdf
#### Verilog: [ChipVerify](https://www.chipverify.com/), Verilog HDL: A Guide to Digital Design and Synthesis by Samir Palnitkar

