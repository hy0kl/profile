#!/bin/bash
#
# Startup script for Nginx - this script starts and stops the nginx daemon
#
# description:  Nginx is an HTTP(S) server, HTTP(S) reverse proxy and IMAP/POP3 proxy server
# processname: nginx
# config:      /usr/local/nginx/conf/nginx.conf
# pidfile:     /usr/local/nginx/logs/nginx.pid
 
# Source function library.
#. /etc/rc.d/init.d/functions
 
# Source networking configuration.
#. /etc/sysconfig/network
 
# Check that networking is up.
[ "$NETWORKING" = "no" ] && exit 0
 
nginx="$HOME/nginx/sbin/nginx"
prog=$nginx
 
NGINX_CONF_FILE="$HOME/nginx/conf/nginx.conf"
 
#[ -f /etc/sysconfig/nginx ] && . /etc/sysconfig/nginx

# global functions {
work_pids=""
function get_work_pids()
{
    work_pids=$(ps aux | grep  "$prog"| grep -v grep | awk '{print $2}' | xargs)
}
 
start() {
    [ -x $nginx ] || exit 5
    [ -f $NGINX_CONF_FILE ] || exit 6

    get_work_pids
    if [ "$work_pids" == "" ]; then
        echo "It is no process working, so let it start to work."
    else
        echo "It has process working now, please stop it before start it."
        exit -1
    fi

    $nginx -c $NGINX_CONF_FILE
    retval=$?
    return $retval
}
 
stop() {
    get_work_pids
    kill_pids=$work_pids
    #no process need to quit
    if [ "$kill_pids" == "" ]; then
        echo "No process need to quit..."
        exit 0
    fi

    $nginx -s quit
    retval=$?
    echo
    [ $retval -eq 0 ] && rm -f $lockfile
    return $retval
}
 
restart() {
    configtest || return $?
    stop
    sleep 1
    start
}
 
reload() {
    configtest || return $?
    echo -n $"Reloading $prog: "
    $nginx -s reload
    RETVAL=$?
    echo
}
 
force_reload() {
    restart
}
 
configtest() {
  $nginx -t -c $NGINX_CONF_FILE
}
 
rh_status() {
    status $prog
}
 
rh_status_q() {
    rh_status >/dev/null 2>&1
}
 
case "$1" in
    start)
        rh_status_q && exit 0
        $1
        ;;
    stop)
        rh_status_q || exit 0
        $1
        ;;
    restart|configtest)
        $1
        ;;
    reload)
        rh_status_q || exit 7
        $1
        ;;
    force-reload)
        force_reload
        ;;
    status)
        rh_status
        ;;
    condrestart|try-restart)
        rh_status_q || exit 0
            ;;
    *)
        echo $"Usage: $0 {start|stop|status|restart|condrestart|try-restart|reload|force-reload|configtest}"
        exit 2
esac
