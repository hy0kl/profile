#!/bin/bash

if [ -f ~/.bashrc ];
then
    . ~/.bashrc
fi

cows_dir=""
if [ -d "/usr/share/cowsay/cows" ];
then
    cows_dir="/usr/share/cowsay/cows"
elif [ -d "$HOME/local/share/cows" ];
then
    cows_dir="$HOME/local/share/cows"
fi

if [ -d "$cows_dir" ]
then
    cowsay_file=$(find "$cows_dir" -type f | awk 'BEGIN{ i = 1; srand(); } {cntr[i] = $0; i++} END{ value = int(rand() * 1000); print cntr[value % (i - 1) + 1];}')
    fortune | cowsay -f $cowsay_file
fi

