#!/bin/bash
# @describe: 清除2个月未更新的腐败分支
# @author:   Jerry Yang(hy0kle@gmail.com)

#set -x

os=$(uname)

two_months_ago=$((3600 * 24 * 30 * 2))
current_time=`date +%s`

git fetch -p

all_branch="./all_branch.txt"
git branch --all | awk '{
    count = split($1, cntr, "/");
    if (3 == count && "origin" == cntr[2] && "HEAD" != cntr[3] && "master" != cntr[3]) {
        print cntr[2] "/" cntr[3];
    }
}' > "$all_branch"

for branch in `cat $all_branch`
do
    last_time=`git log --date=raw $branch -1 | awk '{if ("Date:" == $1) {print $2}}'`
    last_date_str=`git log --date=iso $branch -1 | awk '{if ("Date:" == $1) {print $2 " " $3}}'`
    #echo "current_time: "$current_time
    #echo "last_time:    "$last_time
    #echo "$branch last_date_str:    "$last_date_str
    diff_time=$((current_time - last_time))
    #echo "diff_time:    "$diff_time
    if ((diff_time > two_months_ago))
    then
        echo "$branch 最后一次提交时间:[$last_date_str], 已经腐烂了"
        del_branch=`echo $branch | awk '{split($1, cntr, "/"); print cntr[2];}'`
        #cmd="git push origin --delete $del_branch"
        #echo $cmd
        git push origin --delete $del_branch
    fi
done

# 删除临时文件
rm "$all_branch"
# vim:set ts=4 sw=4 et fdm=marker:

