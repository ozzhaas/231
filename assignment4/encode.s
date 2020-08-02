/* Kellen Haas
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

      mov r4, #0    // iterator for input string
      mov r5, #0    // iterator for key

   loop:

      ldrb r10, [r0, r4]  // og[i]

      cmp r10, #0
      beq done

      cmp r10, #97
      blt skip

      cmp r10, #122
      bgt skip

      sub r10, r10, #96

      ldrb r11, [r2, r5]  // key[i]

      cmp r11, #0
      beq restartKey

   label1:
      sub r11, r11, #96

      mov r7, #0
      add r7, r10, r11

      cmp r7, #26
      bgt subtract

   store:

      add r7, r7, #96
      str r7, [r1, r4]

      add r4, r4, #4
      add r5, r5, #4

   subtract:

      sub r7, r7, #26
      bal store


   skip:
      add r4, r4, #4
      add r5, r5, #4

      bal loop

   restartKey:
      mov r5, #0
      bal label1

done:

      bx lr
