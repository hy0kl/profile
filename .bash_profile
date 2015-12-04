#!/bin/bash

if [ -f ~/.bashrc ];
then
    . ~/.bashrc
fi


if [[ -d "$HOME/local/share/cows" ]]; then
    cowsay_file=$(find ~/local/share/cows -type f | awk 'BEGIN{ i = 1; srand(); } {cntr[i] = $0; i++} END{ value = int(rand() * 1000); print cntr[value % (i - 1) + 1];}')
    cowsay -f $cowsay_file 'Hi, it is a new day.'
fi

