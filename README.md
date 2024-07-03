# MOSby

## Introduction
The MOS 6502 is an 8-bit microprocessor introduced by MOS Technology in 1975. The 6502's design emphasized simplicity, making it a popular choice for systems like the Apple I & II, Commodore 64, and Atari 2600. I tried to implement this processor using Verilog.

## Specification
This processor has 8-bit data bus and 16-bit address bus. It is a two stage pipelined processor.
### *Registers
It is a accumulator based processor with two other registers X and Y for data storage and address indexing.
The original design uses two clocks- one invertion of other.
