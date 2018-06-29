#!/bin/bash

nowpath=`pwd`

cd $nowpath

case $1 in
    "run")
        ./runrj.sh $nowpath;;
    "quit")
        ./quitrj.sh $nowpath;;
    "help")
        echo "参数："
        echo "    校园网客户端认证：run"
        echo "    校园网客户端退出：quit"
        echo "    上述参数无需加 - 或 --";;
    *)
        echo "错误的参数: " $1
        echo "获取更多帮助请输入: rj help";;
esac
