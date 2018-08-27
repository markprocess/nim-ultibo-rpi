#!/bin/bash
set -e

REPO=nim-ultibo-rpi
LPR=$1
CONF=$2

if [[ $LPR == "" ]]
then
    LPR=nimprogram
fi

if [[ $CONF == "" ]]
then
    CONF=RPI3
fi

echo build.sh $LPR $CONF
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

ULTIBOCOMPILED=src/lgpl/ultibo/compiled/$CONF

rm -rf libnimmain.a
set +e
uname -a | grep ' armv7l '
ARM=$?
set -e
if [[ $ARM == 0 ]]
then
    nim c -f --cpu:arm --app:staticlib --noMain --os:standalone --gc:none -d:release src/nim/nimmain.nim
else
    nim c -c -f --cpu:arm --noMain --os:standalone --gc:none -d:release nimmain.nim
    cat << __EOF__ >> ~/.cache/nimmain_r/nimmain.c
    void systemInit000(void)
    {
    }
    void systemDatInit000(void)
    {
    }
    void stdlib_volatileInit000(void)
    {
    }
    void stdlib_volatileDatInit000(void)
    {
    }
__EOF__
    arm-none-eabi-gcc -O2 -mabi=aapcs -marm -march=$EABIARCH -mfpu=vfpv3-d16 -mfloat-abi=hard -D__DYNAMIC_REENT__ -I/root/.choosenim/toolchains/nim-#devel/lib -c ~/.cache/nimmain_r/nimmain.c
    arm-none-eabi-ar rcs libnimmain.a nimmain.o
fi

mv libnimmain.a $ULTIBOCOMPILED/
pushd $ULTIBOCOMPILED
./ppas.sh
popd

mv $ULTIBOCOMPILED/$KERNEL $REPO-$LPR-kernel-$CONF.img
