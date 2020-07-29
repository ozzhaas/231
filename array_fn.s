/*** 

   This program allocates an array in the data section.  It calls 
   print_array to print each element of the array to standard output.


   To assemble:   armc array_fn.s
                         OR
              arm-linux-gnueabi-gcc array_fn.s --static

   To execute:    ./a.out 

***/

i       .req r4
base    .req r5        


       .file "array_fn.s"
       .section .text
       .align 2
       .global main
       .type main, %function

main:
       push   {lr}               /* save registers  */

       ldr    base, =array              /*  put the base address in base  */

       mov    r0, base
       mov    r1, #7

       bl     print_array
      
       mov r0, #0
       pop {lr}

       bx lr


 
      .global print_array
      .type print_array, %function

print_array:        
        push {r4-r6, lr}

       mov r5, r0
       mov r6, r1

       mov    r4, #0                     /*  initialize i       */

       cmp    r4, r6         
       bge    done

loop:
       ldr    r2, [r5, r4, lsl #2]    /*  put a[i] in val           */

       ldr    r0, =fmt                /*  put 1st param for printf  */
       mov    r1, r4                  /*  put 2nd param for printf  */
       bl     printf          

       add    r4, r4, #1
       cmp    r4, r6
       blt    loop          

done:
       pop    {r4-r6, lr}               /*  restore registers    */

       mov    r0, #0

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
