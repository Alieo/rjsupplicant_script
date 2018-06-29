#!/bin/bash

nowpath=$1

login() {

    cd $nowpath/rjsupplicant/

    case $3 in
        0)

            rm out.txt;

            #enp=$(tail -1 /proc/net/arp | cut -d ' ' -f37)

            #请将下面双引号里面的内容改成您的root密码。
            echo $PD | sudo -S ./rjsupplicant.sh -u $1 -p $2 -d 0 -n $CNC > out.txt 2>&1 &
            
            sleep 6

            cd $nowpath/rjsupplicant/
            output=$(tail -1 out.txt)
            output=${output:20}

            #echo $output
            #echo ?????:$?
            
            case $output in
                "认证成功")

                    #请将下面双引号里面的内容改成您的root密码
                    echo $PD | sudo -S service network-manager restart
                    notify-send -i gtk-dialog-info "网卡设备已重启"
                    notify-send -i gtk-dialog-info $output
                    exit

                ;;
                "")

                    output=$(tail -1 out.txt)
                    notify-send -i gtk-dialog-info $output
                    exit

                ;;
                *)
                    notify-send -i gtk-dialog-info $output
                    zenity --question --text="认证失败" --ok-label="重试" --cancel-label="取消" > /dev/null 2>&1 

                    case $? in

                        0)
                            input;
                        ;;
                        *)
                            #请将下面echo后面双引号里面的内容改成您的root密码
                            echo $PD | sudo -S service network-manager restart
                            notify-send -i gtk-dialog-info "网卡设备已重启"
                            exit

                        ;;

                    esac
                ;;
            esac
        ;;
        *)
            exit
        ;;

    esac 

}

question() {
    zenity --question --text="是否使用上次登录的账号密码？" --title="默认登录" > /dev/null 2>&1 
    #no:1  yes:0

    return $?

}



info() {

    zenity --forms \
        --title="linux校园网客户端--确认登录信息" \
        --text="学号:$id \n密码:$pd" \
        --ok-label="确认" \
        --cancel-label="返回" > /dev/null 2>&1
    #yes:0  no:1

    return $?
}

input() {

    result=` \
        zenity --forms \
        --title="linux校园网客户端--登录" \
        --text="    请输入您的学号和密码" \
        --add-entry="学号:" \
        --add-password="请输入密码:" \
        --ok-label="确认" \
        --cancel-label="取消" \
        > /dev/null 2>&1
        `

    judges=$?

    case $judges in

        0)

            #id=${result%|*}
            #pd=${result#*|}
            id=(`echo $result | cut -d '|' -f1`)
            pd=(`echo $result | cut -d '|' -f2`)

            echo $result >> usr.txt

            info $id $pd;

            judge=$?

            case $judge in

                0)
                    login $id $pd $judge;;
                1)
                    input;;
            esac
        ;;
    esac

}


main() {
    
    cd $nowpath/rjsupplicant/

    question;

    status=$?

    case $status in

    1)

        input;

    ;;
    0)

        cd $nowpath/rjsupplicant/
        
        id=(`tail -1 usr.txt | cut -d'|' -f1`)
        passwd=(`tail -1 usr.txt | cut -d'|' -f2`)

        login $id $passwd $status; 
    ;;
    esac

}

main

exit;
