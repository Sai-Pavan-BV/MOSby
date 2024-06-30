#!/bin/bash
clear
iverilog -o temp branch.v
rm temp
git add --all
git commit --reuse-message=HEAD

