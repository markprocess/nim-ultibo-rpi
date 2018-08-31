INPUT (
../../../ultibo/armv6-ultibo/rtl/bootrpi.o
ultiboprogram.o
../../../ultibo/armv6-ultibo/rtl/system.o
../../../ultibo/armv6-ultibo/rtl/objpas.o
../../../ultibo/armv6-ultibo/rtl/globalconfig.o
../../../ultibo/armv6-ultibo/rtl/globalconst.o
../../../ultibo/armv6-ultibo/rtl/globaltypes.o
../../../ultibo/armv6-ultibo/rtl/bcm2835.o
../../../ultibo/armv6-ultibo/rtl/platform.o
../../../ultibo/armv6-ultibo/rtl/platformrpi.o
../../../ultibo/armv6-ultibo/rtl/platformarm.o
../../../ultibo/armv6-ultibo/rtl/platformarmv6.o
../../../ultibo/armv6-ultibo/rtl/threads.o
../../../ultibo/armv6-ultibo/rtl/heapmanager.o
../../../ultibo/armv6-ultibo/rtl/dos.o
../../../ultibo/armv6-ultibo/rtl/sysutils.o
../../../ultibo/armv6-ultibo/rtl/sysconst.o
../../../ultibo/armv6-ultibo/rtl/locale.o
../../../ultibo/armv6-ultibo/rtl/unicode.o
../../../ultibo/armv6-ultibo/rtl/bcm2708.o
../../../ultibo/armv6-ultibo/rtl/classes.o
../../../ultibo/armv6-ultibo/rtl/ultibo.o
../../../ultibo/armv6-ultibo/rtl/filesystem.o
../../../ultibo/armv6-ultibo/rtl/mmc.o
../../../ultibo/armv6-ultibo/rtl/fatfs.o
../../../ultibo/armv6-ultibo/rtl/devices.o
../../../ultibo/armv6-ultibo/rtl/spi.o
../../../ultibo/armv6-ultibo/rtl/i2c.o
../../../ultibo/armv6-ultibo/rtl/dma.o
../../../ultibo/armv6-ultibo/rtl/pwm.o
../../../ultibo/armv6-ultibo/rtl/gpio.o
../../../ultibo/armv6-ultibo/rtl/uart.o
../../../ultibo/armv6-ultibo/rtl/serial.o
../../../ultibo/armv6-ultibo/rtl/framebuffer.o
../../../ultibo/armv6-ultibo/rtl/audio.o
../../../ultibo/armv6-ultibo/rtl/logging.o
../../../ultibo/armv6-ultibo/rtl/console.o
../../../ultibo/armv6-ultibo/rtl/font.o
../../../ultibo/armv6-ultibo/rtl/types.o
../../../ultibo/armv6-ultibo/rtl/math.o
../../../ultibo/armv6-ultibo/rtl/storage.o
../../../ultibo/armv6-ultibo/rtl/usb.o
../../../ultibo/armv6-ultibo/rtl/scsi.o
../../../ultibo/armv6-ultibo/rtl/codec.o
../../../ultibo/armv6-ultibo/rtl/typinfo.o
../../../ultibo/armv6-ultibo/rtl/rtlconsts.o
../../../ultibo/armv6-ultibo/rtl/timezone.o
../../../ultibo/armv6-ultibo/rtl/security.o
../../../ultibo/armv6-ultibo/rtl/ultiboutils.o
../../../ultibo/armv6-ultibo/rtl/ultiboclasses.o
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
