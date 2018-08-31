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
sudo mkdir -p /boot/$REPO
for CONF in $CONFLIST
do
    sudo cp kernel-$CONF.img /boot/$REPO
done
sudo cp config.txt cmdline.txt /boot/$REPO
sudo cp config.txt /boot/config.txt
