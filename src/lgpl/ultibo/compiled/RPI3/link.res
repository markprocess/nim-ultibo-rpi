INPUT (
../../../../../lib/armv7-ultibo/rtl/bootrpi3.o
ultiboprogram.o
../../../../../lib/armv7-ultibo/rtl/system.o
../../../../../lib/armv7-ultibo/rtl/objpas.o
../../../../../lib/armv7-ultibo/rtl/globalconfig.o
../../../../../lib/armv7-ultibo/rtl/globalconst.o
../../../../../lib/armv7-ultibo/rtl/globaltypes.o
../../../../../lib/armv7-ultibo/rtl/bcm2837.o
../../../../../lib/armv7-ultibo/rtl/platform.o
../../../../../lib/armv7-ultibo/rtl/platformrpi3.o
../../../../../lib/armv7-ultibo/rtl/platformarm.o
../../../../../lib/armv7-ultibo/rtl/platformarmv8.o
../../../../../lib/armv7-ultibo/rtl/threads.o
../../../../../lib/armv7-ultibo/rtl/heapmanager.o
../../../../../lib/armv7-ultibo/rtl/dos.o
../../../../../lib/armv7-ultibo/rtl/sysutils.o
../../../../../lib/armv7-ultibo/rtl/sysconst.o
../../../../../lib/armv7-ultibo/rtl/locale.o
../../../../../lib/armv7-ultibo/rtl/unicode.o
../../../../../lib/armv7-ultibo/rtl/bcm2710.o
../../../../../lib/armv7-ultibo/rtl/classes.o
../../../../../lib/armv7-ultibo/rtl/ultibo.o
../../../../../lib/armv7-ultibo/rtl/filesystem.o
../../../../../lib/armv7-ultibo/rtl/mmc.o
../../../../../lib/armv7-ultibo/rtl/fatfs.o
../../../../../lib/armv7-ultibo/rtl/devices.o
../../../../../lib/armv7-ultibo/rtl/spi.o
../../../../../lib/armv7-ultibo/rtl/i2c.o
../../../../../lib/armv7-ultibo/rtl/dma.o
../../../../../lib/armv7-ultibo/rtl/pwm.o
../../../../../lib/armv7-ultibo/rtl/gpio.o
../../../../../lib/armv7-ultibo/rtl/uart.o
../../../../../lib/armv7-ultibo/rtl/serial.o
../../../../../lib/armv7-ultibo/rtl/framebuffer.o
../../../../../lib/armv7-ultibo/rtl/audio.o
../../../../../lib/armv7-ultibo/rtl/logging.o
../../../../../lib/armv7-ultibo/rtl/console.o
../../../../../lib/armv7-ultibo/rtl/font.o
../../../../../lib/armv7-ultibo/rtl/types.o
../../../../../lib/armv7-ultibo/rtl/math.o
../../../../../lib/armv7-ultibo/rtl/storage.o
../../../../../lib/armv7-ultibo/rtl/usb.o
../../../../../lib/armv7-ultibo/rtl/scsi.o
../../../../../lib/armv7-ultibo/rtl/codec.o
../../../../../lib/armv7-ultibo/rtl/typinfo.o
../../../../../lib/armv7-ultibo/rtl/rtlconsts.o
../../../../../lib/armv7-ultibo/rtl/timezone.o
../../../../../lib/armv7-ultibo/rtl/security.o
../../../../../lib/armv7-ultibo/rtl/ultiboutils.o
../../../../../lib/armv7-ultibo/rtl/ultiboclasses.o
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
