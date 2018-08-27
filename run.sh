#!/bin/bash
set -e

# on raspbian, build the program and reboot to it

CONF=$1

if [[ $CONF == "" ]]
then
    CONF=RPI3
fi

./build.sh nimmain $CONF

set -x
sudo cp nim-ultibo-rpi-nimmain-kernel-$CONF.img *-config.txt *-cmdline.txt /boot
#sudo cp /boot/config.txt /boot/default-config.txt
sudo cp /boot/nim-ultibo-rpi-nimmain-config.txt /boot/config.txt

sleep 2
sudo reboot
