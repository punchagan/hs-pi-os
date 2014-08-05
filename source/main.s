// Instructions to the linker
	.section .init
	.globl _start

_start:
	ldr r0,=0x20200000

	// Make pin16 an output pin.
	mov r1,#1
	lsl r1,#18
	str r1,[r0,#4]
	// Why does this not work??
	// mov r1,#4
	// str r1,[r0,#6]

	// Turn off the GPIO pin to turn the LED on
	mov r1,#1
	lsl r1,#16
	str r1,[r0,#40]

loop$:
	// Loop forever
	b loop$
