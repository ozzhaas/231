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
    push {r7, r10, r11, lr}

    cmp r3, #1
    beq decode

    mov r4, #0    // iterator for input string
    mov r5, #0    // iterator for key


    encodeLoop:
        ldrb r10, [r0, r4]  // og[i]
        ldrb r11, [r2, r5]  // key[i]

        cmp r10, #0
        beq done

        cmp r11, #0
        beq encodeRestartKey


    encodeCalculate:
        //If og[i] == space --> store the space in new array and then increment both
        cmp r10, #32
        beq encodeStoreSpace

        //If key[i] == space --> store the letter in og[i] in the new array and increment both
        cmp r11, #32
        beq encodeStoreSpace

        cmp r10, #97
        blt encodeIncrement

        cmp r10, #122
        bgt encodeIncrement

        sub r10, r10, #96
        sub r11, r11, #96

        mov r7, #0
        add r7, r10, r11

        cmp r7, #26
        bgt subtract


    storeEncode:
        add r7, r7, #96

        strb r7, [r1, r4]

        bal encodeIncrement


    subtract:
        sub r7, r7, #26
        bal storeEncode


    encodeIncrement:
        add r4, r4, #1
        add r5, r5, #1

        bal encodeLoop

     encodeRestartKey:
        mov r5, #0
        ldrb r11, [r2, r5]
        bal encodeCalculate

    encodeStoreSpace:
        strb r10, [r1, r4]
        add r4, r4, #1
        add r5, r5, #1
        bal encodeLoop


/******************************************************************************/
decode:
    mov r4, #0    // iterator for input string
    mov r5, #0    // iterator for key


    decodeLoop:
        ldrb r10, [r0, r4]  // og[i]
        ldrb r11, [r2, r5]  // key[i]

        cmp r10, #0
        beq done
        cmp r11, #0
        beq decodeRestartKey


    decodeCalculate:
    //If og[i] == space --> store the space in new array and then increment both
        cmp r10, #32
        beq decodeStoreSpace

    //If key[i] == space --> store the letter in og[i] in the new array and increment both
        cmp r11, #32
        beq decodeStoreSpace

        cmp r10, #97
        blt decodeIncrement

        cmp r10, #122
        bgt decodeIncrement

        sub r10, r10, #96
        sub r11, r11, #96

        mov r7, #0
        sub r7, r10, r11

        cmp r7, #0
        blt addition


    storeDecode:
        add r7, r7, #96
        strb r7, [r1, r4]
        bal decodeIncrement


    addition:
        add r7, r7, #26
        bal storeDecode


    decodeIncrement:
        add r4, r4, #1
        add r5, r5, #1
        bal decodeLoop


    decodeRestartKey:
        mov r5, #0
        ldrb r11, [r2, r5]
        bal decodeCalculate


    decodeStoreSpace:
        strb r10, [r1, r4]
        add r4, r4, #1
        add r5, r5, #1
        bal decodeLoop


    done:
        strb r10, [r1, r4]
        pop {r7, r10, r11, pc}
        bx lr
