// Instructions to the linker
	.section .init
	.globl _start

_start:
	ldr r0,=0x20200000

	// Make pin16 an output pin.
	mov r1,#1
	lsl r1,#18
	str r1,[r0,#4]

	// Why does this not work?!@
	// It definitely worked once! :(
	// mov r1,#4
	// str r1,[r0,#5]

	mov r1,#1
	lsl r1,#16

turnon$:
	// Set the GPCLR{16} bit
	str r1,[r0,#40]  // #40 --> 0x28

	mov r2,#0x3F0000
wait1$:
	sub r2,#1
	cmp r2,#0
	bne wait1$

turnoff$:
	mov r1,#1
	lsl r1,#16
	// Set the GPSET{16} bit
	str r1,[r0,#28]

	mov r2,#0x3F0000
wait2$:
	sub r2,#1
	cmp r2,#0
	bne wait2$

	b turnon$
