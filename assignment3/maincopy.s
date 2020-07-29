/* Kellen Haas
 * CPSC 2310
 * Assignment 3
 * 7/28/20
 */



     .file "main.s"
     .section .text
     .align 2
     .global main
     .type main, %function


@ r0 = argc
@ r1 = argv
@ r4 = offset
@ r6 = i
@ r7 = j
@ r8 = n


main:
    push {r4-r5, lr}
    mov    r4, r0           @ r4 <-- r0 = argc

    ldr r0, [r1, #4]        @ put i into r6 as an int
    bl atoi                 @ convert string to integer
    mov r2, r0              @ store new i in r6

    ldr r0, [r1, #8]        @ put j into r7 as an int
    bl atoi                 @ convert string to integer
    mov r3, r0              @ store j in r7

    ldr r0, [r1, #12]       @ put the number of columns per row into r8 as an int
    bl atoi                 @ convert string to integer
    mov r4, r0              @ store n in r8

    bl offset               @ call offset
    mov r5, r0

    ldr r0, =fmt1           @ set up print statement fmt1
    mov r1, r2              @ move i to r1 to be printed
    bl printf               @ call printf

    ldr r0, =fmt2           @ set up print statement fmt2
    mov r1, r3              @ move j to r1 to be printed
    bl printf               @ call printf

    ldr r0, =fmt3           @ set up print statement fmt3
    mov r1, r6              @ move n to r8 to be printed
    bl printf               @ call printf




done:
    mov  r0, #0             @ restore register value
    pop {r4-r5, pc}         @ pop r4, r5 and pc off the stack



fmt1:
    .asciz "\nThe offset for a[%d]"

fmt2:
    .asciz "[%d] is "

fmt3:
    .asciz "%d.\n\n"
