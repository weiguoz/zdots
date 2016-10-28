#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

ipconf_now="/tmp/ip_cfg_`date +%s`"
line_num=0
choice=1

new_ip_config() {
    local ipconf=~/Dropbox/meili-inc-login/iplist-$1.cfg
    if [ -e ${ipconf} ]; then
        while [ -e ${ipconf_now} ]; do
            ipconf_now=/tmp/ip_cfg_`date +%s`
        done
        grep -v -E "^#|^$" ${ipconf} > ${ipconf_now}
    else
        echo "${ipconf} DOES NOT EXIST." && exit
    fi
}

clean_mess() {
    clear && echo -e "#SAMPLE: \033[43;34;0mscp -P 22 \$TARGET USERNAME@10.100.67.201:/home/YOUR/DIR\033[0m"
}

delete_ip_config() {
    if [ $# -eq 1 -a -e $1 ]; then
        rm -f $1
    fi
}

read_ip_connfig() {
    line_num=0
    while read line; do
        local m=`expr $line_num % 5`
        if [ $line_num -ne 0 -a $m -eq 0 ]; then
            echo
        fi
        let "line_num+=1"
        IP[$line_num]=`echo ${line} | awk '{print $1}'`
        PORT[$line_num]=`echo ${line} | awk '{print $2}'`
        USER[$line_num]=`echo ${line} | awk '{print $3}'`
        COMMENT=`echo ${line} | awk -F# '{print $2}'`
        echo -e "\033[44;40m[\033[48;5;5m${line_num}\033[0m]\t${IP[$line_num]}\t\t# ${COMMENT}"
    done < $1
    echo -en "select[\033[48;5;5mNO\033[0m]: "
}

make_choice() {
    # stty erase  or 
    while [ 0 -eq 0 ]; do
        read choice
        if [[ $choice =~ ^[1-9][0-9]*$ ]]; then
            if [ $choice -gt $line_num ]; then
                echo "YOUR CHOICE IS TOO LARGE, TRY AGAIN."
                echo -en "\033[44;40mselect[\033[31;1;5mNO\033[0m]: "
            else
                break
            fi
        else
            echo "YOUR CHOICE IS INVALID, TRY AGAIN."
            echo -en "\033[44;40mselect[\033[31;1;5mNO\033[0m]: "
        fi
    done
}


####################### main #######################
file_no=1
if [ $# -eq 1 ]; then
    file_no=$1
fi
new_ip_config ${file_no}
clean_mess
read_ip_connfig ${ipconf_now}
delete_ip_config ${ipconf_now}
make_choice
# ssh -q ${USER[${choice}]}@${IP[${choice}]} -p${PORT[${choice}]}
# ssh ${USER[${choice}]}@${IP[${choice}]} -p${PORT[${choice}]} # -o TCPKeepAlive=no -o ServerAliveInterval=15
ssh ${USER[${choice}]}@${IP[${choice}]} -p${PORT[${choice}]}
