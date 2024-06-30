#!/bin/bash
iverilog -o temp decoder.v
rm temp

iverilog -o decoder decoder_tb.v
vvp decoder
gtkwave decoder.vcd
rm decoder
rm decoder.vcd