#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

source ~/xspace/conf/sin.in
ipconf_now="/tmp/ip_cfg_`date +%s`"
line_num=0
choice=1

new_ip_config() {
    local ipconf=~/w7udots/ssh-helper/iplist.cfg
    if [ -e ${ipconf} ]; then
        while [ -e ${ipconf_now} ]; do
            ipconf_now=/tmp/ip_cfg_`date +%s`
        done
        grep -v -E "^#|^$" ${ipconf} > ${ipconf_now}
    else
        echo "${ipconf} DOES NOT EXIST." && exit
    fi
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
        ADDRESS=`echo ${line} | awk -F'[#]' '{print $1}'`
        COMMENT=`echo ${line} | awk -F'[#]' '{print $2}'`
        IP[$line_num]=`echo ${ADDRESS} | awk '{print $1}'`
        USER[$line_num]=`echo ${ADDRESS} | awk '{print $2}'`
        PORT[$line_num]=`echo ${ADDRESS} | awk '{print $3}'`
        PSW[$line_num]=`echo ${ADDRESS} | awk '{print $4}'`
        if [ ${#COMMENT} -ne 0 ];then
            printf "[\x1b[38;5;46m%s\033[0m]\t\x1b[38;5;128m%-40s\033[0m\x1b[38;5;250m# %-10s\033[0m\n" "${line_num}" "${IP[$line_num]}" "${COMMENT}"
        else printf "[\x1b[38;5;46m%s\033[0m]\t\x1b[38;5;128m%-40s\033[0m\n" "${line_num}" "${IP[$line_num]}"
        fi
    done < $1
    printf "pick[\x1b[38;5;46mNO\033[0m]: "
}

make_choice() {
    # stty erase  or 
    while [ 0 -eq 0 ]; do
        read choice
        if [[ $choice =~ ^[1-9][0-9]*$ ]]; then
            if [ $choice -gt $line_num ]; then
                printf "[\x1b[38;5;214m%s\033[0m]\n" "YOUR CHOICE IS TOO LARGE, TRY AGAIN"
                printf "pick[\x1b[38;5;46mNO\033[0m]: "
            else
                break
            fi
        else
            printf "[\x1b[38;5;214m%s\033[0m]\n" "YOUR CHOICE IS INVALID, TRY AGAIN"
            printf "pick[\x1b[38;5;46mNO\033[0m]: "
        fi
    done
}

autologin() {
    if [ ${PSW[${choice}]} == 'sit' ]; then
        psw=$psw_sit
    fi
    if [ ${#psw} -gt 0 ]; then
        ~/w7udots/ssh-helper/sin-helper.exp ${USER[${choice}]} ${IP[${choice}]} ${PORT[${choice}]} $psw
    else
        ssh ${USER[${choice}]}@${IP[${choice}]} -p${PORT[${choice}]}
    fi
}

####################### main #######################
clear
new_ip_config
read_ip_connfig ${ipconf_now}
delete_ip_config ${ipconf_now}
make_choice
autologin
# ssh -q ${USER[${choice}]}@${IP[${choice}]} -p${PORT[${choice}]}
# ssh ${USER[${choice}]}@${IP[${choice}]} -p${PORT[${choice}]} # -o TCPKeepAlive=no -o ServerAliveInterval=15
# ssh ${USER[${choice}]}@${IP[${choice}]} -p${PORT[${choice}]}
