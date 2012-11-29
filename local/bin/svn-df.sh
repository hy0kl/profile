#!/bin/sh
# @author:   Jerry Yang(hy0kle@gmail.com)
# @describe:

#set -x

shift 0
args=$*
svn diff $args | ~/local/colordiff/colordiff.pl | less -R
