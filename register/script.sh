#bin/bash
clear
iverilog -o temp register.v
rm temp
iverilog -o register register_tb.v
vvp register
gtkwave register.vcd
rm register
rm register.vcd