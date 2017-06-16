#!/usr/bin/env bash
# @describe: 搜索代码仓库里的幽灵文件
# 在代码库出现过,后来被删除的文件
# 通过文件名以 grep 的方式查找
# @author:   Jerry Yang(hy0kle@gmail.com)

#set -x

function usage() {
    echo "Usage: $0 file-str"
}

if [ $# -lt 1 ];then
    usage
    exit 1
fi

shift 0
args=$*

git log --name-only --pretty="format:" --color=never | awk '
{
    if (length($0) > 0) {
        print $0;
    }
}' | sort | uniq | grep --color=yes $args #| grep -v grep
# vim:set ts=4 sw=4 et fdm=marker:

