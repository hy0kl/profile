#!/usr/bin/env bash
# @describe: 永久从仓库删除文件,包括日志清除,无法再次恢复
# @author:   Jerry Yang(hy0kle@gmail.com)

#set -x

# terminal color
    red=$'\e[1;31m'
  green=$'\e[1;32m'
 yellow=$'\e[1;33m'
   blue=$'\e[1;34m'
magenta=$'\e[1;35m'
   cyan=$'\e[1;36m'
  white=$'\e[1;37m'
 normal=$'\e[m'

function usage() {
    echo "${cyan}Usage: ${green}$0 ${yellow}file1 [file2 ...]${normal}"
}

if [ $# -lt 1 ];then
    usage
    exit 1
fi

shift 0
args=$*

git filter-branch --index-filter "git rm -rf --cached --ignore-unmatch $args" HEAD && \
rm -rf .git/refs/original/ && \
git reflog expire --all && \
git gc --aggressive --prune && \
git filter-branch --prune-empty && \
rm -rf .git/refs/original/

if [ 0 == $? ]
then
    echo "${magenta}delete files forever success.${normal}"
else
    echo "${red}delete files forever fail!${normal}"
fi
# vim:set ts=4 sw=4 et fdm=marker:

