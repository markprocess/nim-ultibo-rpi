
## Assumes raspbian host with gcc-arm-none-eabi and nim installed

### To prepare to run the nim program (do this once)

    sudo cp /boot/config.txt /boot/default-config.txt

### To run the nim program

    ./run.sh

### To change the nim program

    edit src/nimmain.nim

### To install all platform kernels (rpi, rpi2, rpi3) on the sd card, ready to insert and run

    ./install.sh

### To add more ultibo features

    cd src/lgpl/ultibo
    edit nimprogram.lpr
    ./compile-all.sh
