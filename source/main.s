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


turnon$:
	// Set the GPCLR{16} bit
	pinNum .req r0
	pinVal .req r1
	mov pinNum,#16
	mov pinVal,#0
	.unreq pinNum
	.unreq pinVal
	bl SetGpio
	mov r2,#0x3F0000 // initialize counter
	mov r4,#1	 // set flag to on

wait$:
	sub r2,#1
	cmp r2,#0
	bne wait$

	cmp r4,#1
	bne turnon$

turnoff$:
	// Set the GPSET{16} bit
	pinNum .req r0
	pinVal .req r1
	mov pinNum,#16
	mov pinVal,#1
	.unreq pinNum
	.unreq pinVal
	bl SetGpio
	mov r2,#0x3F0000 // initialize counter
	mov r4,#0	 // set flag to off

	b wait$
