#!/usr/bin/env bash
# @describe: 切割nginx日志,linux

#set -x
top_dir="/work"
nginx_prefix="$top_dir/service/nginx"
dest_base_path="$top_dir/logs/nginx"

yesterday=`date -d "yesterday" "+%s"`
day=`date -d @"$yesterday" "+%d"`
year=`date -d @"$yesterday" "+%Y"`
month=`date -d @"$yesterday" "+%m"`
date_str="$year$month$day"
#echo $date_str

echo "[`date +"%Y-%m-%d %H:%M:%S %Z"`] start logrotate"

# 创建目标目录,以 YYYY/MM 来分开
dest_path="$dest_base_path/$year/$month"
if [ ! -d "$dest_path" ]; then
    mkdir -p "$dest_path"
fi

all_logs=`find $nginx_prefix/logs/ -name "*.log"`
for log in $all_logs; do
    log_name=`echo $log | awk -F "/" '{print $NF}'`
    #echo $log
    #echo $log_name
    rotate_name="$dest_path/$log_name.$date_str"
    mv "$log" "$rotate_name"
done

echo "[`date +"%Y-%m-%d %H:%M:%S %Z"`] rotate finish"

keep_days=7
cd $dest_base_path && find ./ -type f -mtime +$keep_days -exec rm {} \;
echo "[`date +"%Y-%m-%d %H:%M:%S %Z"`] delete data older than $keep_days days"

sudo $nginx_prefix/sbin/nginx -s reopen
# vim:set ts=4 sw=4 et fdm=marker:

