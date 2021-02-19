#!/usr/bin/env bash
# @describe: ubuntu系统自动安装 prometheus node_exporter

#set -x

pid=`ps aux | grep node_exporter | grep -v grep | awk '{print $2}'`
if [ ! -z "$pid" ]; then
    echo "node_exporter already installed"
    exit 0
fi

#### create user group ###
sudo groupadd prometheus
sudo useradd -g prometheus -s /sbin/nologin prometheus

#### deploy node_exporter ####
sudo mkdir -p /home/service
mkdir -p /tmp/src && cd /tmp/src
wget https://github.com/prometheus/node_exporter/releases/download/v1.1.1/node_exporter-1.1.1.linux-amd64.tar.gz
tar -xf node_exporter-1.1.1.linux-amd64.tar.gz -C /home/service
sudo mv /home/service/node_exporter-1.1.1.linux-amd64  /home/service/node_exporter

#### setup autostart ####
service_tpl="/tmp/node_exporter-service.tpl"
cat  << EOF  > "$service_tpl"
[Unit]
Description=node_exporter
Documentation=https://prometheus.io/
After=network.target

[Service]
Type=simple
User=prometheus
ExecStart=/home/service/node_exporter/node_exporter
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

sudo mv "$service_tpl" /lib/systemd/system/node_exporter.service

### start node_exporter ###
sudo systemctl daemon-reload && \
    sudo systemctl start node_exporter && \
    sudo systemctl enable node_exporter

if  [ $? -eq 0 ];
then
    echo  "deploy success"
else
    echo  "deploy failed"
fi

# vim:set ts=4 sw=4 et fdm=marker:

