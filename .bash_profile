#!/bin/bash


# MacPorts Installer addition on 2010-04-30_at_15:52:11: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

if [ -f ~/.bashrc ];
then
    . ~/.bashrc
fi
