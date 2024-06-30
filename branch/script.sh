#!/bin/bash
clear
iverilog -o temp branch.v
rm temp
git add --all
if[ $1 == 0 ] then
    git commit -m"nil"
else
    git commit -m "$1"
fi
