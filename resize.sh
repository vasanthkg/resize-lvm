#!/bin/bash
partition=$(df -h / | grep -i lv | tail -1 | cut -d' ' -f1)

if [ ! -z "$partition" ];
then
  size=$(sudo pvs | tail -1 | awk {'print $NF'} | cut -d'.' -f1 | tr '[:lower:]' '[:upper:]' | sed 's/<//')
  #if [ $size -ne 0 ];
  #then
    sudo lvextend -L +${size} ${partition}G || error "lvextend $partition failed"
    sudo resize2fs $partition || error "resize2fs $partition failed"
    echo "lvextend/resize2fs completed !"
    df -h $partition | tail -n 1
  #else
  #  echo "The filesystem is already extented to max available.  Nothing to do!"
  #fi
fi
