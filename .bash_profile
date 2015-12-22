#!/bin/bash

if [ -f ~/.bashrc ];
then
    . ~/.bashrc
fi

cowsay_file=$(find /usr/share/cowsay/cows -type f | awk 'BEGIN{ i = 1; srand(); } {cntr[i] = $0; i++} END{ value = int(rand() * 1000); print cntr[value % (i - 1) + 1];}')
fortune | cowsay -f $cowsay_file
