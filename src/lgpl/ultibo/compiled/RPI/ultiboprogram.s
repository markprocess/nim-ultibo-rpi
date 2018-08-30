	.file "ultiboprogram.lpr"
# Begin asmlist al_procedures

.section .text.n_p$ultiboprogram_$$_get_tick_count$$longint
	.balign 4
.globl	P$ULTIBOPROGRAM_$$_GET_TICK_COUNT$$LONGINT
P$ULTIBOPROGRAM_$$_GET_TICK_COUNT$$LONGINT:
.globl	get_tick_count
get_tick_count:
	stmfd	r13!,{r3,r14}
	bl	ULTIBO_$$_GETTICKCOUNT$$LONGWORD
	ldmfd	r13!,{r3,r15}
.Le0:
	.size	P$ULTIBOPROGRAM_$$_GET_TICK_COUNT$$LONGINT, .Le0 - P$ULTIBOPROGRAM_$$_GET_TICK_COUNT$$LONGINT

.section .text.n_p$ultiboprogram_$$_activity_led_enable
	.balign 4
.globl	P$ULTIBOPROGRAM_$$_ACTIVITY_LED_ENABLE
P$ULTIBOPROGRAM_$$_ACTIVITY_LED_ENABLE:
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
	.size	P$ULTIBOPROGRAM_$$_ACTIVITY_LED_ENABLE, .Le1 - P$ULTIBOPROGRAM_$$_ACTIVITY_LED_ENABLE

.section .text.n_p$ultiboprogram_$$_activity_led_on
	.balign 4
.globl	P$ULTIBOPROGRAM_$$_ACTIVITY_LED_ON
P$ULTIBOPROGRAM_$$_ACTIVITY_LED_ON:
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
	.size	P$ULTIBOPROGRAM_$$_ACTIVITY_LED_ON, .Le2 - P$ULTIBOPROGRAM_$$_ACTIVITY_LED_ON

.section .text.n_p$ultiboprogram_$$_activity_led_off
	.balign 4
.globl	P$ULTIBOPROGRAM_$$_ACTIVITY_LED_OFF
P$ULTIBOPROGRAM_$$_ACTIVITY_LED_OFF:
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
	.size	P$ULTIBOPROGRAM_$$_ACTIVITY_LED_OFF, .Le3 - P$ULTIBOPROGRAM_$$_ACTIVITY_LED_OFF

.section .text.n_main
	.balign 4
.globl	PASCALMAIN
PASCALMAIN:
.globl	main
main:
	stmfd	r13!,{r3,r14}
	bl	fpc_initializeunits
	ldr	r0,.Lj23
	ldr	r0,[r0]
	cmp	r0,#0
	beq	.Lj25
	ldr	r0,.Lj23
	ldr	r0,[r0]
	blx	r0
	b	.Lj27
.Lj25:
	ldr	r1,.Lj28
	ldr	r0,[r1]
.Lj27:
	cmp	r0,#25
	beq	.Lj30
	b	.Lj32
	.balign 4
.Lj31:
	mov	r0,#100
	bl	THREADS_$$_THREADSLEEP$LONGWORD$$LONGWORD
.Lj32:
	ldr	r0,.Lj34
	bl	SYSUTILS_$$_DIRECTORYEXISTS$RAWBYTESTRING$$BOOLEAN
	cmp	r0,#0
	beq	.Lj31
	ldr	r0,.Lj35
	bl	SYSUTILS_$$_FILEEXISTS$RAWBYTESTRING$$BOOLEAN
	cmp	r0,#0
	beq	.Lj37
	mov	r2,#0
	ldr	r1,.Lj38
	ldr	r0,.Lj39
	bl	ULTIBO_$$_COPYFILEA$PCHAR$PCHAR$LONGBOOL$$LONGBOOL
	mov	r1,r0
.Lj37:
.Lj30:
	bl	nimMain
	mov	r0,#0
	bl	THREADS_$$_THREADHALT$LONGWORD$$LONGWORD
	bl	fpc_do_exit
	ldmfd	r13!,{r3,r15}
.Lj23:
	.long	U_$PLATFORM_$$_BOARDGETTYPEHANDLER
.Lj28:
	.long	U_$GLOBALCONFIG_$$_BOARD_TYPE
.Lj34:
	.long	.Ld1
.Lj35:
	.long	.Ld2
.Lj38:
	.long	_$ULTIBOPROGRAM$_Ld3
.Lj39:
	.long	_$ULTIBOPROGRAM$_Ld4
.Le4:
	.size	main, .Le4 - main
# End asmlist al_procedures
# Begin asmlist al_globals

.section .data.n_INITFINAL
	.balign 4
.globl	INITFINAL
INITFINAL:
	.long	36,0
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
	.long	INIT$_$SPI
	.long	0
	.long	INIT$_$I2C
	.long	0
	.long	INIT$_$DMA
	.long	0
	.long	INIT$_$PWM
	.long	0
	.long	INIT$_$GPIO
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
	.long	INIT$_$USB
	.long	FINALIZE$_$USB
	.long	INIT$_$SCSI
	.long	0
	.long	INIT$_$STORAGE
	.long	FINALIZE$_$STORAGE
	.long	INIT$_$MMC
	.long	FINALIZE$_$MMC
	.long	INIT$_$CODEC
	.long	0
	.long	INIT$_$AUDIO
	.long	0
	.long	INIT$_$BCM2708
	.long	0
	.long	INIT$_$TYPINFO
	.long	FINALIZE$_$TYPINFO
	.long	INIT$_$CLASSES
	.long	FINALIZE$_$CLASSES
	.long	INIT$_$TIMEZONE
	.long	0
	.long	INIT$_$ULTIBO
	.long	FINALIZE$_$ULTIBO
	.long	INIT$_$FILESYSTEM
	.long	FINALIZE$_$FILESYSTEM
	.long	INIT$_$FATFS
	.long	FINALIZE$_$FATFS
.Le5:
	.size	INITFINAL, .Le5 - INITFINAL

.section .data.n_FPC_THREADVARTABLES
	.balign 4
.globl	FPC_THREADVARTABLES
FPC_THREADVARTABLES:
	.long	4
	.long	THREADVARLIST_$SYSTEM
	.long	THREADVARLIST_$DOS
	.long	THREADVARLIST_$LOGGING
	.long	THREADVARLIST_$CLASSES
.Le6:
	.size	FPC_THREADVARTABLES, .Le6 - FPC_THREADVARTABLES

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
.Le7:
	.size	FPC_RESOURCESTRINGTABLES, .Le7 - FPC_RESOURCESTRINGTABLES

.section .data.n_FPC_WIDEINITTABLES
	.balign 4
.globl	FPC_WIDEINITTABLES
FPC_WIDEINITTABLES:
	.long	0
.Le8:
	.size	FPC_WIDEINITTABLES, .Le8 - FPC_WIDEINITTABLES

.section .data.n_FPC_RESSTRINITTABLES
	.balign 4
.globl	FPC_RESSTRINITTABLES
FPC_RESSTRINITTABLES:
	.long	0
.Le9:
	.size	FPC_RESSTRINITTABLES, .Le9 - FPC_RESSTRINITTABLES

.section .fpc.n_version
	.balign 8
__fpc_ident:
	.ascii	"FPC 3.1.1 [2018/08/07] for arm - ultibo"
.Le10:
	.size	__fpc_ident, .Le10 - __fpc_ident

.section .data.n___stklen
	.balign 4
.globl	__stklen
__stklen:
	.long	262144
.Le11:
	.size	__stklen, .Le11 - __stklen

.section .data.n___heapsize
	.balign 4
.globl	__heapsize
__heapsize:
	.long	256
.Le12:
	.size	__heapsize, .Le12 - __heapsize

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
.Le13:
	.size	__fpc_valgrind, .Le13 - __fpc_valgrind
# End asmlist al_globals
# Begin asmlist al_typedconsts

.section .rodata.n_.Ld1
	.balign 4
.Ld1$strlab:
	.short	0,1
	.long	-1,3
.Ld1:
	.ascii	"C:\\\000"
.Le14:
	.size	.Ld1$strlab, .Le14 - .Ld1$strlab

.section .rodata.n_.Ld2
	.balign 4
.Ld2$strlab:
	.short	0,1
	.long	-1,18
.Ld2:
	.ascii	"default-config.txt\000"
.Le15:
	.size	.Ld2$strlab, .Le15 - .Ld2$strlab

.section .rodata.n__$ULTIBOPROGRAM$_Ld3
	.balign 4
.globl	_$ULTIBOPROGRAM$_Ld3
_$ULTIBOPROGRAM$_Ld3:
	.ascii	"config.txt\000"
.Le16:
	.size	_$ULTIBOPROGRAM$_Ld3, .Le16 - _$ULTIBOPROGRAM$_Ld3

.section .rodata.n__$ULTIBOPROGRAM$_Ld4
	.balign 4
.globl	_$ULTIBOPROGRAM$_Ld4
_$ULTIBOPROGRAM$_Ld4:
	.ascii	"default-config.txt\000"
.Le17:
	.size	_$ULTIBOPROGRAM$_Ld4, .Le17 - _$ULTIBOPROGRAM$_Ld4
# End asmlist al_typedconsts

