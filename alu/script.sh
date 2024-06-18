#bin/bash
iverilog -o alu alu_tb.v
vvp alu
gtkwave alu.vcd &