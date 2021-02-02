#!/usr/bin/env bash
# @describe: ubuntu 单点服务初始化

#set -x
set -e

function usage() {
    echo "$0 base|nginx|go|mysql|redis|all"
    echo ""
    echo "base: dependence,supervisor"
    exit 1
}

if [ $# -lt 1 ]
then
    usage
fi

# 部署目录
top_dir="/work"
# nginx work group
nginx_work="ubuntu"
service=$1

function init_base () {
    sudo apt update
    sudo apt upgrade
    sudo apt autoremove

    sudo apt install -y make gcc libpcre3-dev libssl-dev zlib1g-dev zlib1g-dev libxslt1-dev \
        silversearcher-ag mercurial jq git \
        tree ctags vim

    if [ $? != 0 ]
    then
        echo "安装依赖失败"
        exit 2
    fi

    cd "$top_dir" && \
        mkdir -p var \
            data/backup data/sql data/db-backup \
            logs/crontab

    sudo apt -y install supervisor
    if [ $? != 0 ]
    then
        echo "supervisor 安装失败"
        exit 3
    else
        echo "supervisor 安装成功"
    fi
}

function init_src() {
    mkdir -p /tmp/src

    if [ $? != 0 ]
    then
        echo "初始化目录失败"
        exit 4
    fi
}

function init_nginx() {
    init_src

    mkdir -p "$top_dir/service/nginx" "$top_dir/logs/nginx-logs"
    cd /tmp/src
    if [ -d "$top_dir/service/nginx/sbin" ]
    then 
        echo "nginx 已安装"
    else
        nginx_version="nginx-1.18.0"
        wget https://nginx.org/download/$nginx_version.tar.gz && \
            tar xf $nginx_version.tar.gz && \
            cd $nginx_version && \
            ./configure --prefix=$top_dir/service/nginx \
                --user=$nginx_work --group=$nginx_work \
                --with-http_ssl_module \
                --with-http_v2_module \
                --with-http_realip_module \
                --with-http_addition_module \
                --with-http_xslt_module \
                --with-http_sub_module \
                --with-http_gunzip_module \
                --with-http_gzip_static_module \
                --with-http_auth_request_module \
                --with-http_stub_status_module && \
            make && make install

        if [ $? != 0 ]
        then
            echo "nginx 安装失败"
            exit 5
        else
            echo "nginx 安装成功"
        fi
    fi
}

function init_go() {
    init_src

    if [ -d "$top_dir/service/go/bin" ]
    then
        echo "golang 已经安装"
    else
        mkdir -p "$top_dir/service"
        cd /tmp/src && \
            wget https://golang.org/dl/go1.15.7.linux-amd64.tar.gz -O go.tar.gz && \
            tar xf go.tar.gz && \
            mv go $top_dir/service

        if [ $? != 0 ]
        then
            echo "安装golang失败"
            exit 6
        else
            echo "export PATH=\$PATH:$top_dir/service/go/bin" >> ~/.bashrc
            echo "golang 安装成功"
        fi
    fi
}

function init_mysql() {
    sudo apt install -y mysql-server mysql-client
    if [ $? != 0 ]
    then
        echo "mysql 安装失败"
        exit 7
    else
        echo "mysql 安装成功"
    fi
}

function init_redis() {
    init_src

    cd "$top_dir" && mkdir -p service/redis/var/logs service/redis/var/run service/redis/conf
    cd /tmp/src

    if [ -d "$top_dir/service/redis/bin" ]
    then
        echo "redis 已安装"
    else
        redis_version="redis-6.0.10"
        prefix="$top_dir/service/redis"
        wget http://download.redis.io/releases/$redis_version.tar.gz && \
            tar xf $redis_version.tar.gz && cd $redis_version && \
            make PREFIX=$prefix && make PREFIX=$prefix install && \
            cp redis.conf "$top_dir/service/redis/conf/redis.conf"
        if [ $? != 0 ]
        then
            echo "redis 安装失败"
            exit 8
        else
            echo "redis 安装成功"
        fi
    fi
}

if [ "$service" == "base" ]
then
    init_base
elif [ "$service" == "nginx" ]
then
    init_nginx
elif [ "$service" == "go" ]
then
    init_go
elif [ "$service" == "mysql" ]
then
    init_mysql
elif [ "$service" == "redis" ]
then
    init_redis
elif [ "$service" == "all" ]
then
    init_base
    init_nginx
    init_go
    init_mysql
    init_redis
else
    echo "指定服务不支持, service: $service"
    exit 9
fi

echo "系统 $service 服务安装完成"

# vim:set ts=4 sw=4 et fdm=marker:

