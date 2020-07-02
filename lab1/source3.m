comment(`  code that implements the loop with ble0 at top of loop  ')

comment(`  code that implements the loop                       ')
comment(`    sum = 0;                                          ')
comment('    i = 0;                                            ')
comment('    j = 10;                                           ')
comment(`    for (i = 1; i <= j; i++)) {                       ')
comment(`       sum = sum + i;                                 ')  
comment('		i++;                                           ')
comment(`    }                                                 ')

   word(sum,0)
   word(i,1)
   word(j,10)
   word(zero,0)
   word(one,1)
   word(ten,10)

label(start)

   load(zero)  comment(`  sum = 0         ACC <- memory[zero]  ')
   store(sum)  comment(`                  memory[sum] <- ACC   ')
   load(one)   comment(`  i = 1                                ')
   store(i)

label(loop)

   sub(j)      comment(`  branch to done if i - j <= 0         ')
   bgt0(done)

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
