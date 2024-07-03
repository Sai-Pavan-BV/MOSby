#bin/bash
iverilog -o temp alu.v
iverilog -o alu alu_tb.v
vvp alu
gtkwave alu.vcd 
rm temp alu alu.vcd