#!/bin/bash
set -e

MODEL=$(cat /proc/device-tree/model)
if [[ $MODEL =~ "Pi 3" ]]
then
    CONF=RPI3
elif [[ $MODEL =~ "Pi 2" ]]
then
    CONF=RPI2
elif [[ $MODEL =~ "Pi" ]]
then
    CONF=RPI
else
    CONF=QEMUVPB
fi

./install.sh $CONF

sleep 2
sudo reboot
