	.section .data
	.align 2
pattern:
	.int 0b11111111101010100010001000101010

	// Instructions to the linker
	.section .init
	.globl _start

_start:
	b main
	.section .text
main:
	mov sp,#0x8000

	// Make pin16 an output pin.
	pinNum .req r0
	pinFunc .req r1
	mov pinNum,#16
	mov pinFunc,#1
	bl SetGpioFunction
	.unreq pinNum
	.unreq pinFunc

	// Set the required pattern into r4,
	ldr r4,=pattern
	ldr r4,[r4]
	mov r5, #0


loop$:
	mov r1, #1
	lsl r1, r5
	and r1, r4

	pinNum .req r0
	mov pinNum,#16
	.unreq pinNum
	bl SetGpio

	ldr r0,=250000
	bl wait

	add r5,r5,#1
	cmp r5,#32
	movhi r5,#0

	b loop$
