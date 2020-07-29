/* Kellen Haas
 * CPSC 2310
 * Assignment 3
 * 7/28/20
 */



     .file "offset.s"
     .section .text
     .align 2
     .global offset
     .type offset, %function

@ r1 = i
@ r2 = j
@ r3 = n
@ r4 = 4
@ r5 = temporary storage for calculations

offset:
    mov r6, #4              @ store constant 4 in r4

    mov r5, r1, lsl r3      @ use logical shift left to multiply i by the
                            @ number of columns per row and store in r5 temporarily

    add r5, r5, r2          @ add the result of the first multiplication to j
                            @ and store the result in r5 again

    mov r6, r5, lsl r6      @ finally, use logical shift left to multiply the
                            @ result of the first multiplication and the addition
                            @ by the elements' size (4 bytes)

    bx lr                   @ return


fmt:
    .asciz "Test: %d"
