#!/bin/bash
clear
iverilog -o temp clk_gen.v
rm temp
iverilog -o clk_gen clkgen_tb.v
vvp clk_gen
gtkwave clkgen.vcd 
rm clk_gen
rm clkgen.vcd