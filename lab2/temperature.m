
comment('Kellen Haas')
comment('CPSC 2311 Lab2')
comment('7/5/20')



                 comment(`This program prints out a Celsius to Fahrenheit conversion')
                 comment(`table from -40 degrees Celsius to 120 degrees Celsius in increments')
                 comment(`of 10.')

                 comment(`Here is our starting temperature in degrees Celsius')
bipush(-40)      comment(`Push -40 onto stack')

istore_1         comment(`Store the counter that was at top of stack into')
                 comment(`local register 1 for safe keeping, this pops it at')
                 comment(`the same time.')


label(loop)      comment(`Beginning of the for loop')

iload_1          comment('Load the constant 1 as a counter for the loop')
bipush(9)        comment('Push 9 onto the stack')


imul             comment(`Multiplies the 2 numbers in the stack,')
                 comment(`9 and the temperature in degrees Celsius, but also erases them from the stack, ')
                 comment(`which is why we saved just the top one into a register')

iconst_5         comment('push 5 onto the stack')
idiv             comment('Divide the first calculation by 5')

bipush(32)       comment('Push 32 onto the stack')

iadd             comment('Add the two numbers that are on the stack, 32 and the calculation from')
                 comment('dividing (the temperature times 9) by 5.')

istore_2         comment('Store the final temperature in degrees fahrenheit after the conversion')


iconst_1         comment(`Set the print statement to print local register 1, the loop count')
invokevirtual(1) comment(`1 == print with no new line') 

iconst_2         comment(`Set the print statement to print local register 3, the fib number just calculated')
invokevirtual(2) comment(`2 == print with a new line at the end') 

iinc(1, 10)       comment(`Increment local register 1 (our counter) by 1')

iload_1          comment(`Push the loop count onto the stack')
bipush(120)      comment(`Push the loop limit onto the stack')

isub             comment(`Pop top two numbers and subtract the 2nd from the 1st (loop count - 10)')

ifle(loop)       comment(`If the top of stack <= 0 (aka our loop count is <= 10) keep looping. This also pops')
                 comment(`the result of the subtraction so it doesn't mess up our stored temperatures!')

return
