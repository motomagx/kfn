#!/bin/bash

# Kernel for Newbies
# The KFN Team

# Github: https://github.com/motomagx/

# All files with the respective functions are located in kfn/modules.

# You can explore these files at:
# https://github.com/motomagx/kfn/tree/master/files

# ===================================

DIR="$HOME/kfn"
GITHUB_URL="https://raw.githubusercontent.com/motomagx/kfn/master/files/"

clear

echo -e "\e[32;1m\nKernel for Newbies\n\e[m"

mkdir -p "$DIR/builds"
mkdir -p "$DIR/sources"
mkdir -p "$DIR/logs"
mkdir -p "$DIR/temp"
mkdir -p "$DIR/modules"
mkdir -p "$DIR/projects"

MODULES=( languages.sh cpu_cflags.sh dialog_color_scheme.sh qemu.sh core.sh )

COUNTER=0

# Checks and downloads the necessary modules:

while [ "x${MODULES[$COUNTER]}" != "x" ]
do
    if [ ! -f "$DIR/modules/${MODULES[$COUNTER]}" ]
    then
        echo -e "\e[32;1m[INFO]\e[m  Installing KFN module: ${MODULES[$COUNTER]}"
        wget "$GITHUB_URL/${MODULES[$COUNTER]}" -O "$DIR/modules/${MODULES[$COUNTER]}" --quiet 
    fi

    COUNTER=$(($COUNTER+1))
done    


# Load all modules in correctly sequence:

COUNTER=0

while [ "x${MODULES[$COUNTER]}" != "x" ]
do
	source "$DIR/modules/${MODULES[$COUNTER]}"
	COUNTER=$(($COUNTER+1))
done    

# Starts KFN:
_run



