INPUT (
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/bootrpi2.o
ultiboprogram.o
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/system.o
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/objpas.o
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/globalconfig.o
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/globalconst.o
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/globaltypes.o
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/bcm2836.o
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/platform.o
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/platformrpi2.o
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/platformarm.o
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/platformarmv7.o
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/threads.o
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/heapmanager.o
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/dos.o
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/sysutils.o
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/sysconst.o
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/locale.o
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/unicode.o
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/bcm2709.o
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/classes.o
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/ultibo.o
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/filesystem.o
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/mmc.o
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/fatfs.o
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/serial.o
bcmfw.o
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/devices.o
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/spi.o
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/i2c.o
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/dma.o
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/pwm.o
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/gpio.o
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/uart.o
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/framebuffer.o
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/audio.o
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/logging.o
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/console.o
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/font.o
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/types.o
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/math.o
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/storage.o
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/usb.o
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/scsi.o
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/codec.o
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/typinfo.o
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/rtlconsts.o
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/timezone.o
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/security.o
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/ultiboutils.o
../../../ultibo/core/fpc/units/armv7-ultibo/rtl/ultiboclasses.o
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
