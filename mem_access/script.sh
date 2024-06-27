#bin/bash
clear
iverilog -o temp mem_access.v
rm temp
iverilog -o mem_access mem_access_tb.v
vvp mem_access
gtkwave mem_access.vcd &
sleep 1
rm mem_access
rm mem_access.vcd