#!/bin/bash

cd $1/rjsupplicant/

#把下面双引号里面的内容改成您的root密码
echo $PD | sudo -S ./rjsupplicant.sh -q > out.txt

cd $1/rjsupplicant/

sleep 2

output=$(tail -1 out.txt | cut -d ' ' -f3)
notify-send -i gtk-dialog-info $output


