#!/bin/sh
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

if [[ $# -ne 2 ]]; then
    echo 'specify: $host $username(admin | log)'
    exit 1
fi
t_ip=$1
t_user=$2
t_port=22

cat ~/.ssh/id_rsa.pub | (ssh -p $t_port $t_user@$t_ip "cat >> ~/.ssh/authorized_keys")
if [ $? -eq 0 -a `grep $t_ip ~/w7udots/iplist.cfg | wc -l` -eq 0 ]; then
    echo "$t_ip\t$t_user" >> ~/w7udots/iplist.cfg
    echo "w"
fi
