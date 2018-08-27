	.file "nimprogram.lpr"
# Begin asmlist al_procedures

.section .text.n_p$nimprogram_$$_get_tick_count$$longint
	.balign 4
.globl	P$NIMPROGRAM_$$_GET_TICK_COUNT$$LONGINT
P$NIMPROGRAM_$$_GET_TICK_COUNT$$LONGINT:
.globl	get_tick_count
get_tick_count:
	stmfd	r13!,{r3,r14}
	bl	ULTIBO_$$_GETTICKCOUNT$$LONGWORD
	ldmfd	r13!,{r3,r15}
.Le0:
	.size	P$NIMPROGRAM_$$_GET_TICK_COUNT$$LONGINT, .Le0 - P$NIMPROGRAM_$$_GET_TICK_COUNT$$LONGINT

.section .text.n_p$nimprogram_$$_activity_led_enable
	.balign 4
.globl	P$NIMPROGRAM_$$_ACTIVITY_LED_ENABLE
P$NIMPROGRAM_$$_ACTIVITY_LED_ENABLE:
.globl	activity_led_enable
activity_led_enable:
	stmfd	r13!,{r3,r14}
	ldr	r0,.Lj7
	ldr	r0,[r0]
	cmp	r0,#0
	ldrne	r0,.Lj7
	ldrne	r0,[r0]
	blxne	r0
	ldmfd	r13!,{r3,r15}
.Lj7:
	.long	U_$PLATFORM_$$_ACTIVITYLEDENABLEHANDLER
.Le1:
	.size	P$NIMPROGRAM_$$_ACTIVITY_LED_ENABLE, .Le1 - P$NIMPROGRAM_$$_ACTIVITY_LED_ENABLE

.section .text.n_p$nimprogram_$$_activity_led_on
	.balign 4
.globl	P$NIMPROGRAM_$$_ACTIVITY_LED_ON
P$NIMPROGRAM_$$_ACTIVITY_LED_ON:
.globl	activity_led_on
activity_led_on:
	stmfd	r13!,{r3,r14}
	ldr	r0,.Lj13
	ldr	r0,[r0]
	cmp	r0,#0
	ldrne	r0,.Lj13
	ldrne	r0,[r0]
	blxne	r0
	ldmfd	r13!,{r3,r15}
.Lj13:
	.long	U_$PLATFORM_$$_ACTIVITYLEDONHANDLER
.Le2:
	.size	P$NIMPROGRAM_$$_ACTIVITY_LED_ON, .Le2 - P$NIMPROGRAM_$$_ACTIVITY_LED_ON

.section .text.n_p$nimprogram_$$_activity_led_off
	.balign 4
.globl	P$NIMPROGRAM_$$_ACTIVITY_LED_OFF
P$NIMPROGRAM_$$_ACTIVITY_LED_OFF:
.globl	activity_led_off
activity_led_off:
	stmfd	r13!,{r3,r14}
	ldr	r0,.Lj19
	ldr	r0,[r0]
	cmp	r0,#0
	ldrne	r0,.Lj19
	ldrne	r0,[r0]
	blxne	r0
	ldmfd	r13!,{r3,r15}
.Lj19:
	.long	U_$PLATFORM_$$_ACTIVITYLEDOFFHANDLER
.Le3:
	.size	P$NIMPROGRAM_$$_ACTIVITY_LED_OFF, .Le3 - P$NIMPROGRAM_$$_ACTIVITY_LED_OFF

.section .text.n_p$nimprogram_$$_log$ansistring
	.balign 4
.globl	P$NIMPROGRAM_$$_LOG$ANSISTRING
P$NIMPROGRAM_$$_LOG$ANSISTRING:
	stmfd	r13!,{r3,r14}
# Peephole Add/Sub to Preindexed done
	str	r0,[r13, #-128]!
	ldr	r0,[r13]
	bl	fpc_ansistr_incr_ref
	add	r2,r13,#4
	add	r1,r13,#16
	mov	r0,#1
	bl	fpc_pushexceptaddr
	bl	fpc_setjmp
	str	r0,[r13, #120]
	cmp	r0,#0
	bne	.Lj25
	ldr	r0,.Lj27
	ldr	r0,[r0]
	cmp	r0,#0
	ldrne	r0,[r13]
	ldrne	r1,.Lj27
	ldrne	r1,[r1]
	blxne	r1
.Lj25:
	bl	fpc_popaddrstack
	mov	r0,r13
	bl	fpc_ansistr_decr_ref
	ldr	r0,[r13, #120]
	cmp	r0,#0
	blne	fpc_reraise
	add	r13,r13,#128
	ldmfd	r13!,{r3,r15}
.Lj27:
	.long	U_$PLATFORM_$$_LOGGINGOUTPUTHANDLER
.Le4:
	.size	P$NIMPROGRAM_$$_LOG$ANSISTRING, .Le4 - P$NIMPROGRAM_$$_LOG$ANSISTRING

.section .text.n_p$nimprogram_$$_timetostring$tdatetime$$ansistring
	.balign 4
.globl	P$NIMPROGRAM_$$_TIMETOSTRING$TDATETIME$$ANSISTRING
P$NIMPROGRAM_$$_TIMETOSTRING$TDATETIME$$ANSISTRING:
	stmfd	r13!,{r4,r14}
	sub	r13,r13,#152
	add	r12,r13,#144
	vstm	r12,{d8}
	mov	r4,r0
	vmov.f64	d8,d0
	mov	r0,#0
	str	r0,[r13, #140]
# Peephole MovStrMov done
	str	r0,[r13, #136]
	mov	r2,r13
	add	r1,r13,#16
	mov	r0,#1
	bl	fpc_pushexceptaddr
	bl	fpc_setjmp
	str	r0,[r13, #120]
	cmp	r0,#0
	bne	.Lj33
	vmov.f64	d0,d8
	bl	fpc_trunc_real
	mov	r2,r0
	mov	r3,r1
	add	r0,r13,#136
	bl	SYSUTILS_$$_INTTOSTR$INT64$$ANSISTRING
	ldr	r0,[r13, #136]
	str	r0,[r13, #124]
	ldr	r0,.Lj35
	str	r0,[r13, #128]
	vmov.f64	d0,d8
	add	r0,r13,#140
	bl	SYSUTILS_$$_TIMETOSTR$TDATETIME$$ANSISTRING
	ldr	r0,[r13, #140]
	str	r0,[r13, #132]
	add	r1,r13,#124
	mov	r0,r4
	mov	r3,#0
	mov	r2,#2
	bl	fpc_ansistr_concat_multi
.Lj33:
	bl	fpc_popaddrstack
	add	r0,r13,#140
	bl	fpc_ansistr_decr_ref
	add	r0,r13,#136
	bl	fpc_ansistr_decr_ref
	ldr	r0,[r13, #120]
	cmp	r0,#0
	blne	fpc_reraise
	add	r12,r13,#144
	vldm	r12,{d8}
	add	r13,r13,#152
	ldmfd	r13!,{r4,r15}
.Lj35:
	.long	.Ld1
.Le5:
	.size	P$NIMPROGRAM_$$_TIMETOSTRING$TDATETIME$$ANSISTRING, .Le5 - P$NIMPROGRAM_$$_TIMETOSTRING$TDATETIME$$ANSISTRING

.section .text.n_p$nimprogram_$$_nimmainthread$pointer$$longint
	.balign 4
.globl	P$NIMPROGRAM_$$_NIMMAINTHREAD$POINTER$$LONGINT
P$NIMPROGRAM_$$_NIMMAINTHREAD$POINTER$$LONGINT:
	stmfd	r13!,{r4,r14}
	mov	r4,#0
	bl	nimMain
	mov	r0,#0
	bl	THREADS_$$_THREADHALT$LONGWORD$$LONGWORD
	mov	r0,r4
	ldmfd	r13!,{r4,r15}
.Le6:
	.size	P$NIMPROGRAM_$$_NIMMAINTHREAD$POINTER$$LONGINT, .Le6 - P$NIMPROGRAM_$$_NIMMAINTHREAD$POINTER$$LONGINT

.section .text.n_p$nimprogram_$$_startlogging
	.balign 4
.globl	P$NIMPROGRAM_$$_STARTLOGGING
P$NIMPROGRAM_$$_STARTLOGGING:
	stmfd	r13!,{r3,r14}
	mov	r0,#0
	ldr	r1,.Lj40
	str	r0,[r1]
	mvn	r0,#0
	ldr	r1,.Lj41
	str	r0,[r1]
	mvn	r0,#0
	ldr	r1,.Lj42
	str	r0,[r1]
	mov	r0,#6
	ldr	r1,.Lj43
	str	r0,[r1]
	bl	CONSOLE_$$_CONSOLEDEVICEGETDEFAULT$$PCONSOLEDEVICE
	bl	LOGGING_$$_LOGGINGCONSOLEDEVICEADD$PCONSOLEDEVICE$$LONGWORD
	mov	r0,#1
	bl	LOGGING_$$_LOGGINGDEVICEFINDBYTYPE$LONGWORD$$PLOGGINGDEVICE
	bl	LOGGING_$$_LOGGINGDEVICESETDEFAULT$PLOGGINGDEVICE$$LONGWORD
	ldmfd	r13!,{r3,r15}
.Lj40:
	.long	TC_$GLOBALCONFIG_$$_LOGGING_INCLUDE_COUNTER
.Lj41:
	.long	U_$GLOBALCONFIG_$$_LOGGING_INCLUDE_TICKCOUNT
.Lj42:
	.long	TC_$GLOBALCONFIG_$$_CONSOLE_REGISTER_LOGGING
.Lj43:
	.long	TC_$GLOBALCONFIG_$$_CONSOLE_LOGGING_POSITION
.Le7:
	.size	P$NIMPROGRAM_$$_STARTLOGGING, .Le7 - P$NIMPROGRAM_$$_STARTLOGGING

.section .text.n_main
	.balign 4
.globl	PASCALMAIN
PASCALMAIN:
.globl	main
main:
	stmfd	r13!,{r4,r5,r6,r14}
	sub	r13,r13,#152
	bl	fpc_initializeunits
	mov	r6,#0
	mov	r4,#0
	mov	r5,#0
	mov	r0,#0
	str	r0,[r13, #136]
# Peephole MovStrMov done
	str	r0,[r13, #124]
	mov	r2,r13
	add	r1,r13,#16
	mov	r0,#1
	bl	fpc_pushexceptaddr
	bl	fpc_setjmp
	str	r0,[r13, #120]
	cmp	r0,#0
	bne	.Lj44
	ldr	r0,.Lj46
	ldr	r0,[r0]
	cmp	r0,#0
	beq	.Lj48
	ldr	r0,.Lj46
	ldr	r0,[r0]
	blx	r0
	b	.Lj50
.Lj48:
	ldr	r1,.Lj51
	ldr	r0,[r1]
.Lj50:
	cmp	r0,#25
	beq	.Lj53
	b	.Lj55
	.balign 4
.Lj54:
	mov	r0,#100
	bl	THREADS_$$_THREADSLEEP$LONGWORD$$LONGWORD
.Lj55:
	ldr	r0,.Lj57
	bl	SYSUTILS_$$_DIRECTORYEXISTS$RAWBYTESTRING$$BOOLEAN
	cmp	r0,#0
	beq	.Lj54
	ldr	r0,.Lj58
	bl	SYSUTILS_$$_FILEEXISTS$RAWBYTESTRING$$BOOLEAN
	cmp	r0,#0
	beq	.Lj60
	mov	r2,#0
	ldr	r1,.Lj61
	ldr	r0,.Lj62
	bl	ULTIBO_$$_COPYFILEA$PCHAR$PCHAR$LONGBOOL$$LONGBOOL
	mov	r1,r0
.Lj60:
.Lj53:
	bl	P$NIMPROGRAM_$$_STARTLOGGING
	mov	r0,#0
	bl	P$NIMPROGRAM_$$_LOG$ANSISTRING
	ldr	r0,.Lj63
	bl	P$NIMPROGRAM_$$_LOG$ANSISTRING
	bl	CONSOLE_$$_CONSOLEDEVICEGETDEFAULT$$PCONSOLEDEVICE
	mov	r2,#1
	mov	r1,#5
	bl	CONSOLE_$$_CONSOLEWINDOWCREATE$PCONSOLEDEVICE$LONGWORD$BOOLEAN$$LONGINT
	mov	r6,r0
	bl	CONSOLE_$$_CONSOLEDEVICEGETDEFAULT$$PCONSOLEDEVICE
	mov	r2,#0
	mov	r1,#7
	bl	CONSOLE_$$_CONSOLEWINDOWCREATE$PCONSOLEDEVICE$LONGWORD$BOOLEAN$$LONGINT
	mov	r4,r0
	bl	CONSOLE_$$_CONSOLEDEVICEGETDEFAULT$$PCONSOLEDEVICE
	mov	r2,#0
	mov	r1,#8
	bl	CONSOLE_$$_CONSOLEWINDOWCREATE$PCONSOLEDEVICE$LONGWORD$BOOLEAN$$LONGINT
	mov	r5,r0
	mov	r0,r6
	mov	r1,#-16777216
	bl	CONSOLE_$$_CONSOLEWINDOWSETBACKCOLOR$LONGINT$LONGWORD$$LONGWORD
	mvn	r1,#255
	mov	r0,r6
	bl	CONSOLE_$$_CONSOLEWINDOWSETFORECOLOR$LONGINT$LONGWORD$$LONGWORD
	mvn	r1,#16711680
	mov	r0,r4
	bl	CONSOLE_$$_CONSOLEWINDOWSETBACKCOLOR$LONGINT$LONGWORD$$LONGWORD
	mov	r1,#-16777216
	orr	r1,r1,#65280
	mov	r0,r5
	bl	CONSOLE_$$_CONSOLEWINDOWSETFORECOLOR$LONGINT$LONGWORD$$LONGWORD
	mov	r0,r6
	bl	CONSOLE_$$_CONSOLEWINDOWCLEAR$LONGINT$$LONGWORD
	mov	r0,r4
	bl	CONSOLE_$$_CONSOLEWINDOWCLEAR$LONGINT$$LONGWORD
	mov	r0,r5
	bl	CONSOLE_$$_CONSOLEWINDOWCLEAR$LONGINT$$LONGWORD
	ldr	r0,.Lj64
	ldr	r1,.Lj65
	ldr	r3,[r1]
	ldr	r2,.Lj66
	mov	r1,#0
	bl	SYSTEM_$$_BEGINTHREAD$TTHREADFUNC$POINTER$LONGINT$LONGWORD$$LONGINT
	.balign 4
.Lj67:
	mov	r0,#900
	bl	THREADS_$$_THREADSLEEP$LONGWORD$$LONGWORD
	mov	r0,r6
	mov	r2,#1
	mov	r1,#1
	bl	CONSOLE_$$_CONSOLEWINDOWSETXY$LONGINT$LONGWORD$LONGWORD$$LONGWORD
	mov	r0,r6
	mov	r1,#0
	bl	CONSOLE_$$_CONSOLEWINDOWWRITELN$LONGINT$ANSISTRING$$LONGWORD
	add	r0,r13,#140
	bl	ULTIBO_$$_UPTIME$$FILETIME
	add	r0,r13,#140
	bl	ULTIBO_$$_SYSTEMFILETIMETODATETIME$FILETIME$$TDATETIME
	add	r0,r13,#136
	bl	P$NIMPROGRAM_$$_TIMETOSTRING$TDATETIME$$ANSISTRING
	ldr	r0,[r13, #136]
	str	r0,[r13, #132]
	mov	r0,#11
	str	r0,[r13, #128]
	add	r2,r13,#128
	mov	r3,#0
	ldr	r1,.Lj70
	add	r0,r13,#124
	bl	SYSUTILS_$$_FORMAT$ANSISTRING$array_of_const$$ANSISTRING
	ldr	r1,[r13, #124]
	mov	r0,r6
	bl	CONSOLE_$$_CONSOLEWINDOWWRITELN$LONGINT$ANSISTRING$$LONGWORD
	b	.Lj67
.Lj44:
	bl	fpc_popaddrstack
	add	r0,r13,#136
	bl	fpc_ansistr_decr_ref
	add	r0,r13,#124
	bl	fpc_ansistr_decr_ref
	ldr	r0,[r13, #120]
	cmp	r0,#0
	blne	fpc_reraise
	bl	fpc_do_exit
	add	r13,r13,#152
	ldmfd	r13!,{r4,r5,r6,r15}
.Lj46:
	.long	U_$PLATFORM_$$_BOARDGETTYPEHANDLER
.Lj51:
	.long	U_$GLOBALCONFIG_$$_BOARD_TYPE
.Lj57:
	.long	.Ld2
.Lj58:
	.long	.Ld3
.Lj61:
	.long	_$NIMPROGRAM$_Ld4
.Lj62:
	.long	_$NIMPROGRAM$_Ld5
.Lj63:
	.long	.Ld6
.Lj64:
	.long	P$NIMPROGRAM_$$_NIMMAINTHREAD$POINTER$$LONGINT
.Lj65:
	.long	TC_$GLOBALCONFIG_$$_THREAD_STACK_DEFAULT_SIZE
.Lj66:
	.long	TC_$P$NIMPROGRAM_$$_NIMMAINTHREADHANDLE
.Lj70:
	.long	.Ld7
.Le8:
	.size	main, .Le8 - main
# End asmlist al_procedures
# Begin asmlist al_globals

.section .bss.n_u_$p$nimprogram_$$_console1
	.balign 4
	.size U_$P$NIMPROGRAM_$$_CONSOLE1,4
U_$P$NIMPROGRAM_$$_CONSOLE1:
	.zero 4

.section .bss.n_u_$p$nimprogram_$$_console2
	.balign 4
	.size U_$P$NIMPROGRAM_$$_CONSOLE2,4
U_$P$NIMPROGRAM_$$_CONSOLE2:
	.zero 4

.section .bss.n_u_$p$nimprogram_$$_console3
	.balign 4
	.size U_$P$NIMPROGRAM_$$_CONSOLE3,4
U_$P$NIMPROGRAM_$$_CONSOLE3:
	.zero 4

.section .data.n_INITFINAL
	.balign 4
.globl	INITFINAL
INITFINAL:
	.long	68,0
	.long	INIT$_$SYSTEM
	.long	0,0
	.long	FINALIZE$_$OBJPAS
	.long	INIT$_$GLOBALCONFIG
	.long	FINALIZE$_$GLOBALCONFIG
	.long	INIT$_$HEAPMANAGER
	.long	0
	.long	INIT$_$DOS
	.long	0
	.long	SYSUTILS$_$TENCODING_$__$$_create
	.long	SYSUTILS$_$TENCODING_$__$$_destroy
	.long	INIT$_$SYSUTILS
	.long	FINALIZE$_$SYSUTILS
	.long	INIT$_$PLATFORM
	.long	FINALIZE$_$PLATFORM
	.long	INIT$_$LOCALE
	.long	0
	.long	INIT$_$UNICODE
	.long	0
	.long	INIT$_$THREADS
	.long	FINALIZE$_$THREADS
	.long	INIT$_$DEVICES
	.long	FINALIZE$_$DEVICES
	.long	INIT$_$DMA
	.long	0
	.long	INIT$_$FRAMEBUFFER
	.long	0
	.long	INIT$_$FONT
	.long	0
	.long	INIT$_$CONSOLE
	.long	0
	.long	INIT$_$LOGGING
	.long	FINALIZE$_$LOGGING
	.long	INIT$_$SERIAL
	.long	0
	.long	INIT$_$UART
	.long	0
	.long	INIT$_$RTC
	.long	0
	.long	INIT$_$USB
	.long	FINALIZE$_$USB
	.long	INIT$_$SCSI
	.long	0
	.long	INIT$_$STORAGE
	.long	FINALIZE$_$STORAGE
	.long	INIT$_$MMC
	.long	FINALIZE$_$MMC
	.long	INIT$_$PL18X
	.long	FINALIZE$_$PL18X
	.long	INIT$_$TYPINFO
	.long	FINALIZE$_$TYPINFO
	.long	INIT$_$CLASSES
	.long	FINALIZE$_$CLASSES
	.long	INIT$_$TIMEZONE
	.long	0
	.long	INIT$_$ULTIBO
	.long	FINALIZE$_$ULTIBO
	.long	INIT$_$NETWORK
	.long	FINALIZE$_$NETWORK
	.long	INIT$_$SMC91X
	.long	FINALIZE$_$SMC91X
	.long	INIT$_$KEYMAP
	.long	0
	.long	INIT$_$KEYBOARD
	.long	FINALIZE$_$KEYBOARD
	.long	INIT$_$MOUSE
	.long	FINALIZE$_$MOUSE
	.long	INIT$_$FILESYSTEM
	.long	FINALIZE$_$FILESYSTEM
	.long	INIT$_$EXTFS
	.long	FINALIZE$_$EXTFS
	.long	INIT$_$FATFS
	.long	FINALIZE$_$FATFS
	.long	INIT$_$NTFSCONST
	.long	FINALIZE$_$NTFSCONST
	.long	INIT$_$NTFSUTILS
	.long	FINALIZE$_$NTFSUTILS
	.long	INIT$_$NTFS
	.long	FINALIZE$_$NTFS
	.long	INIT$_$CDFS
	.long	FINALIZE$_$CDFS
	.long	INIT$_$VIRTUALDISK
	.long	FINALIZE$_$VIRTUALDISK
	.long	INIT$_$TRANSPORT
	.long	0
	.long	INIT$_$PROTOCOL
	.long	0
	.long	INIT$_$LOOPBACK
	.long	0
	.long	INIT$_$ARP
	.long	0
	.long	INIT$_$IP
	.long	0
	.long	INIT$_$IPV6
	.long	0
	.long	INIT$_$ICMP
	.long	0
	.long	INIT$_$ICMPV6
	.long	0
	.long	INIT$_$UDP
	.long	0
	.long	INIT$_$TCP
	.long	0
	.long	INIT$_$IGMP
	.long	0
	.long	INIT$_$RAW
	.long	0
	.long	INIT$_$DHCP
	.long	0
	.long	INIT$_$DNS
	.long	0
	.long	INIT$_$SOCKETS
	.long	0
	.long	INIT$_$WINSOCK2
	.long	0
	.long	INIT$_$CRYPTO
	.long	FINALIZE$_$CRYPTO
	.long	INIT$_$AUTHENTICATION
	.long	0
	.long	INIT$_$SERVICES
	.long	0
	.long	INIT$_$QEMUVERSATILEPB
	.long	0
	.long	INIT$_$HTTP
	.long	FINALIZE$_$HTTP
	.long	0
	.long	FINALIZE$_$IPHLPAPI
	.long	INIT$_$WEBSTATUS
	.long	FINALIZE$_$WEBSTATUS
	.long	INIT$_$DWCOTG
	.long	0
	.long	INIT$_$SMSC95XX
	.long	0
	.long	INIT$_$LAN78XX
	.long	0
.Le9:
	.size	INITFINAL, .Le9 - INITFINAL

.section .data.n_FPC_THREADVARTABLES
	.balign 4
.globl	FPC_THREADVARTABLES
FPC_THREADVARTABLES:
	.long	5
	.long	THREADVARLIST_$SYSTEM
	.long	THREADVARLIST_$DOS
	.long	THREADVARLIST_$LOGGING
	.long	THREADVARLIST_$CLASSES
	.long	THREADVARLIST_$NETWORK
.Le10:
	.size	FPC_THREADVARTABLES, .Le10 - FPC_THREADVARTABLES

.section .rodata.n_FPC_RESOURCESTRINGTABLES
	.balign 4
.globl	FPC_RESOURCESTRINGTABLES
FPC_RESOURCESTRINGTABLES:
	.long	3
	.long	RESSTR_$SYSCONST_$$_START
	.long	RESSTR_$SYSCONST_$$_END
	.long	RESSTR_$MATH_$$_START
	.long	RESSTR_$MATH_$$_END
	.long	RESSTR_$RTLCONSTS_$$_START
	.long	RESSTR_$RTLCONSTS_$$_END
.Le11:
	.size	FPC_RESOURCESTRINGTABLES, .Le11 - FPC_RESOURCESTRINGTABLES

.section .data.n_FPC_WIDEINITTABLES
	.balign 4
.globl	FPC_WIDEINITTABLES
FPC_WIDEINITTABLES:
	.long	0
.Le12:
	.size	FPC_WIDEINITTABLES, .Le12 - FPC_WIDEINITTABLES

.section .data.n_FPC_RESSTRINITTABLES
	.balign 4
.globl	FPC_RESSTRINITTABLES
FPC_RESSTRINITTABLES:
	.long	0
.Le13:
	.size	FPC_RESSTRINITTABLES, .Le13 - FPC_RESSTRINITTABLES

.section .fpc.n_version
	.balign 8
__fpc_ident:
	.ascii	"FPC 3.1.1 [2018/08/07] for arm - ultibo"
.Le14:
	.size	__fpc_ident, .Le14 - __fpc_ident

.section .data.n___stklen
	.balign 4
.globl	__stklen
__stklen:
	.long	262144
.Le15:
	.size	__stklen, .Le15 - __stklen

.section .data.n___heapsize
	.balign 4
.globl	__heapsize
__heapsize:
	.long	256
.Le16:
	.size	__heapsize, .Le16 - __heapsize

.section .bss.n___fpc_initialheap
	.balign 8
	.globl __fpc_initialheap
	.size __fpc_initialheap,256
__fpc_initialheap:
	.zero 256

.section .data.n___fpc_valgrind
	.balign 4
.globl	__fpc_valgrind
__fpc_valgrind:
	.byte	0
.Le17:
	.size	__fpc_valgrind, .Le17 - __fpc_valgrind
# End asmlist al_globals
# Begin asmlist al_typedconsts

.section .data.n_TC_$P$NIMPROGRAM_$$_NIMMAINTHREADHANDLE
	.balign 4
TC_$P$NIMPROGRAM_$$_NIMMAINTHREADHANDLE:
	.long	-1
.Le18:
	.size	TC_$P$NIMPROGRAM_$$_NIMMAINTHREADHANDLE, .Le18 - TC_$P$NIMPROGRAM_$$_NIMMAINTHREADHANDLE

.section .rodata.n_.Ld1
	.balign 4
.Ld1$strlab:
	.short	0,1
	.long	-1,6
.Ld1:
	.ascii	" days \000"
.Le19:
	.size	.Ld1$strlab, .Le19 - .Ld1$strlab

.section .rodata.n_.Ld2
	.balign 4
.Ld2$strlab:
	.short	0,1
	.long	-1,3
.Ld2:
	.ascii	"C:\\\000"
.Le20:
	.size	.Ld2$strlab, .Le20 - .Ld2$strlab

.section .rodata.n_.Ld3
	.balign 4
.Ld3$strlab:
	.short	0,1
	.long	-1,18
.Ld3:
	.ascii	"default-config.txt\000"
.Le21:
	.size	.Ld3$strlab, .Le21 - .Ld3$strlab

.section .rodata.n__$NIMPROGRAM$_Ld4
	.balign 4
.globl	_$NIMPROGRAM$_Ld4
_$NIMPROGRAM$_Ld4:
	.ascii	"config.txt\000"
.Le22:
	.size	_$NIMPROGRAM$_Ld4, .Le22 - _$NIMPROGRAM$_Ld4

.section .rodata.n__$NIMPROGRAM$_Ld5
	.balign 4
.globl	_$NIMPROGRAM$_Ld5
_$NIMPROGRAM$_Ld5:
	.ascii	"default-config.txt\000"
.Le23:
	.size	_$NIMPROGRAM$_Ld5, .Le23 - _$NIMPROGRAM$_Ld5

.section .rodata.n_.Ld6
	.balign 4
.Ld6$strlab:
	.short	0,1
	.long	-1,18
.Ld6:
	.ascii	"NimProgram started\000"
.Le24:
	.size	.Ld6$strlab, .Le24 - .Ld6$strlab

.section .rodata.n_.Ld7
	.balign 4
.Ld7$strlab:
	.short	0,1
	.long	-1,5
.Ld7:
	.ascii	"Up %s\000"
.Le25:
	.size	.Ld7$strlab, .Le25 - .Ld7$strlab
# End asmlist al_typedconsts
# Begin asmlist al_rtti

.section .rodata.n_RTTI_$P$NIMPROGRAM_$$_def00000004
	.balign 4
.globl	RTTI_$P$NIMPROGRAM_$$_def00000004
RTTI_$P$NIMPROGRAM_$$_def00000004:
	.byte	12,0,0,0
	.long	12,3
	.long	RTTI_$SYSTEM_$$_RAWBYTESTRING
	.byte	1,0,0,0
	.long	RTTI_$SYSTEM_$$_LONGINT
.Le26:
	.size	RTTI_$P$NIMPROGRAM_$$_def00000004, .Le26 - RTTI_$P$NIMPROGRAM_$$_def00000004
# End asmlist al_rtti

