
## Assumes raspbian host with nim installed

### To prepare to run the nim program (do this once)

    sudo cp /boot/config.txt /boot/default-config.txt

### To run the nim program

    ./run.sh nimmain RPI3 # or QEMUVPB or RPI or RPI2

### To change the nim program

    edit src/nimmain.nim

### To add more ultibo features

    cd src/lgpl/ultibo
    edit nimprogram.lpr
    ./compile-all.sh
