
/*** 

   This program invokes the fill_array function to read elements 
   of an array from standard input.  It then calls print_array to
   print each element of the array to standard output.

   main makes room for the array on the stack and passes
   the starting address of the array and the number of elements 
   to the functions

   To assemble:   armc array_main.s array_parms.s
                         OR
                  arm-linux-gnueabi-gcc array_main.s array_parms.s --static

   To execute:    ./a.out < datafile.txt

***/

base           .req r0      @ base address of array
n              .req r1      @ address of a[i]
array_addr     .req r4
num_elements   .req r5

 	.file "array_main.s"
 	.text
 	.align 2
 	.global main
 	.type main, %function

main:
 	    @ save registers
 		push {r4, r5, lr}

 		sub sp, sp, #40       @ space for array
 		add base, sp, #0

        /** preserve base address and number of elements  **/
        mov array_addr, base
       	mov n, #10
        mov num_elements, n

        bl fill_array
     
        /** move base addr to r0 and number of elements to r1  **/
        mov base, array_addr
        mov n,  num_elements

        bl print_array
        
        .unreq base
        .unreq n
        .unreq array_addr
        .unreq num_elements

 	    add sp, sp, #40
        pop {r4, r5, pc}
