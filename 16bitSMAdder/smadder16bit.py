#Sign magnitude adder with two 8 bit input numbers

n = 16
m = 8
for i in xrange(65536):
	x = bin(i)[2:].zfill(n)
	l = len(x)
	a = x[0:8].zfill(m)
	b = x[8:16].zfill(m)

#Condition to take care of -0
	if (a == "10000000" and b == "10000000"):
		sum = bin(int("00000000",2) + int("00000000", 2))
		out = sum[2:].zfill(m)
		print(out)

		#print (a + " + " + b + " = " + out)

#Condition to take care of -0 in the first 8 bit		
	elif (a == "10000000"):
		sum = bin(int("00000000",2) + int(b, 2))
		out = sum[2:].zfill(m)
		print(out)
		#print (a + " + " + b + " = " + out)
		

#Condition to take care of -0 in the second 4 bit
	elif (b == "10000000"):
		sum = bin(int(a,2) + int("00000000", 2))
		out = sum[2:].zfill(m)
		print(out)
		#print (a + " + " + b + " = " + out)


#Condition to take care of overflow	
	else:
		sum = bin(int(a,2) + int(b, 2))
		out = sum[2:].zfill(m)

		if ( len(out) == 9):
			sum = bin(int(a,2) + int(b, 2))
			out = sum[9:].zfill(m)
			print(out)
			#print (a + " + " + b + " = " + out)
		else: 
			print(out)
			#print (a + " + " + b + " = " + out)
		






