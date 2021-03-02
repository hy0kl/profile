#!/usr/bin/env bash
# @describe: 开发环境自动重建本地环境

#set -x

workspace=$(cd $(dirname $0) && pwd)
cd $workspace

db_name="work_dev"
db_user="work"
db_pwd="work@dev"

mkdir -p backup

function initDB() {
    echo "初始化中 init..."
    git pull origin master
    mysql -u"$db_user" -p"$db_pwd" $db_name < db/db-schema.sql
    echo "完成 init db completed"
}

function exportData() {
    echo "备份数据..."
    mysqldump -u"$db_user" -p"$db_pwd" -c --skip-add-locks --skip-comments --skip-disable-keys --insert-ignore -t $db_name > backup/$db_name.sql
    echo "备份数据完成"
}

function importData() {
    echo "导入备份数据"
    mysql -u"$db_user" -p"$db_pwd" $db_name < backup/$db_name.sql
    echo "导入备份数据完成"
}

function rebuild() {
    exportData

    echo "重新建库表"
    initDB
    echo "重建库表完成"

    importData
}

argc=$#
if ((argc < 1))
then
    echo "$0 init|export|import|rebuild"
    exit 0
fi

cmd=$1
if [ "$cmd" == "init" ]
then
    initDB
elif [ "$cmd" == "export" ]
then
    exportData
elif [ "$cmd" == "rebuild" ]
then
    rebuild
elif [ "$cmd" == "import" ]
then
    importData
else
    echo "$cmd no surport..."
fi

# vim:set ts=4 sw=4 et fdm=marker:

