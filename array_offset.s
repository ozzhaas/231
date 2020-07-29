/***

   This program allocates an array in the data section.  It calls
   printf to print each element of the array to standard output.


   To assemble:   armc first_array.s array_parms.s
                         OR
              arm-linux-gnueabi-gcc array_main.s array_parms.s --static

   To execute:    ./a.out

***/

fmt_str .req r0
param1  .req r1
val     .req r2
offset  .req r4
base    .req r5


       .file "array_offset.s"
       .section .text
       .align 2
       .global main
       .type main, %function

main:
       push   {r4-r5, lr}               /* save registers  */       

       ldr    base, =array              /*  put the base address in base  */

       mov    offset, #0                /*  initialize i       */

       cmp    offset, #28
       bge    done

loop:
       /*  uses offset to compute the addr of a[i]                 */
       ldr    val, [base, offset]    /*  put a[i] in val           */

       ldr    fmt_str, =fmt          /*  put 1st param for printf  */
       mov    param1, offset         /*  put 2nd param for printf  */
       bl     printf

       add    offset, offset, #4
       cmp    offset, #28
       blt    loop

done:
       pop    {r4-r5, lr}               /*  restore registers    */

       mov    r0, #0

       .unreq  fmt_str
       .unreq  param1
       .unreq  val
       .unreq  offset
       .unreq  base

       bx     lr

       .section  .data

array:
       .word   25
       .word   30
       .word   35
       .word   40
       .word   45
       .word   50
       .word   55

	   .section  .rodata

fmt:   .asciz    "[%d] = %d\n\n"
