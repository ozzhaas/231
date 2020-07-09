comment('Kellen Haas')
comment('CPSC 2310 Sec. 1')
comment('Programming Assignment 1')
comment('7/6/20')


comment('This program will convert a binary number to its equivalent decimal value.')


comment('Loop code in C++							')
comment('	sum = 0;								')
comment('	N = 1101;								')
comment('	newN = 0;								')
comment('	temp = 0;								')
comment('	decVal = 0;								')
comment('	pwrOf2 = 1;								')
comment('		while(N > 0){						')
comment('			decVal = N/10;					')
comment('			newN = decVal; 					')
comment('			decVal = decVal * 10;			')
comment('			temp = (N - decVal) * pwrOf2;	')
comment('			sum += temp;					')
comment('			N = newN;						')
comment('			pwrOf2 = pwrOf2 * 2;			')
comment('		}									')


	comment('Begin variable initialization for the program.')

	word(N, 111)			
	word(decVal, 0)			
	word(pwrOf2, 1)			
	word(temp, 0)			
	word(ten, 10)			
	word(two, 2)			
	word(sum, 1)			
	word(zero, 0)			
	word(newN, 0)			

label(start)
	load(zero)				comment('Change sums value to zero.')
	store(sum)

label(loop)					comment('Begin the while loop')
	load(N)					comment('N = 1101 to begin with')

	ble0(done)				comment('Continue to loop while N is greater than 0')
							comment('and if N is less than or equal to 0, exit the loop.')

	load(N)					comment('N = 1101')
	div(ten)				comment('1101/10 = 110; this gets rid of the digit in pwrOf2s place.')
	store(newN)				comment('newN = 110')
	load(newN)				
	mul(ten)				comment('Multiply newN by 10; 110 * 10 = 1100')
	store(decVal)			comment('Store the new number so it is ready for subtraction from the original.')
	load(N)					comment('N = 1101')
	sub(decVal)				comment('Subtract decVal from N to get the value of the digit in pwrOf2s place.')
	mul(pwrOf2)				comment('Multiply that digit by the value of pwrOf2.')
	store(temp)				comment('Store that value in temp.')
	load(sum)				comment('sum = 0')
	add(temp)				comment('Add temp to the sum and then store the sum.')
	store(sum)

	load(newN)				comment('Load the new N which will contain one less digit than the original number') 
	store(N)				comment('for every time the loop iterates through, and save it in N to move left in')
							comment('the digits of the number.')

	load(pwrOf2)			comment('Increase pwrOf2s value to match the digit place that we are on.')
	mul(two)
	store(pwrOf2)
	ba(loop)				comment('Continue looping until N is less than or equal to 0.')	


label(done)
	print(sum)				comment('Print the final value of sum which is equivalent to the decimal value of the number.')
	halt

end(start)	



