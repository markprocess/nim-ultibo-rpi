#!/bin/bash

./build.sh QEMUVPB |& tee errors.log | grep -i error
echo built

./tcp_serial_redirect.py /dev/ttyAMA0 115200 2> pyserial.log &
qemu-system-arm -M versatilepb -display none -vnc :70,websocket=5770 -cpu cortex-a8 -m 16M -kernel kernel-QEMUVPB.img -serial stdio -serial tcp:localhost:7777 -usb -net nic -net user,hostfwd=tcp::5780-:80 -append "NETWORK0_IP_CONFIG=STATIC NETWORK0_IP_ADDRESS=10.0.2.15 NETWORK0_IP_NETMASK=255.255.255.0 NETWORK0_IP_GATEWAY=10.0.2.2 BT_RELOAD_FW=$BT_RELOAD_FW $(cat cmdline.txt)" 2> qemu.log
