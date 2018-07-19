#!/bin/bash

echo 第一个参数：用户密码
echo 第二个参数：有线网卡名称
echo 请检查您的参数是否正确。

nowpath=`pwd`

#cd ~/

chmod +x *

echo "

    ############ruijie######## 

    export \$PD=\"$1\" 
    export \$CNC=\"$2\" 
    alias rj='fun(){ $nowpath/rj.sh \$1; }; fun'

    ############ruijie######## 

" >> ~/.bashrc

sources ~/.bashrc
