
/* Kellen Haas
 * CPSC 2311
 * Lab8
 * 7/23/20
*/

    .file "sum.s"
    .text
    .align  2
    .global main
    .type   main, %function

/* main() sums 10 values from stdin and prints the sum */
main:
    push {lr}    				// save lr

    //Code goes here
    add sp, sp, #-40 			//10 integers each 4 bytes
    add r4, sp, #0				//Allocate space for local variables
    mov r5, #1					//set r5 equal to 0 for the loop incrementer

        firstLoop:
            cmp r5, #10			//compare r5 to the loop limit
            bgt finishFirst		//if r5 is greater than 10 exit the loop

            ldr r0, =rdfmt		//use scanf to read in the numbers from input2.txt
            mov r1, r4			//move the stack pointer to be stored in r1
            bl scanf			//call scanf

            add r4, r4, #4		//adjust the stack pointer for offset
            add r5, r5, #1		//increment r5 and then loop again
            b firstLoop

        finishFirst:
            mov r4, sp			//move the stack pointer to r4
            mov r5, #1			//set r5's value to 1
            add r6, #0			//set the average stored in r6 to 0

        secondLoop:
            cmp r5, #10			//compare r5 with 10 
            bgt finishSecond	//if it's greater than 10 exit the loop
            ldr r0, [r4]		//read in the value r4 is pointing to
								//on the stack and store it in r0

            add r6, r6, r0		//the sum is equal to r6 + r0

            add r4, r4, #4		//adjust the stack pointer for offset
            add r5, r5, #1		//increment r5 and then loop again
            b secondLoop

        finishSecond:
            ldr r0, =prtfmt 	//use printf to print out the sum
            mov r1, r6			//store the sum in r1
            bl printf			//call printf

            add sp, sp, #40		//restore the stack pointer




    pop {pc}         // put lr in pc

.section    .rodata
    rdfmt:        .asciz "%d"
    prtfmt:       .asciz "sum is %d\n"
