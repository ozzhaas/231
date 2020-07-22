/*
* Kellen Haas 
* CPSC 2311
* Lab7
* 7/21/20
**/

	.global	fact
fact:
    push  {r1, lr}		  @ push r1 and the linked register onto the stack

    cmp   r0, #1          @ compare r0 with constant 1
    beq   done            @ if they are equal to each other, branch to done

						  @ if they are not equal to each other...
    mov  r1, r0           @ store r0 in r1
    sub  r0, r0, #1       @ subtract 1 from r0 and store that value in r0
    bl   fact             @ call fact 

    mul  r0, r1, r0       @ multiply r1 by r0 and store that value in r0

done:
    pop  {r1, pc}         @ pop both r1 and pc off of the stack
    .size    fact, .-fact

    .align   2
    .section .rodata
fmt_str:
    .ascii   "The factorial of %d is %d\012\000"

    .text
    .align   2
    .global  main
main:
    push {lr}             @ push the link register onto the stack so we can come back to it 
	
    @ MAIN CODE GOES HERE
	mov r0, #0 			  @ initilize int i and int j
	mov r1, #0			  
	mov r0, #10			  @ i = 10

	bl fact				  @ branch with link (aka j = fact(i))

	mov r2, r0			  @ store the new factorial value in register 2
	ldr r0, =fmt_str	  @ print out the factorial of the number
	mov r1, #10
	bl printf

    pop  {pc}             @ pop the top of the stack

	.size    main, .-main
	.ident   "GCC: (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3"
	.section .note.GNU-stack,"",%progbits
