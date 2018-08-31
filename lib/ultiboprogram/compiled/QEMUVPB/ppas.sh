#!/bin/sh
DoExitAsm ()
{ echo "An error occurred while assembling $1"; exit 1; }
DoExitLink ()
{ echo "An error occurred while linking $1"; exit 1; }
echo Linking ultiboprogram
OFS=$IFS
IFS="
"
/usr/bin/arm-none-eabi-ld -g     --gc-sections  -L. -o ultiboprogram.elf -T link.res
if [ $? != 0 ]; then DoExitLink ultiboprogram; fi
IFS=$OFS
echo Linking ultiboprogram
OFS=$IFS
IFS="
"
/usr/bin/arm-none-eabi-objcopy -O binary ultiboprogram.elf kernel.bin
if [ $? != 0 ]; then DoExitLink ultiboprogram; fi
IFS=$OFS
