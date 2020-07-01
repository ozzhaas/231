/**
    int i;
    int sum = 0

    for(i = 1; i <= 10; i++)
      sum += i;

    print sum;

**/

	.file	"add.s"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	push	{lr}

    mov r0, #1         @ i = 1
    mov r1, #0         @ sum = 0
    mov r2, #10        @ limit

    cmp r0, r2
    bgt finish


loop:
    add r1, r1, r0
  
    add r0, r0, #1
    cmp r0, r2
    ble loop

finish:
    ldr     r0, =fmt
	bl	printf


	mov	r0, #0
	pop	{pc}

	.section	.rodata
	.align	2

fmt: .ascii	"\nsum = %d\n\n"
