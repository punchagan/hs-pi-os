	.globl GetTimerAddress
GetTimerAddress:
	ldr r0,=0x20003000
	mov pc,lr

	.globl wait
wait:
	push {lr}

	waitTime .req r1
	mov waitTime, r0

	currentTime .req r2
	targetTime .req r3

	bl readClock
	add targetTime, currentTime, waitTime

waitLoop$:
	bl readClock
	cmp targetTime, currentTime
	bhi waitLoop$

	.unreq targetTime
	.unreq currentTime
	.unreq waitTime

	pop {pc}

readClock:
	push {lr}
	bl GetTimerAddress
	ldr r2, [r0,#4]
	pop {pc}
