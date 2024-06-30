#!/bin/bash
clear
iverilog -o temp branch.v
rm temp
iverilog -o branch branch_tb.v
vvp branch
gtkwave branch.vcd & sleep 1
rm branch.vcd
rm branch 
