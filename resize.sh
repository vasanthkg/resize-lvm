#!/bin/bash
partition=$(df -h / | grep -i lv | tail -1 | cut -d' ' -f1)
size="58G"
if [ ! -z "$partition" ];
then
    sudo lvextend -L +$size $partition || error "lvextend $partition failed"
    sudo resize2fs $partition || error "resize2fs $partition failed"
    echo "lvextend/resize2fs completed !"
    df -h $partition | tail -n 1
fi
