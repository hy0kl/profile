#!/bin/sh
# @author:   Jerry Yang(hy0kle@gmail.com)
# @describe:

#set -x

# Save me to /etc/init.d/memcached
# And add me to system start
# chmod +x memcached
# chkconfig --add memcached
# chkconfig --level 35 memcached on
#
# description: Distributed memory caching daemon
#
# processname: memcached
# config: /usr/local/memcached/my.conf

#source /etc/rc.d/init.d/functions

### Default variables
PORT="11211"
USER="hy0kl"
MAXCONN="1024"
CACHESIZE="64"
OPTIONS=""
#SYSCONFIG="/usr/local/memcached/my.conf"

### Read configuration
#[ -r "$SYSCONFIG" ] && source "$SYSCONFIG"

RETVAL=0
prog="/opt/local/bin/memcached"
desc="Distributed memory caching"

# global functions {
work_pids=""
function get_work_pids()
{
    work_pids=$(ps aux | grep  "$prog"| grep -v grep | awk '{print $2}' | xargs)
}

start() {
    echo $"Starting $desc ($prog): "
    nohup $prog -d -p $PORT -u $USER -c $MAXCONN -m $CACHESIZE $OPTIONS &
    RETVAL=$?
    echo
    [ $RETVAL -eq 0 ] && touch /var/tmp/lock-memcached
    sleep 1
    rm nohup.out
    return $RETVAL
}

stop() {
    echo $"Shutting down $desc ($prog): "
    get_work_pids
    echo $work_pids
    #no process need to quit
    if [ "$work_pids" == "" ]; then
        echo "No process need to quit..."
        exit 0
    fi

    kill -9 $work_pids
    RETVAL=$?
    echo
    [ $RETVAL -eq 0 ] && rm -f /var/tmp/lock-memcached
    return $RETVAL
}

restart() {
    stop
    start
}

reload() {
    echo -n $"Reloading $desc ($prog): "
    kill -HUP $prog
    RETVAL=$?
    echo
    return $RETVAL
}

case "$1" in
    start)
    start
    ;;
    stop)
    stop
    ;;
    restart)
    restart
    ;;
    condrestart)
    [ -e /var/tmp/lock-$prog ] && restart
    RETVAL=$?
    ;;
    reload)
    reload
    ;;
    status)
    status $prog
    RETVAL=$?
    ;;
    *)
    echo $"Usage: $0 {start|stop|restart|condrestart|status}"
    RETVAL=1
esac

exit $RETVAL
