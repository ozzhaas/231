comment(`  code that implements the loop with ble0 at top of loop  ')

comment(`  code that implements the loop                       ')
comment(`    sum = 0;                                          ')
comment('    i = 0;                                            ')
comment(`    while(i < 10) {                                   ')
comment(`       sum = sum + i;                                 ')  
comment('		i++;                                   ')
comment(`    }                                                 ')

   word(sum,0)
   word(i,0)
   word(zero,0)
   word(one,1)
   word(ten,10)

label(start)

   load(zero)  comment(`  sum = 0         ACC <- memory[zero]  ')
   store(sum)  comment(`                  memory[sum] <- ACC   ')
   load(zero)  comment(`  i = 0                                ')
   store(i)

label(loop)

   load(ten)   comment(`  branch to done if 10 - i < 0         ')
   sub(i)
   ble0(done)

   load(sum)   comment(`  sum = sum + i                        ')
   add(i)
   store(sum)

   load(i)     comment(`  i = i + 1                            ')
   add(one)
   store(i)

   ba(loop)    comment(`  unconditionally go back to loop      ')

label(done)

   print(sum)
   halt

comment(`  start execution at label start  ')

   end(start)
