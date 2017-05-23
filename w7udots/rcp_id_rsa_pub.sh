#!/bin/sh
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

iplistf=~/w7udots/ssh-helper/iplist.cfg
while getopts "h:u:p:c:t:" opt; do
    case $opt in
        h) t_host="$OPTARG"
            ;;
        u) t_user="$OPTARG"
            ;;
        p) t_port="$OPTARG"
            ;;
        c) t_comment="$OPTARG"
            ;;
        t) t_type="$OPTARG"
            ;;
    esac
done

if [ ${#t_host} -lt 7 ]; then
    echo "Specify <host>. (-h -u -p)"
    exit -1
fi

if [ ${#t_user} -lt 1 ]; then
    t_user="admin"
fi
if [ ${#t_port} -lt 1 ]; then
    t_port=22
fi
if [ ${#t_type} -lt 1 ]; then
    t_type=none
fi

# ssh-add -K /Users/weiguo/.ssh/id_rsa
if [ `grep $t_host $iplistf | wc -l` -eq 0 ]; then
    cat ~/.ssh/id_rsa.pub | (ssh -p $t_port $t_user@$t_host "cat >> ~/.ssh/authorized_keys")
    # cat ~/.ssh/id_rsa.pub | (ssh -p $t_port $t_user@$t_host "cat >> ~/.ssh/known_hosts")
    if [ $? -eq 0 -a `grep '$t_host' $iplistf | wc -l` -eq 0 ]; then
        echo "$t_host\t$t_user\t$t_port\t$t_type\t#$t_comment" >> $iplistf
        echo "w"
    fi
else
    echo "already kicked off"
fi
