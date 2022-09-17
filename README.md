**8bit input & 4bit output sign magnitude adder**

**How it works?**
It takes 8bit input for instance 0001_0010 and separates the one 8bit input to two 4 inputs. in this case the MSB of each 4 input indicates the sign of the binary number. If the sign bit is "0" it means the number is positive (+), and if the sign bit is "1", the number is negative (-). 

For instance: our 8bit input is **0010_1011**
First input a   = 0010 = +2 in decimal
Second input b  = 1011 = -3 in decimal

Sign Magnitude python code adds these two signed binary numbers and it takes cares of the -0 and the overflow that occures in between the output data. 
