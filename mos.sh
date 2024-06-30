#!/bin/bash
clear
iverilog -o temp mosby.v
rm temp
iverilog -o mosby mosby_tb.v
vvp mosby
gtkwave mosby.vcd & sleep 1
rm mosby
rm mosby.vcd