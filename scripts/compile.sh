#!/usr/bin/env bash

# Homespace
HOME=`pwd`

# Colors
INFO='\033[0;32m'
DEBUG='\033[0;37m'

# Get all directories with .tex file
directories=$(find `pwd` -type f -name '*.tex' | sed -r 's|/[^/]+$||' |sort |uniq)
numitems=$(find `pwd` -type f -name '*.tex' | sed -r 's|/[^/]+$||' |sort |uniq | wc -l)

# Compile all TeX files
ctr=1
for i in $directories; do
    cd $i;
    echo -e "${INFO}($ctr of $numitems) Compiling TeX file in `pwd`...${INFO}"
    echo -e "${DEBUG}"
    pdflatex --shell-escape -interaction=batchmode *.tex;
    echo -e "${DEBUG}"
    ctr=$((ctr+1))
done

# Move all png files to _build  directory
cd ${HOME}
if [ ! -d "`pwd`/_build" ]; then
    echo -e "${INFO}Creating _build directory...${INFO}"
    mkdir `pwd`/_build
fi

output=$(find `pwd` -type f -name '*-out.png')
for i in $output; do
    echo -e "${INFO}Moving $i to _build..."
    mv $i `pwd`/_build
done
