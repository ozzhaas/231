/* Kellen Haas
 * CPSC 2311
 * Lab9
 * 7/24/20
 */



box_init:
    push    {lr}
    sub     sp, sp, #12

    str     r1, [sp]
    str     r2, [sp, #4]
    str     r3, [sp, #8]

    ldmia   sp, {r1, r2, r3}
    stmia   r0, {r1, r2, r3}

    add     sp, sp, #12
    pop {pc}


init:
        push    {lr}
        sub     sp, sp, #8

        str     r1, [sp]
        str     r2, [sp, #4]

        ldmia   sp, {r1, r2}
        stmia   r0, {r1, r2}

        add     sp, sp, #8
        pop     {pc}



zero:
        push    {lr}
        sub     sp, sp, #8

        mov     r3, #0
        str     r3, [sp]
        str     r3, [sp, #4]

        ldmia   sp, {r1, r2}
        stmia   r0, {r1, r2}

        add     sp, sp, #8
        pop     {pc}

.global main
main:
        push    {lr}
        sub     sp, sp, #8 @ make room for the point struct

        mov     r0, sp
        mov     r1, #34
        mov     r2, #-3
        bl      init

        ldr     r0, =fmtstr1
        ldr     r1, [sp]
        ldr     r2, [sp, #4]
        bl      printf

        mov     r0, sp
        bl      zero

        ldr     r0, =fmtstr1
        ldr     r1, [sp]
        ldr     r2, [sp, #4]
        bl      printf

        mov     r0, [sp]
        mov     r1, #45
        mov     r2, #17
        mov     r3, #3

        bl      box_init

            ldr     r0, =fmstr2
            ldr     r1, [sp]
            ldr     r2, [sp, #4]
            ldr     r3, [sp, #8]

            bl      printf

        add    sp, sp, #8
        add    sp, sp, #12
        pop    {pc}

fmtstr1:
        .ascii "The members of the structure dot are %d, %d\012\000"

fmtstr2:
        .ascii "The members of the structure box are %d, %d\012\000"
