#!/usr/bin/env bash
# @describe: log常用短语排行榜
# @author:   Jerry Yang(hy0kle@gmail.com)

#set -x
#set -eu
num=10
argc=$#
if ((argc > 0))
then
    num=$1
fi

git log --oneline --color=never | awk '{
    hash_len = length($1);
    log_str  = substr($0, hash_len + 2);
    sp_str = "Merge branch"
    sp_len = length(sp_str);
    if (length(log_str) > 0 && sp_str != substr(log_str, 1, sp_len)) {
        print(log_str);
    }
}' | sort | uniq -c | sort -nr -k1 | head -n $num
# vim:set ts=4 sw=4 et fdm=marker:

