comment('Kellen Haas')
comment('CPSC 2310 Sec. 1')
comment('Programming Assignment 1')
comment('7/6/20')


comment('This program will convert a binary number to its equivalent decimal value.')

	word(N, 1101)
	word(decVal, 0)
	word(pwrOf2, 1)
	word(temp, 0)
	word(two, 2)
	word(sum, 1)
	word(zero, 0)

label(start)
	load(zero)
	store(sum)
	

label(loop)
	load(N)
	div(10)
	bgt0(done)
	store(temp)
	load(N)
	sub(temp)
	store(temp)
	load(pwrOf2)
	mul(temp)
	store(temp)
	load(sum)
	add(temp)
	store(sum)

	load(pwrOf2)
	mul(two)
	store(pwrOf2)
	ba(loop)	


label(done)
	print(sum)
	halt

end(start)	



