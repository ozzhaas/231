/*** 

   This program allocates an array in the data section.  It calls 
   printf to print each element of the array to standard output.


   To assemble:   armc first_array.s
                         OR
              arm-linux-gnueabi-gcc first_array.s --static

   To execute:    ./a.out 

***/

fmt_str .req r0
param1  .req r1
val     .req r2
i       .req r4
base    .req r5        


       .file "first_array.s"
       .section .text
       .align 2
       .global main
       .type main, %function

main:
       push   {r4-r5, lr}               /* save registers  */

       ldr    base, =array              /*  put the base address in base  */

       mov    i, #0                     /*  initialize i       */

       cmp    i, #7         
       bge    done

loop:  
       /*  uses scaled pre-indexed mode to compute the addr of a[i]   */
       ldr    val, [base, i, lsl #2]    /*  put a[i] in val           */

       ldr    fmt_str, =fmt             /*  put 1st param for printf  */
       mov    param1, i                 /*  put 2nd param for printf  */
       bl     printf          

       add    i, i, #1
       cmp    i, #7         
       blt    loop          

done:
       pop    {r4-r5, lr}               /*  restore registers    */

       mov    r0, #0

       .unreq  fmt_str
       .unreq  param1
       .unreq  val
       .unreq  i
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
