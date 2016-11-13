#!/bin/sh
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

while getopts "h:u:p:" opt; do
    case $opt in
        h) t_host="$OPTARG"
            ;;
        u) t_user="$OPTARG"
            ;;
        p) t_port="$OPTARG"
            ;;
    esac
done

if [ ${#t_host} -lt 7 ]; then
    echo "Specify <host>"
    exit -1
fi

if [ ${#t_user} -lt 1 ]; then
    t_user="admin"
fi
if [ ${#t_port} -lt 1 ]; then
    t_port=22
fi

if [ `grep $t_host ~/w7udots/iplist.cfg | wc -l` -eq 0 ]; then
    cat ~/.ssh/id_rsa.pub | (ssh -p $t_port $t_user@$t_host "cat >> ~/.ssh/authorized_keys")
    if [ $? -eq 0 -a `grep $t_host ~/w7udots/iplist.cfg | wc -l` -eq 0 ]; then
        echo "$t_host\t$t_user\t$t_port" >> ~/w7udots/iplist.cfg
        echo "w"
    fi
else
    echo "already kicked off"
fi
