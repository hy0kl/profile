#!/bin/bash
# @author:   Jerry Yang(hy0kle@gmail.com)
# @describe: 批量将源代码格式化
# 1. 将文件转为 Unix 风格
# 2. 将 tab 替换成 4 个空格
# 3. 删除行尾的空格
# 批量有风险

# CTRL + v + TAB 
# tab 的输入方法

# windows 换行符的输入
# ctrl + v ctrl + m

#set -x

work_path="/Users/hy0kl/nginx/svn-work/trunk"
date_str=$(date +"%Y-%m-%d")
transfer_file="php tpl js css"

cd $work_path
mkdir -p tmp

for file_type in $transfer_file
do
    tmp_file="tmp/$file_type.$date_str"
    find ./ -name "*.$file_type" > $tmp_file

    need=$(cat $tmp_file)
    for trans in $need
    do
        # 将文件转为 Unix 风格,有误伤,需要默认文件为 doc 风格
        #sed -i "" 's/.$//' $trans

        # 将文件转为 Unix 风格
        sed -i "" 's///g' $trans
        # 将 tab 替换成 4 个空格
        sed -i "" 's/	/    /g' $trans
        # 删除行尾的空格
        sed -i "" 's/[ 	]*$//g' $trans
    done
done

rm -rf tmp
