#!/bin/bash

# 安装个性化,智能化工作环境

## 检查依赖
dependence="tree ctags vim"
for dp in $dependence
do
    which $dp 2>&1 > /dev/null
    if [ 0 != $? ]
    then
        echo "Lost dependence: $dp, please install it at first. Maybe try:"
        echo "sudo apt-get install $dependence"
        exit 1
    fi
done

# 安装
date_str=$(date +"%Y.%m.%d")
base_path=`pwd`
file_list=".bash_profile .bashrc .vimrc .ctags .gitconfig .inputrc .vim"
echo "[NOTICE] If the [$file_list] already exists, just backup them: *.bak.$date_str"
for f in $file_list
do
    check="$HOME/$f"
    source_file="$base_path/$f"
    if [ -a $check ]
    then
        mv "$check" "$check.bak.$date_str"
    fi
    ln -s "$source_file" "$check"
done

echo "[INFO] install success, please relogin, or use command:"
echo ". ~/.bashrc"
