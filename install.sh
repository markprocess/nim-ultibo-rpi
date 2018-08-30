#!/bin/bash
set -e
set -x
REPO=nim-ultibo-rpi
CONFLIST=$*

if [[ $CONFLIST == "" ]]
then
    CONFLIST="RPI RPI2 RPI3"
fi

for CONF in $CONFLIST
do
    ./build.sh $CONF
done

set -x
for CONF in $CONFLIST
do
    sudo cp $REPO-kernel-$CONF.img /boot
done
sudo cp $REPO-config.txt $REPO-cmdline.txt /boot
sudo cp $REPO-config.txt /boot/config.txt
