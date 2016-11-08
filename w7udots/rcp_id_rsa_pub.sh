#!/bin/sh
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

if [[ $# -ne 1 ]]; then
    echo "specify host"
    exit 1
fi
t_ip=$1
t_port=22
t_user='admin'

cat ~/.ssh/id_rsa.pub | (ssh -p $t_port $t_user@$t_ip "cat >> ~/.ssh/authorized_keys")
