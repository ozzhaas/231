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
    You are to write a subroutine for dealing with encoded messages using the following private-key algorithm: Consider each letter of a message and of a shared key as an integer from 1 to 26 (i.e., a=1, b=2, ..., z=26). The resulting letter in the encoded message is obtained by adding the letter values together and then subtracting 26 if the sum is greater than 26. The key is repeated until the complete message is encoded. Spaces, digits, and punctuation are not encoded but they do count towards the repetition of the key.
********************************************************************/



encode:
    
