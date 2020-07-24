    .file "sum.s"
    .text
    .align  2
    .global main
    .type   main, %function

/* main() sums 10 values from stdin and prints the sum */
main:
    push {lr}    // save lr

    //Code goes here
    add sp, sp, #-40 //10 integers each 4 bytes
    mov r4, sp
    mov r5, #0

        firstLoop:
            cmp r5, #10
            bge finishFirst

            ldr r0, =rdfmt
            mov r1, r4
            bl scanf

            mov r4, r4, #4
            add r5, r5, #1
            b firstLoop

        finishFirst:
            mov r4, sp
            mov r5, #1
            add r6, #0

        secondLoop:
            cmp, r5, #10
            bge finishSecond
            ldr r0, [r4]
            add r6, r6, r0

            add r4, r4, #4
            add r5, r5, #1
            b secondLoop

        finishSecond:
            ldr r0, =prtfmt
            mov r1, r6
            bl printf

            add sp, sp, #40




    pop {pc}         // put lr in pc

.section    .rodata
    rdfmt:        .asciz "%d"
    prtfmt:       .asciz "sum is %d\n"
