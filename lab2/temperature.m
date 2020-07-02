                 comment(`this program prints out a Celsius to Fahrenheit conversion')
                 comment(`table from -40 degrees Celsius to 120 degrees Celsius in increments')
                 comment(`of 10.')

                 comment(`here is our starting temperature in degrees Celsius')
bipush(-40)      comment(`push -40 onto stack')

istore_1         comment(`store the counter that was at top of stack into')
                 comment(`local register 1 for safe keeping, this pops it at')
                 comment(`the same time.')


label(loop)      comment(`beginning of the loop')

iload_1
bipush(9)        comment('push 9 onto the stack')


imul             comment(`Multiplies the 2 numbers in the stack,')
                 comment(`but also erases them from the stack, which is why we saved')
                 comment(`just the top one into a register')

iconst_5         comment('push 5 onto the stack')
idiv             comment('Divide the first calculation by 5')

bipush(32)       comment('push 32 onto the stack')

iadd             comment('add the two numbers that are on the stack')

istore_2         comment('Store the final temperature in degrees fahrenheit after the conversion')


iconst_1         comment(`set the print statement to print local register 1, the loop count')
invokevirtual(1) comment(`1 == print with no new line') 

iconst_2         comment(`set the print statement to print local register 3, the fib number just calculated')
invokevirtual(2) comment(`2 == print with a new line at the end') 

iinc(1, 10)       comment(`increment local register 1 (our counter) by 1')

iload_1          comment(`push the loop count onto the stack')
bipush(120)      comment(`push the loop limit onto the stack')

isub             comment(`pop top two numbers and subtract the 2nd from the 1st (loop count - 10)')

ifle(loop)       comment(`if top of stack <= 0 (our loop count is <= 10) goto loop, this also pops')
                 comment(`the result of the subtraction so it doesn't mess up our fib numbers!')

return
