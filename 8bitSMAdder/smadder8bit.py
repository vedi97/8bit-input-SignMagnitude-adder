#Sign magnitude adder with two 4 bit input numbers
#ROM data output 


n = 8	
m = 4	
for i in xrange(256):		#256 is the number of data output will produce
	x = bin(i)[2:].zfill(n)
	l = len(x)
	a = x[0:4].zfill(m)
	b = x[4:8].zfill(m)

#Condition to take care of -0
	if (a == "1000" and b == "1000"):
		sum = bin(int("0000",2) + int("0000", 2))
		out = sum[2:].zfill(m)
		print(out)
		#print (a + " + " + b + " = " + out)

#Condition to take care of -0 in the first 4 bit		
	elif (a == "1000"):
		sum = bin(int("0000",2) + int(b, 2))
		out = sum[2:].zfill(m)
		print(out)
		#print (a + " + " + b + " = " + out)
		

#Condition to take care of -0 in the second 4 bit
	elif (b == "1000"):
		sum = bin(int(a,2) + int("0000", 2))
		out = sum[2:].zfill(m)
		print(out)
		#print (a + " + " + b + " = " + out)


#Condition to take care of overflow		
	else:
		sum = bin(int(a,2) + int(b, 2))
		out = sum[2:].zfill(m)

		if ( len(out) == 5):
			sum = bin(int(a,2) + int(b, 2))
			out = sum[5:].zfill(m)
			print(out)
			#print (a + " + " + b + " = " + out)
		else: 
			print(out)
			#print (a + " + " + b + " = " + out)

	



