#!/bin/bash
set -e

REPO=nim-ultibo-rpi
LPR=$1
CONF=$2

if [[ $LPR == "" ]]
then
    LPR=ultiboprogram
fi

if [[ $CONF == "" ]]
then
    CONF=RPI3
fi

echo build.sh $LPR $CONF
case $CONF in
QEMUVPB)
    PROC=QEMUVPB
    ARCH=ARMV7a
    ;;
RPI)
    PROC=RPIB
    ARCH=ARMV6
    ;;
RPI2)
    PROC=RPI2B
    ARCH=ARMV7a
    ;;
RPI3)
    PROC=RPI3B
    ARCH=ARMV7a
    ;;
esac

ULTIBO=$HOME/ultibo/core
ULTIBOBIN=$ULTIBO/fpc/bin
export PATH=$ULTIBOBIN:$PATH
for f in *.lpr
do
    ptop -l 1000 -i 1 -c ptop.cfg $f $f.formatted
    mv $f.formatted $f
done

fpc -Cn -dBUILD_$CONF -B -O2 -Tultibo -Parm -Cp$ARCH -Wp$PROC -Fi$ULTIBO/source/rtl/ultibo/extras -Fi$ULTIBO/source/rtl/ultibo/core @$ULTIBOBIN/$CONF.CFG $LPR.lpr |& tee errors.log

rm -rf compiled/$CONF
mkdir -p compiled/$CONF
sed -i '/^SEARCH_DIR/d' link.res
sed -i 's!^.*units!../../../ultibo!' link.res
mv ultiboprogram.o link.res ppas.sh compiled/$CONF/
