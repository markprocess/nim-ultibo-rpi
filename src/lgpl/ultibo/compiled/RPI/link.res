INPUT (
../../../../../lib/armv6-ultibo/rtl/bootrpi.o
ultiboprogram.o
../../../../../lib/armv6-ultibo/rtl/system.o
../../../../../lib/armv6-ultibo/rtl/objpas.o
../../../../../lib/armv6-ultibo/rtl/globalconfig.o
../../../../../lib/armv6-ultibo/rtl/globalconst.o
../../../../../lib/armv6-ultibo/rtl/globaltypes.o
../../../../../lib/armv6-ultibo/rtl/bcm2835.o
../../../../../lib/armv6-ultibo/rtl/platform.o
../../../../../lib/armv6-ultibo/rtl/platformrpi.o
../../../../../lib/armv6-ultibo/rtl/platformarm.o
../../../../../lib/armv6-ultibo/rtl/platformarmv6.o
../../../../../lib/armv6-ultibo/rtl/threads.o
../../../../../lib/armv6-ultibo/rtl/heapmanager.o
../../../../../lib/armv6-ultibo/rtl/dos.o
../../../../../lib/armv6-ultibo/rtl/sysutils.o
../../../../../lib/armv6-ultibo/rtl/sysconst.o
../../../../../lib/armv6-ultibo/rtl/locale.o
../../../../../lib/armv6-ultibo/rtl/unicode.o
../../../../../lib/armv6-ultibo/rtl/bcm2708.o
../../../../../lib/armv6-ultibo/rtl/classes.o
../../../../../lib/armv6-ultibo/rtl/ultibo.o
../../../../../lib/armv6-ultibo/rtl/filesystem.o
../../../../../lib/armv6-ultibo/rtl/mmc.o
../../../../../lib/armv6-ultibo/rtl/fatfs.o
../../../../../lib/armv6-ultibo/rtl/devices.o
../../../../../lib/armv6-ultibo/rtl/spi.o
../../../../../lib/armv6-ultibo/rtl/i2c.o
../../../../../lib/armv6-ultibo/rtl/dma.o
../../../../../lib/armv6-ultibo/rtl/pwm.o
../../../../../lib/armv6-ultibo/rtl/gpio.o
../../../../../lib/armv6-ultibo/rtl/uart.o
../../../../../lib/armv6-ultibo/rtl/serial.o
../../../../../lib/armv6-ultibo/rtl/framebuffer.o
../../../../../lib/armv6-ultibo/rtl/audio.o
../../../../../lib/armv6-ultibo/rtl/logging.o
../../../../../lib/armv6-ultibo/rtl/console.o
../../../../../lib/armv6-ultibo/rtl/font.o
../../../../../lib/armv6-ultibo/rtl/types.o
../../../../../lib/armv6-ultibo/rtl/math.o
../../../../../lib/armv6-ultibo/rtl/storage.o
../../../../../lib/armv6-ultibo/rtl/usb.o
../../../../../lib/armv6-ultibo/rtl/scsi.o
../../../../../lib/armv6-ultibo/rtl/codec.o
../../../../../lib/armv6-ultibo/rtl/typinfo.o
../../../../../lib/armv6-ultibo/rtl/rtlconsts.o
../../../../../lib/armv6-ultibo/rtl/timezone.o
../../../../../lib/armv6-ultibo/rtl/security.o
../../../../../lib/armv6-ultibo/rtl/ultiboutils.o
../../../../../lib/armv6-ultibo/rtl/ultiboclasses.o
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
