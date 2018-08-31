#!/bin/bash
set -e
set -x
 
REPO=nim-ultibo-rpi
CONF=$1

if [[ $CONF == "" ]]
then
    MODEL=$(cat /proc/device-tree/model | tr -d \\0)
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
fi

echo build.sh $CONF
case $CONF in
QEMUVPB)
    EABIARCH=armv7-a
    KERNEL=kernel.bin
    ;;
RPI)
    EABIARCH=armv6
    KERNEL=kernel.img
    ;;
RPI2)
    EABIARCH=armv7-a
    KERNEL=kernel7.img
    ;;
RPI3)
    EABIARCH=armv7-a
    KERNEL=kernel7.img
    ;;
esac

rm -rf libnimmain.a
nim c -f --cpu:arm --app:staticlib --noMain --os:standalone --gc:none -d:release src/nimmain.nim

ULTIBOCOMPILED=lib/ultiboprogram/compiled/$CONF
mv libnimmain.a $ULTIBOCOMPILED/
pushd $ULTIBOCOMPILED
./ppas.sh
popd

mv $ULTIBOCOMPILED/$KERNEL kernel-$CONF.img
