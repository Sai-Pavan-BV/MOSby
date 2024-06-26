#!/bin/bash
clear
iverilog -o temp cache.v
rm temp
iverilog -o cache cache_tb.v
./cache
gtkwave cache.vcd
rm cache
rm cache.vcd