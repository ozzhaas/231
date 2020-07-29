 	.text
 	.align 2
 	.global main
    .global fill_array, print_array
 	.type fill_array, %function
 	.type print_array, %function

/**
  This function reads values from standard input
  and stores the values in the array
**/

fill_array: 	

fmt_str .req r0
addr    .req r1
i       .req r4
n       .req r5
base    .req r6

        
        push {r4 - r6, lr} 

        mov i, #0
        mov n, #10
        mov base, r0       @ preserve address of array

        cmp i, n
        bge read_done

read_loop:
        /** compute the address of a[i]  **/
        add addr, base, i, lsl #2   @ addr <-- &a[i] = base + 4*i

        ldr fmt_str, =rdfmt              @ format string in r0
        bl scanf

        add i, i, #1
        cmp i, n
        blt read_loop
        
read_done:
        .unreq addr
        .unreq i
        .unreq n
        .unreq base
       
        pop {r4 - r6, pc}


/**
  This function prints the elements to standard output.
**/
print_array:

fmt_str .req r0
index   .req r1
value   .req r2      @ a[i]
i       .req r4
addr    .req r5      @ address of a[i]
n       .req r6      @ number of element
base    .req r7

        push {r4-r7, lr}

        mov base, r0
        mov n, r1
       	mov i, #0
       	cmp i, n
       	bge prt_done

prt_loop: 	@ print each element of the array

        ldr fmt_str, =prtfmt  @ put format string in r0

        /** compute the address of a[i]  **/
        add addr, base, i, lsl #2   @ addr <-- &a[i] = base + 4*i

       	ldr value, [addr]           @ put a[i] in r2
        mov index, i                @ put index in r1
       	bl printf                   @ call printf to print a[i] 

       	add i, i, #1
       	cmp i, n
       	blt prt_loop

prt_done:
    .unreq fmt_str
    .unreq addr
    .unreq value
    .unreq base
    .unreq i
    .unreq n

 	mov r0, #0

 	pop {r4-r7, pc}

 	.section .rodata
 	.align 2

prtfmt:    .asciz "\na[%d] = %d\n"
rdfmt:     .asciz "%d"
