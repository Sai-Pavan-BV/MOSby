#!/bin/bash
clear
iverilog -o temp mosby.v
rm temp
iverilog -o mosby mosby_tb.v
vvp mosby
gtkwave mosby.vcd --script=wave.tcl
rm mosby
rm mosby.vcd