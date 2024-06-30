#!/bin/bash
clear
iverilog -o temp branch.v
rm temp
git add --all
nill=""
echo $1
if [ $1 == $nill ]
then
    git commit -m"nil"
else
    git commit -m "$1"
fi
