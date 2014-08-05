// Instructions to the linker
	.section .init
	.globl _start

_start:
	ldr r0,=0x20200000

	// Make pin16 an output pin.
	mov r1,#1
	lsl r1,#18
	str r1,[r0,#4]

	// 16th pin is our target!
	mov r1,#1
	lsl r1,#16

turnon$:
	// Set the GPCLR{16} bit
	str r1,[r0,#40]  // #40 --> 0x28
	mov r2,#0x3F0000 // initialize counter
	mov r3,#1	 // set flag to ON

wait$:
	sub r2,#1
	cmp r2,#0
	bne wait$

	cmp r3,#1
	bne turnon$

turnoff$:
	// Set the GPSET{16} bit
	str r1,[r0,#28]
	mov r2,#0x3F0000 // initialize counter
	mov r3,#0	 // set flag to off

	b wait$
