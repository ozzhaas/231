/* Kellen Haas & Caroline Boyt
* CPSC 2310
* Assignment 4
* 8/1/20
*/


 .file "encode.s"
 .section .text
 .align 2
 .global encode
 .type encode, %function

/********************************************************************
You are to write a subroutine for dealing with encoded messages using the
following private-key algorithm: Consider each letter of a message and of
a shared key as an integer from 1 to 26 (i.e., a=1, b=2, ..., z=26).
The resulting letter in the encoded message is obtained by adding the
letter values together and then subtracting 26 if the sum is greater than
26. The key is repeated until the complete message is encoded. Spaces,
 digits, and punctuation are not encoded but they do count towards the
 repetition of the key.
********************************************************************/

encode:
    push {r7, r10, r11, lr}         @ push r7, r10, r11 and lr onto the stack
                                    @ to save for returning at the end

    cmp r3, #1                      @ compare the last parameter passed into
    beq decode                      @ the encode function with 1 so we know if
                                    @ we are encoding or decoding (e = 0, d = 1)

    mov r4, #0                      @ create an iterator for input string (i)
    mov r5, #0                      @ create an iterator for key string (j)

//Start looping through the input string to encode it//
    encodeLoop:
        ldrb r10, [r0, r4]          @ og[i] (original String = og)
        ldrb r11, [r2, r5]          @ key[i]

        cmp r10, #0                 @ check if og in position i is null
        beq done                    @ if it is branch to done

        cmp r11, #0                 @ check if the key in position i is null
        beq encodeRestartKey        @ if it is restart the key from the
                                    @ beginning to repeat it

    encodeCalculate:
        //If og[i] == space --> store the space in new array and
        //then increment both//
        cmp r10, #32                @ check for spaces in the input array
        beq encodeStoreSpace        @ if it is a space go to encodeStoreSpace

        //If key[i] == space --> store the letter in og[i] in the new array
        //and increment both//
        cmp r11, #32                @ check for spaces in the key array
        beq encodeStoreSpace        @ if it is a space go to encodeStoreSpace

        cmp r10, #97                @ make sure the character in position i is
                                    @ greater than or equal to 'a'
        blt encodeIncrement         @ if it isn't increment past it to skip it

        cmp r10, #122               @ make sure the character in position i is
                                    @ less than or equal to 'z'
        bgt encodeIncrement         @ if it isn't increment past it to skip it

        sub r10, r10, #96           @ subtract 96 from the character in pos i
                                    @ of the input string

        sub r11, r11, #96           @ subtract 96 from the character in pos i
                                    @ of the key string

        mov r7, #0                  @ initialized r7 to 0 for temporary storage
        add r7, r10, r11            @ add the two values of pos i in both string
                                    @ arrays and store into r7

        cmp r7, #26                 @ if the value in r7 is greater than 26
        bgt subtract                @ subtract 26 from it


    subtract:
        sub r7, r7, #26             @ subtract 26 from r7
        bal storeEncode             @ branch to the store func to save the value


    storeEncode:
        add r7, r7, #96             @ add 96 back to the value stored in r7 to
                                    @ get its decimal ascii value

        strb r7, [r1, r4]           @ store r1 offset by r4 in r7

        bal encodeIncrement         @ branch to the increment function


    encodeIncrement:
        add r4, r4, #1              @ increment i
        add r5, r5, #1              @ increment j

        bal encodeLoop              @ branch back to the loop to read in the
                                    @ next character

    encodeRestartKey:
        mov r5, #0                  @ initialize r5 to 0
        ldrb r11, [r2, r5]          @ load r2 offset by r5 into r11
        bal encodeCalculate         @ branch to the calculate function

    encodeStoreSpace:
        strb r10, [r1, r4]          @ store r1 offset by r4 into r10
        add r4, r4, #1              @ increment i
        add r5, r5, #1              @ increment j
        bal encodeLoop              @ branch back to the loop


/******************************************************************************/
decode:
    mov r4, #0                      @ create an iterator for input string (i)
    mov r5, #0                      @ create an iterator for key string (j)


    decodeLoop:
        ldrb r10, [r0, r4]          @ og[i] (original String = og)
        ldrb r11, [r2, r5]          @ key[i]

        cmp r10, #0                 @ check if og in position i is '\n'
        beq done                    @ if it is branch to done

        cmp r11, #0                 @ check if the key in position i is '\n'

        beq decodeRestartKey        @ if it is restart the key from the
                                    @ beginning to repeat it


    decodeCalculate:
    //If og[i] == space --> store the space in new array and
    //then increment both//
        cmp r10, #32                @ check for spaces in the input array
        beq decodeStoreSpace        @ if it is a space go to encodeStoreSpace

    //If key[i] == space --> store the letter in og[i] in the new array and
    //increment both//
        cmp r11, #32                @ check for spaces in the key array
        beq decodeStoreSpace        @ if it is a space go to encodeStoreSpace

        cmp r10, #97                @ make sure the character in position i is
                                    @ greater than or equal to 'a'

        blt decodeIncrement         @ if it isn't increment past it to skip it

        cmp r10, #122               @ make sure the character in position i is
                                    @ less than or equal to 'z'

        bgt decodeIncrement         @ if it isn't increment past it to skip it

        sub r10, r10, #96           @ subtract 96 from the character in pos i
                                    @ of the input string

        sub r11, r11, #96           @ subtract 96 from the character in pos i
                                    @ of the key string

        mov r7, #0                  @ initialized r7 to 0 for temporary storage
        sub r7, r10, r11            @ add the two values of pos i in both string
                                    @ arrays and store into r7


        cmp r7, #0                  @ if the value in r7 is less than 0
        blt addition                @ add 26 to it


    addition:
        add r7, r7, #26             @ add 26 to r7
        bal storeDecode             @ branch to the store func to save the value


    storeDecode:
        add r7, r7, #96             @ add 96 back to the value stored in r7 to
                                    @ get its decimal ascii value

        strb r7, [r1, r4]           @ store r1 offset by r4 in r7

        bal decodeIncrement         @ branch to the increment function


    decodeIncrement:
        add r4, r4, #1              @ increment i
        add r5, r5, #1              @ increment j

        bal decodeLoop              @ branch back to the loop to read in the
                                    @ next character


    decodeRestartKey:
        mov r5, #0                  @ initialize r5 to 0
        ldrb r11, [r2, r5]          @ load r2 offset by r5 into r11
        bal decodeCalculate         @ branch to the calculate function


    decodeStoreSpace:
        strb r10, [r1, r4]          @ store r1 offset by r4 into r10
        add r4, r4, #1              @ increment i
        add r5, r5, #1              @ increment j
        bal decodeLoop              @ branch back to the loop


    done:
        strb r10, [r1, r4]          @ store the final value of r1 offset by r4
                                    @ into r10

        pop {r7, r10, r11, pc}      @ pop r7, r10, r11, and program counter off
                                    @ of the stack to return

        bx lr                       @ return
