# MOSby

## Introduction
MOSby is a implementation of MOS 6502 microprocessor using Verilog. The MOS 6502 is an 8-bit microprocessor introduced by MOS Technology in 1975. The 6502's design emphasized simplicity, making it a popular choice for systems like the Apple I & II, Commodore 64, and Atari 2600.

## Specification
This processor has 8-bit data bus and 16-bit address bus. It is a two stage pipelined processor.It is a accumulator based processor with two other registers X and Y for data storage and address indexing.The original design uses two clocks- one invertion of other. It has a Stack Pointer which is used for stack related operations and a status register which is used for arthimatic and branch operations.

## Changes
* The original processor uses a clock source and its invertion for sequential operantions. To make most the logic edge triggered, I used a frequency divided and a two clocks with different phases for the clock. For the original Logic, a level triggered units can be used.
* I have added a 128 byte direct mapped cache for faster operations as used in modern processors.

## Possible Improvements
* Changing the cache to a better one like a 2,4 way associative mapping.
* In order to reduce hardware I wanted to use a single unit for addition and subtraction. Designing a Look Ahead Adder which can do subtraction with borrow.
* I have only added and tested ADC, LDA,LDX, LDY and NOP for immediate instructions. While the present design could be used to add most of instructions, new designs is needed for other instructions.
* Implementing Interupts
* Increasing the pipeline to 4 for faster clocks and easier microarchitecture
* My design does not have a well defined pipeline stages in clock. A better timing operation can be made.

## Challenges
*  I could not find any data regarding the original logic used in the processor. I tried my best to replicate the Instruction Set using logic elements i am aware of. But I have no idea how close my design is to the original microprocessor
*  Due to different address size and data size coupled with my out of the place timing operations, the microprocessor takes more cycles than required to execute an instruction.
*  The design could not be pipeline well.


## References
Architecture: http://www.6502.org
Data Sheet: https://www.princeton.edu/~mae412/HANDOUTS/Datasheets/6502.pdf
Verilog: [ChipVerify](https://www.chipverify.com/), Verilog HDL: A Guide to Digital Design and Synthesis by Samir Palnitkar

