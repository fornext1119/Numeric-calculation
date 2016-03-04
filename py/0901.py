# coding: Shift_JIS

import math

def f(x):
    return x * x - 2.0

def bisection(a, b):
	while True:
	    # 区間 (a, b) の中点 c = (a + b) / 2
	    c = (a + b) / 2
	    print "%12.10f\t%13.10f" % (c, c - math.sqrt(2))

	    fc = f(c)
	    if (abs(fc) < 0.0000000001):
	        break
	  
	    if (fc < 0):
	        # f(c) < 0 であれば, 解は区間 (c, b) の中に存在
	        a = c
	    else:
	        # f(c) > 0 であれば, 解は区間 (a, c) の中に存在
	        b = c
	return c

a = 1.0
b = 2.0
print "%12.10f" % bisection(a, b)
