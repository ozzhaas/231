/* Kellen Haas
 * CPSC 2311
 * Lab9
 * 7/24/20
 */



box_init:
    push    {lr}					@ save the return addr on the stack
    sub     sp, sp, #12				@ allocate space on the stack

    str     r1, [sp]				@ save x in r1
    str     r2, [sp, #4]			@ save y in r2
    str     r3, [sp, #8]			@ save z in r3

    ldmia   sp, {r1, r2, r3}		@ take the base address sp and load the 
									@ the values stored incrementing after each
									@ value is loaded

    stmia   r0, {r1, r2, r3}		@ take the base address r0 and store the 
									@ the values loaded from the stack
									@ incrementing after each value is stored

    add     sp, sp, #12
    pop {pc}


init:
        push    {lr}				@ save the return addr on the stack
        sub     sp, sp, #8			@ allocate space on the stack

        str     r1, [sp]			@ save x in r1
        str     r2, [sp, #4]		@ save y in r2

        ldmia   sp, {r1, r2}		@ take the base address sp and load the 
									@ the values stored incrementing after each
									@ value is loaded

        stmia   r0, {r1, r2}		@ take the base address r0 and store the 
									@ the values loaded from the stack
									@ incrementing after each value is stored

        add     sp, sp, #8			@ deallocate space from the stack
        pop     {pc}				@ pop pc off the stack and return 



zero:
        push    {lr}				@ save the return addr on the stack
        sub     sp, sp, #8			@ allocate space on the stack

        mov     r3, #0				@ store the constant 0 in r3
        str     r3, [sp]			@ store r3 indirectly into x
        str     r3, [sp, #4]		@ store r3 indirectly into y

        ldmia   sp, {r1, r2}		@ take the base address sp and load the 
									@ the values stored incrementing after each
									@ value is loaded

        stmia   r0, {r1, r2}		@ take the base address r0 and store the 
									@ the values loaded from the stack
									@ incrementing after each value is stored

        add     sp, sp, #8			@ deallocate space from the stack
        pop     {pc}				@ pop pc off the stack and return 


.global main
main:
        push    {lr}
        sub     sp, sp, #8 			@ make room for the point struct
		sub 	sp, sp, #12			@ allocate for the box struct

        mov     r0, sp				@ move the stack pointer into r0
        mov     r1, #34				@ set r1's value to 34
        mov     r2, #-3				@ set r2's value to -3
        bl      init				@ call the init function

        ldr     r0, =fmtstr1		@ load the first string formatting and 
									@ save it into r0

        ldr     r1, [sp]			@ load the stack pointer, x, and 
									@ save it into r1

        ldr     r2, [sp, #4]		@ load the stack pointer at the addr+4, y, 
									@ and save it into r2

        bl      printf				@ call the printf function

        mov     r0, sp				@ move the stack pointer into r0
        bl      zero				@ call the zero function

        ldr     r0, =fmtstr1		@ load the first string formatting and 
									@ save it into r0

        ldr     r1, [sp]			@ load the stack pointer, x, and 
									@ save it into r1

        ldr     r2, [sp, #4]		@ load the stack pointer at the addr+4, y, 
									@ and save it into r2

        bl      printf				@ call the printf function

        mov     r0, sp				@ move the stack pointer into r0
        mov     r1, #45				@ set r1 to 45 
        mov     r2, #17				@ set r2 to 17
        mov     r3, #3				@ set r3 to 3

        bl      box_init			@ call the box_init function

            ldr     r0, =fmtstr2	@ load the second string formatting and 
									@ save it into r0

            ldr     r1, [sp]		@ load the stack pointer, x, and 
									@ save it into r1

            ldr     r2, [sp, #4]	@ load the stack pointer at the addr+4, y, 
									@ and save it into r2

            ldr     r3, [sp, #8]	@ load the stack pointer at the addr+8, y, 
									@ and save it into r3

            bl      printf			@ call the printf function

        add    sp, sp, #8			@ deallocate memory from the stack
        add    sp, sp, #12


        pop    {pc}					@ pop pc off the stack and return

fmtstr1:
        .ascii "The members of the structure dot are %d, %d\012\000"

fmtstr2:
        .ascii "The members of the structure box are %d, %d\012\000"
