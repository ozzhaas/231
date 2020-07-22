/*
* Kellen Haas 
* CPSC 2311
* Lab7
* 7/21/20
**/


	.global	fact
fact:
	mov   r1, #1			  @ store 1 in register 1

here:
	cmp   r0, #1			  @ compare the value in register 0 with 1        
	beq   there         	  @ if they are equal to each other, branch to there
				
							  @ if they are not equal to each other...
	mul   r1, r0, r1    	  @ multiply r0 by r1 and store that new value in r1
	sub   r0, r0, #1    	  @ subtract 1 from r0 and store that new value in r0
	b     here          	  @ call here to branch to it

there:
	mov   r0, r1        	  @ store r1 in r0

	bx    lr				  

	.size	fact, .-fact

	.align   2
	.section .rodata
fmt_str:
	.ascii  "The factorial of %d is %d\012\000"

	.text
	.align  2
	.global main
main:
	push  {lr}			  @ push the linked register onto the stack

	@ MAIN CODE GOES HERE
	mov r0, #0			  @ intialize r0 and r1 to 0
	mov r1, #0			  
	mov r0, #10			  @ set r0 equal to 10
	bl fact				  @ branch with link (aka j = fact(i))

	mov r2, r0			  @ store the new factorial value in register 2
	ldr r0, =fmt_str	  @ print out the factorial of the number
	mov r1, #10			  @ store 10 in register 1

	bl printf			  


	pop  {pc}			  @ pop pc off of the top of the stack

	.size    main, .-main
	.ident   "GCC: (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3"
	.section .note.GNU-stack,"",%progbits
