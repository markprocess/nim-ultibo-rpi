#!/bin/bash

for CONF in QEMUVPB RPI RPI2 RPI3
do
    ./compile-program.sh nimprogram $CONF
done

