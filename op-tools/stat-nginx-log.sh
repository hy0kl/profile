#!/usr/bin/env bash
# @describe: 耗时接口排行简单实现

#set -x

if [ $# -lt 1 ]; then
    echo "usage: $0 log-file [top-num]"
    exit 1
fi
log_file=$1

top_num=10
if [ $# -gt 1 ] && [ "$2" -gt 0 ] 2>/dev/null; then
    top_num=$2
fi

jq -r '.request_time,.request_uri' $log_file | awk '
BEGIN{
    iter = "";
}
{
    if (NR % 2 == 0) {
        print iter"\t"$1;
    } else {
        iter = $1;
    }
}
' | sort -k 1 -nr | head -n $top_num

# vim:set ts=4 sw=4 et fdm=marker:

