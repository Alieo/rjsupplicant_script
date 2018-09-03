#!/bin/bash

nowpath=`pwd`

cd $nowpath

if [[ ! -f usr.info ]];then
    touch usr.info
fi

case $1 in
    "run")

        lastid=`tail -1 usr.info | cut -d '|' -f1`
        lastpwd=`tail -1 usr.info | cut -d '|' -f2`
        last_usrpwd=`tail -1 usr.info | cut -d '|' -f3`
        last_netname=`tail -1 usr.info | cut -d '|' -f4`
        judge="no"

        if [[ "x"${lastid} != "x" ]];then
            echo -n "是否使用上次登录账号 <${lastid}> (yes/no)?"
            read judge
        fi
        if [[ ${judge} == "yes" ]];then
            id=${lastid}
            passwd=${lastpwd}
        else 
            echo -n "input account number / student ID:"
            read id
            echo -n "input passwd:"
            read passwd
        fi
        
        if [[ "x"${last_usrpwd} != "x" ]];then
            userpwd=${last_usrpwd}
        else
            echo -n "input user passwd:"
            read userpwd
        fi
        if [[ "x"${last_netname} != "x" ]];then
            netname=${last_netname}
        else
            echo -n "输入有线网卡名称："
            read netname
        fi

        echo "${id}|${passwd}|${userpwd}|${netname}" > usr.info

        echo ${userpwd} | sudo -S ./rjsupplicant.sh -u ${id} -p ${passwd} -d 0 -n ${netname} 1> output.info 2> /dev/null&

        echo "Please wait..."
        sleep 6
        cat output.info

    ;;
    "quit")
        
        userpwd=`tail -1 usr.info | cut -d '|' -f3`

        echo ${userpwd} |sudo -S ./rjsupplicant.sh -q 1> output.info 2> /dev/null &

        echo "Please wait..."
        sleep 2

        cat output.info

    ;;
    "help")
        echo "参数："
        echo "    校园网客户端认证：run"
        echo "    校园网客户端退出：quit"
        echo "    上述参数无需加 - 或 --";;
    *)
        echo "错误的参数: " $1
        echo "获取更多帮助请输入: rj help";;
esac
