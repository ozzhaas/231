/* Kellen Haas
 * CPSC 2310
 * Assignment 3
 * 7/28/20
 */



 main:
        push {r4-r5, lr}
        mov r4, r0                // save argc
        mov r5, r1                // save argv
        ldr r0, =fmt1             // put addr of fmt1 in r0 for printing
        atoi r0, r0
        mov r1, r4                // put argc in r1 for printint
        bl printf
