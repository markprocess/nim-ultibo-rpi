INPUT (
../../../ultibo/armv7-ultibo/rtl/bootrpi2.o
ultiboprogram.o
../../../ultibo/armv7-ultibo/rtl/system.o
../../../ultibo/armv7-ultibo/rtl/objpas.o
../../../ultibo/armv7-ultibo/rtl/globalconfig.o
../../../ultibo/armv7-ultibo/rtl/globalconst.o
../../../ultibo/armv7-ultibo/rtl/globaltypes.o
../../../ultibo/armv7-ultibo/rtl/bcm2836.o
../../../ultibo/armv7-ultibo/rtl/platform.o
../../../ultibo/armv7-ultibo/rtl/platformrpi2.o
../../../ultibo/armv7-ultibo/rtl/platformarm.o
../../../ultibo/armv7-ultibo/rtl/platformarmv7.o
../../../ultibo/armv7-ultibo/rtl/threads.o
../../../ultibo/armv7-ultibo/rtl/heapmanager.o
../../../ultibo/armv7-ultibo/rtl/dos.o
../../../ultibo/armv7-ultibo/rtl/sysutils.o
../../../ultibo/armv7-ultibo/rtl/sysconst.o
../../../ultibo/armv7-ultibo/rtl/locale.o
../../../ultibo/armv7-ultibo/rtl/unicode.o
../../../ultibo/armv7-ultibo/rtl/bcm2709.o
../../../ultibo/armv7-ultibo/rtl/classes.o
../../../ultibo/armv7-ultibo/rtl/ultibo.o
../../../ultibo/armv7-ultibo/rtl/filesystem.o
../../../ultibo/armv7-ultibo/rtl/mmc.o
../../../ultibo/armv7-ultibo/rtl/fatfs.o
../../../ultibo/armv7-ultibo/rtl/devices.o
../../../ultibo/armv7-ultibo/rtl/spi.o
../../../ultibo/armv7-ultibo/rtl/i2c.o
../../../ultibo/armv7-ultibo/rtl/dma.o
../../../ultibo/armv7-ultibo/rtl/pwm.o
../../../ultibo/armv7-ultibo/rtl/gpio.o
../../../ultibo/armv7-ultibo/rtl/uart.o
../../../ultibo/armv7-ultibo/rtl/serial.o
../../../ultibo/armv7-ultibo/rtl/framebuffer.o
../../../ultibo/armv7-ultibo/rtl/audio.o
../../../ultibo/armv7-ultibo/rtl/logging.o
../../../ultibo/armv7-ultibo/rtl/console.o
../../../ultibo/armv7-ultibo/rtl/font.o
../../../ultibo/armv7-ultibo/rtl/types.o
../../../ultibo/armv7-ultibo/rtl/math.o
../../../ultibo/armv7-ultibo/rtl/storage.o
../../../ultibo/armv7-ultibo/rtl/usb.o
../../../ultibo/armv7-ultibo/rtl/scsi.o
../../../ultibo/armv7-ultibo/rtl/codec.o
../../../ultibo/armv7-ultibo/rtl/typinfo.o
../../../ultibo/armv7-ultibo/rtl/rtlconsts.o
../../../ultibo/armv7-ultibo/rtl/timezone.o
../../../ultibo/armv7-ultibo/rtl/security.o
../../../ultibo/armv7-ultibo/rtl/ultiboutils.o
../../../ultibo/armv7-ultibo/rtl/ultiboclasses.o
libnimmain.a
)
ENTRY(_START)
SECTIONS
{
    .text 0x00008000:
    {
    _text_start = .;
    KEEP(*(.init, .init.*))
    *(.text, .text.*)
    *(.strings)
    *(.rodata, .rodata.*)
    *(.comment)
    _etext = .;
    }
    .preinit_array :
    {
    __preinit_array_start = .;
    KEEP(*(.preinit_array))
    __preinit_array_end = .;
    }
    .init_array :
    {
    __init_array_start = .;
    KEEP(*(.init_array))
    __init_array_end = .;
    }
    .fini_array :
    {
    __fini_array_start = .;
    KEEP(*(.fini_array))
    __fini_array_end = .;
    }
    .ctors :
    {
    __ctors_start = .;
    KEEP(*(SORT(.ctors.*)))
    KEEP(*(.ctors))
    __ctors_end = .;
    }
    .dtors :
    {
    __dtors_start = .;
    KEEP(*(SORT(.dtors.*)))
    KEEP(*(.dtors))
    __dtors_end = .;
    }
    .data ALIGN(4096):
    {
    _data = .;
    *(.data, .data.*)
    KEEP(*(.fpc .fpc.n_version .fpc.n_links))
    _edata = .;
    }
    .bss ALIGN(4096):
    {
    _bss_start = .;
    *(.bss, .bss.*)
    *(COMMON)
    }
    _bss_end = ALIGN(4096);
}
_end = .;
