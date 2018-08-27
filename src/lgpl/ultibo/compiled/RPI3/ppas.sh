#!/bin/sh
DoExitAsm ()
{ echo "An error occurred while assembling $1"; exit 1; }
DoExitLink ()
{ echo "An error occurred while linking $1"; exit 1; }
echo Assembling nimprogram
/usr/bin/arm-none-eabi-as -mfloat-abi=hard -meabi=5 -march=armv7-a -mfpu=vfpv3 -o nimprogram.o  nimprogram.s
if [ $? != 0 ]; then DoExitAsm nimprogram; fi
echo Linking nimprogram
OFS=$IFS
IFS="
"
/usr/bin/arm-none-eabi-ld -g     --gc-sections  -L. -o nimprogram.elf -T link.res
if [ $? != 0 ]; then DoExitLink nimprogram; fi
IFS=$OFS
echo Linking nimprogram
OFS=$IFS
IFS="
"
/usr/bin/arm-none-eabi-objcopy -O binary nimprogram.elf kernel7.img
if [ $? != 0 ]; then DoExitLink nimprogram; fi
IFS=$OFS
