/**
    int i;
    int power = 2

    while(power <= 100)
    {
       printf("%d\n",  power);
       power = power * 2;
    }

**/

	.file	"power.s"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	push	{r4-r5, lr}

    mov r4, #2         @ i = 2
    mov r5, #100       @ limit

    cmp r4, r5
    bgt finish

loop:
    ldr     r0, =fmt
    mov r1, r4
    bl	printf
    
    mov r4, r4, lsl #1
    
    cmp r4, r5
    ble loop

finish:


	mov	r0, #0
	pop	{r4-r5, pc}

	.section	.rodata
	.align	2

fmt: .ascii	"%d\n"
