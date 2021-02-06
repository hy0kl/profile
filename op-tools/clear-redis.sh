#!/usr/bin/env bash
# @describe: 清理redis指定的keys

keys=""
db_num=0

if [ $# -lt 1 ]; then
    echo "usage:   $0 rds-keys-name [database-number]"
    echo "example: $0 test:cache* 8"
    exit 1
fi

keys=$1

if [ $# -gt 1 ] && [ "$2" -gt 0 ] 2>/dev/null; then
    db_num=$2
    if [ "$db_num" -gt 15 ]; then
        echo "redis database number is out of range"
        exit 2
    fi
fi

# clear redis
redis-cli -n $db_num keys "$keys" | awk '{print "\""$0"\""}' | xargs redis-cli -n $db_num del

echo -n "'reids-cli -n $db_num del $keys' exec result is: "
if [ $? != 0 ]; then
    echo "fail"
else
    echo "success"
fi

