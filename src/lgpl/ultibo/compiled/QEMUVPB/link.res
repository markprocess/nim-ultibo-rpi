INPUT (
../../../../../lib/armv7-ultibo/rtl/bootqemuvpb.o
ultiboprogram.o
../../../../../lib/armv7-ultibo/rtl/system.o
../../../../../lib/armv7-ultibo/rtl/objpas.o
../../../../../lib/armv7-ultibo/rtl/globalconfig.o
../../../../../lib/armv7-ultibo/rtl/globalconst.o
../../../../../lib/armv7-ultibo/rtl/globaltypes.o
../../../../../lib/armv7-ultibo/rtl/versatilepb.o
../../../../../lib/armv7-ultibo/rtl/platform.o
../../../../../lib/armv7-ultibo/rtl/platformqemuvpb.o
../../../../../lib/armv7-ultibo/rtl/platformarm.o
../../../../../lib/armv7-ultibo/rtl/platformarmv7.o
../../../../../lib/armv7-ultibo/rtl/threads.o
../../../../../lib/armv7-ultibo/rtl/heapmanager.o
../../../../../lib/armv7-ultibo/rtl/dos.o
../../../../../lib/armv7-ultibo/rtl/sysutils.o
../../../../../lib/armv7-ultibo/rtl/sysconst.o
../../../../../lib/armv7-ultibo/rtl/locale.o
../../../../../lib/armv7-ultibo/rtl/unicode.o
../../../../../lib/armv7-ultibo/rtl/QEMUVersatilePB.o
../../../../../lib/armv7-ultibo/rtl/classes.o
../../../../../lib/armv7-ultibo/rtl/ultibo.o
../../../../../lib/armv7-ultibo/rtl/filesystem.o
../../../../../lib/armv7-ultibo/rtl/mmc.o
../../../../../lib/armv7-ultibo/rtl/fatfs.o
../../../../../lib/armv7-ultibo/rtl/devices.o
../../../../../lib/armv7-ultibo/rtl/dma.o
../../../../../lib/armv7-ultibo/rtl/serial.o
../../../../../lib/armv7-ultibo/rtl/uart.o
../../../../../lib/armv7-ultibo/rtl/pl011.o
../../../../../lib/armv7-ultibo/rtl/rtc.o
../../../../../lib/armv7-ultibo/rtl/pl031.o
../../../../../lib/armv7-ultibo/rtl/pl18x.o
../../../../../lib/armv7-ultibo/rtl/usb.o
../../../../../lib/armv7-ultibo/rtl/network.o
../../../../../lib/armv7-ultibo/rtl/smc91x.o
../../../../../lib/armv7-ultibo/rtl/framebuffer.o
../../../../../lib/armv7-ultibo/rtl/pl110.o
../../../../../lib/armv7-ultibo/rtl/console.o
../../../../../lib/armv7-ultibo/rtl/keyboard.o
../../../../../lib/armv7-ultibo/rtl/mouse.o
../../../../../lib/armv7-ultibo/rtl/ps2.o
../../../../../lib/armv7-ultibo/rtl/pl050.o
../../../../../lib/armv7-ultibo/rtl/extfs.o
../../../../../lib/armv7-ultibo/rtl/ntfs.o
../../../../../lib/armv7-ultibo/rtl/cdfs.o
../../../../../lib/armv7-ultibo/rtl/virtualdisk.o
../../../../../lib/armv7-ultibo/rtl/logging.o
../../../../../lib/armv7-ultibo/rtl/sockets.o
../../../../../lib/armv7-ultibo/rtl/winsock2.o
../../../../../lib/armv7-ultibo/rtl/services.o
../../../../../lib/armv7-ultibo/rtl/font.o
../../../../../lib/armv7-ultibo/rtl/types.o
../../../../../lib/armv7-ultibo/rtl/math.o
../../../../../lib/armv7-ultibo/rtl/storage.o
../../../../../lib/armv7-ultibo/rtl/scsi.o
../../../../../lib/armv7-ultibo/rtl/globalsock.o
../../../../../lib/armv7-ultibo/rtl/ultiboclasses.o
../../../../../lib/armv7-ultibo/rtl/typinfo.o
../../../../../lib/armv7-ultibo/rtl/rtlconsts.o
../../../../../lib/armv7-ultibo/rtl/timezone.o
../../../../../lib/armv7-ultibo/rtl/security.o
../../../../../lib/armv7-ultibo/rtl/keymap.o
../../../../../lib/armv7-ultibo/rtl/ultiboutils.o
../../../../../lib/armv7-ultibo/rtl/ntfsconst.o
../../../../../lib/armv7-ultibo/rtl/ntfstypes.o
../../../../../lib/armv7-ultibo/rtl/ntfsclass.o
../../../../../lib/armv7-ultibo/rtl/ntfsutils.o
../../../../../lib/armv7-ultibo/rtl/transport.o
../../../../../lib/armv7-ultibo/rtl/protocol.o
../../../../../lib/armv7-ultibo/rtl/loopback.o
../../../../../lib/armv7-ultibo/rtl/arp.o
../../../../../lib/armv7-ultibo/rtl/ip.o
../../../../../lib/armv7-ultibo/rtl/ipv6.o
../../../../../lib/armv7-ultibo/rtl/udp.o
../../../../../lib/armv7-ultibo/rtl/tcp.o
../../../../../lib/armv7-ultibo/rtl/icmp.o
../../../../../lib/armv7-ultibo/rtl/icmpv6.o
../../../../../lib/armv7-ultibo/rtl/igmp.o
../../../../../lib/armv7-ultibo/rtl/raw.o
../../../../../lib/armv7-ultibo/rtl/dhcp.o
../../../../../lib/armv7-ultibo/rtl/dns.o
../../../../../lib/armv7-ultibo/rtl/crypto.o
../../../../../lib/armv7-ultibo/rtl/authentication.o
../../../../../lib/armv7-ultibo/rtl/bigint.o
libnimmain.a
)
ENTRY(_START)
SECTIONS
{
    .text 0x00010000:
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
